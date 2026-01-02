import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data_service.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/live_stream_model.dart';
import '../../../core/models/gift_model.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/widgets/floating_gift.dart';
import '../../../core/widgets/floating_reaction.dart';
import '../../../core/widgets/comment_overlay.dart';
import '../../../core/widgets/gift_panel.dart';
import '../../../core/widgets/custom_toast.dart';
import '../../../core/models/reaction_model.dart';
import '../../../core/errors/app_exceptions.dart';
import 'package:go_router/go_router.dart';

class LiveStreamScreen extends StatefulWidget {
  final String streamId;

  const LiveStreamScreen({
    super.key,
    required this.streamId,
  });

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> with TickerProviderStateMixin {
  // PageView for swipe navigation
  PageController? _pageController;
  List<LiveStream> _allStreams = [];
  int _currentStreamIndex = 0;
  bool _isLoadingStreams = true;

  // Current stream state
  VideoPlayerController? _controller;
  LiveStream? _stream;
  bool _isLoading = true;
  bool _isVideoInitialized = false;
  AppException? _error;

  // Comments
  List<Map<String, dynamic>> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  // Gifts
  bool _showGiftPanel = false;
  String _selectedGiftCategory = 'all';
  List<Map<String, dynamic>> _floatingGifts = []; // {id, emoji, startX}
  int _coinBalance = 3450; // Mock coin balance
  int _totalGiftsReceived = 0; // Track total gifts received for this stream
  final Map<String, Timer> _giftTimers = {}; // Track timers for cleanup

  // Reactions
  List<Reaction> _floatingReactions = [];
  final Map<String, Timer> _reactionTimers = {};

  // Likes
  int _likes = 0;
  bool _isLiked = false;

  // Animation controllers
  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _coinBalance = MockData.mockUserProfile['coins'] as int;
    _comments = List.from(MockData.mockComments);
    
    // Initialize animation controllers
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );
    
    _fadeController.forward();
    _scaleController.forward();
    
    _loadAllStreams();
  }

  @override
  void dispose() {
    // Cancel all gift timers
    for (var timer in _giftTimers.values) {
      timer.cancel();
    }
    _giftTimers.clear();
    
    // Stop and dispose controller first
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    
    // Dispose page controller
    _pageController?.dispose();
    
    // Dispose text controller
    _commentController.dispose();
    
    // Dispose animation controllers
    _pulseController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    
    super.dispose();
  }

  Future<void> _loadAllStreams() async {
    if (!mounted) return;
    setState(() {
      _isLoadingStreams = true;
    });

    try {
      final streams = await MockDataService.getLiveStreams();
      
      if (!mounted) return;
      
      // Find current stream index
      int currentIndex = 0;
      for (int i = 0; i < streams.length; i++) {
        if (streams[i].id == widget.streamId) {
          currentIndex = i;
          break;
        }
      }

      if (!mounted) return;
      
      setState(() {
        _allStreams = streams;
        _currentStreamIndex = currentIndex;
        _isLoadingStreams = false;
      });

      // Initialize PageController with current index
      if (!mounted) return;
      _pageController = PageController(initialPage: currentIndex);
      
      // Load initial stream
      if (mounted) {
        _loadStream(streams[currentIndex]);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoadingStreams = false;
        _error = e is AppException
            ? e
            : const UnknownException('Failed to load streams');
      });
    }
  }

  void _onPageChanged(int index) {
    if (!mounted || index < 0 || index >= _allStreams.length) return;
    
    // Dispose current video controller
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    
    // Clear state
    if (mounted) {
      setState(() {
        _currentStreamIndex = index;
        _isVideoInitialized = false;
        _floatingGifts.clear();
        _showGiftPanel = false;
        _comments = List.from(MockData.mockComments);
        _isLiked = false; // Reset like state
      });
    }
    
    // Cancel all timers
    for (var timer in _giftTimers.values) {
      timer.cancel();
    }
    _giftTimers.clear();
    
    for (var timer in _reactionTimers.values) {
      timer.cancel();
    }
    _reactionTimers.clear();
    
    // Load new stream
    _loadStream(_allStreams[index]);
  }

  Future<void> _loadStream(LiveStream stream) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (!mounted) return;
      
      if (mounted) {
        setState(() {
          _stream = stream;
          _likes = stream.totalLikes;
          _totalGiftsReceived = stream.totalGiftsReceived;
        });
      }

      // Initialize video if available
      if (stream.videoUrl != null && stream.videoUrl!.isNotEmpty) {
        await _initializeVideo(stream.videoUrl!);
      } else {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e is AppException
            ? e
            : const UnknownException('Failed to load stream');
        _isLoading = false;
      });
    }
  }

  Future<void> _initializeVideo(String videoUrl) async {
    // Store controller reference to check if it's still valid later
    VideoPlayerController? controller;
    try {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false,
          allowBackgroundPlayback: false,
        ),
      );

      _controller = controller; // Set the instance variable

      // Add timeout for initialization
      await controller.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          // Don't throw if widget is already disposed
          if (!mounted) return;
          throw TimeoutException('Video initialization timed out');
        },
      );

      // Check mounted after async operation
      if (!mounted || _controller != controller) {
        controller.dispose();
        return;
      }

      // Check if video is actually playable
      if (!controller.value.isInitialized) {
        if (mounted && _controller == controller) {
          controller.dispose();
          _controller = null;
        }
        return;
      }

      // Set looping and play only if still mounted
      if (mounted && _controller == controller) {
        controller.setLooping(true);
        controller.play();

        setState(() {
          _isVideoInitialized = true;
          _isLoading = false;
        });
      } else {
        // Widget was disposed, clean up
        controller.dispose();
        _controller = null;
      }
    } catch (e) {
      // Only clean up if this is still the active controller
      if (controller != null && _controller == controller) {
        controller.dispose();
        _controller = null;

        // Only update state if still mounted
        if (mounted) {
          setState(() {
            _isVideoInitialized = false;
            _isLoading = false;
            // Don't show error if video fails - just fallback to thumbnail
            // _error = const ConnectionException('Failed to load video');
          });
        }
      }
    }
  }

  void _handleLike() {
    if (!mounted) return;
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    setState(() {
      _isLiked = !_isLiked;
      _likes += _isLiked ? 1 : -1;
    });
    
    // Add floating reaction
    if (_isLiked) {
      _addReaction('❤️', 0.8, 0.5);
    }
    
    // Animate button
    _scaleController.reset();
    _scaleController.forward();
  }

  void _addReaction(String emoji, double x, double y) {
    if (!mounted) return;
    final reaction = Reaction.fromEmoji(emoji, x, y);
    
    setState(() {
      _floatingReactions.add(reaction);
    });

    final timer = Timer(const Duration(milliseconds: 2000), () {
      _reactionTimers.remove(reaction.id);
      if (mounted) {
        setState(() {
          _floatingReactions.removeWhere((r) => r.id == reaction.id);
        });
      }
    });
    
    _reactionTimers[reaction.id] = timer;
  }

  void _removeReaction(String reactionId) {
    _reactionTimers[reactionId]?.cancel();
    _reactionTimers.remove(reactionId);
    if (mounted) {
      setState(() {
        _floatingReactions.removeWhere((r) => r.id == reactionId);
      });
    }
  }

  void _sendComment() {
    if (!mounted) return;
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _comments.add({
        'id': _comments.length + 1,
        'user': 'You',
        'message': text,
        'avatar': MockData.mockUserProfile['avatar'],
        'timestamp': DateTime.now(),
      });
      _commentController.clear();
    });

    // Auto-scroll would be handled here if we had a scrollable list
  }

  void _sendGift(Gift gift) {
    if (!mounted) return;
    
    // Check coin balance
    if (_coinBalance < gift.price) {
      CustomToast.show(
        context,
        message: 'Insufficient coins!',
        backgroundColor: AppColors.destructive,
        textColor: Colors.white,
      );
      return;
    }

    // Batch all state updates into a single setState call
    if (!mounted) return;
    
    // Prepare gift data
    final giftId = '${DateTime.now().millisecondsSinceEpoch}-${gift.id}';
    final startX = 20.0 + (60.0 * (gift.id.hashCode % 100) / 100); // Random position 20-80%

    // Single setState for all updates
    setState(() {
      // Deduct coins and track gift received
      _coinBalance -= gift.price;
      _totalGiftsReceived += gift.price;
      
      // Add floating gift animation
      _floatingGifts.add({
        'id': giftId,
        'emoji': gift.emoji,
        'startX': startX,
      });
      
      // Add gift message to comments
      _comments.add({
        'id': _comments.length + 1,
        'user': 'You',
        'message': 'sent ${gift.emoji} ${gift.name}',
        'avatar': MockData.mockUserProfile['avatar'],
        'timestamp': DateTime.now(),
        'isGift': true,
      });
      
      // Close gift panel
      _showGiftPanel = false;
    });

    // Show success toast (outside setState) - simplified without icon to avoid overlap
    CustomToast.show(
      context,
      message: 'Gift sent! ${gift.emoji}',
      backgroundColor: AppColors.primaryPink,
      textColor: Colors.white,
    );

    // Remove gift after animation - use a timer that can be cancelled
    // Note: The FloatingGift widget will also call onAnimationComplete
    // so this is a backup cleanup
    final timer = Timer(const Duration(milliseconds: 3000), () {
      // Cancel timer if widget is disposed
      if (_giftTimers.containsKey(giftId)) {
        _giftTimers.remove(giftId);
      }
      
      if (mounted) {
        setState(() {
          _floatingGifts.removeWhere((g) => g['id'] == giftId);
        });
      }
    });
    
    // Store timer for cleanup
    _giftTimers[giftId] = timer;
  }

  void _removeFloatingGift(String giftId) {
    // Double-check mounted before any operations
    if (!mounted) return;
    
    // Cancel timer if it exists
    final timer = _giftTimers.remove(giftId);
    timer?.cancel();
    
    // Check if the gift still exists before trying to remove it
    if (!_floatingGifts.any((g) => g['id'] == giftId)) {
      return; // Already removed
    }
    
    if (mounted) {
      setState(() {
        _floatingGifts.removeWhere((g) => g['id'] == giftId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading all streams
    if (_isLoadingStreams || _pageController == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: CircularProgressIndicator(color: AppColors.primaryPink),
        ),
      );
    }

    // Error loading streams
    if (_allStreams.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: ErrorDisplay(
          error: _error ?? const UnknownException('Failed to load streams'),
          onRetry: _loadAllStreams,
          title: 'Failed to load streams',
        ),
      );
    }

    // Wrap in PageView for vertical swipe navigation
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _allStreams.length,
        itemBuilder: (context, index) {
          return _buildStreamPlayer(index);
        },
      ),
    );
  }

  Widget _buildStreamPlayer(int index) {
    // If this is not the current page, show thumbnail
    if (index != _currentStreamIndex) {
      return SizedBox.expand(
        child: CachedNetworkImage(
          imageUrl: _allStreams[index].thumbnail,
          fit: BoxFit.cover,
        ),
      );
    }

    // Loading current stream
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Show thumbnail while loading
            if (_stream != null)
              SizedBox.expand(
                child: CachedNetworkImage(
                  imageUrl: _stream!.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            const Center(
              child: CircularProgressIndicator(color: AppColors.primaryPink),
            ),
          ],
        ),
      );
    }

    // Error loading current stream
    if (_error != null || _stream == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: ErrorDisplay(
          error: _error ?? const UnknownException('Stream not found'),
          onRetry: () => _loadStream(_allStreams[index]),
          title: 'Failed to load stream',
        ),
      );
    }

    final quickGifts = AvailableGifts.quickGifts;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video or Thumbnail
          if (_isVideoInitialized && _controller != null) 
            Builder(
              builder: (context) {
                // Safely check controller state
                if (!_controller!.value.isInitialized) {
                  return SizedBox.expand(
                    child: CachedNetworkImage(
                      imageUrl: _stream!.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                
                try {
                  final size = _controller!.value.size;
                  return SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: size.width,
                        height: size.height,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                  );
                } catch (e) {
                  // Fallback to thumbnail if controller is disposed
                  return SizedBox.expand(
                    child: CachedNetworkImage(
                      imageUrl: _stream!.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            )
          else
            SizedBox.expand(
              child: CachedNetworkImage(
                imageUrl: _stream!.thumbnail,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: AppColors.cardBackground,
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.white, size: 48),
                  ),
                ),
              ),
            ),

          // Floating Gifts
          ..._floatingGifts.map((gift) {
            return FloatingGift(
              emoji: gift['emoji'] as String,
              startX: gift['startX'] as double,
              onAnimationComplete: () => _removeFloatingGift(gift['id'] as String),
            );
          }),

          // Floating Reactions
          ..._floatingReactions.map((reaction) {
            return FloatingReaction(
              reaction: reaction,
              onComplete: () => _removeReaction(reaction.id),
            );
          }),

          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          // Comments overlay (right side) - as Stack sibling
          CommentOverlay(
            comments: _comments.map((c) => CommentItem(
              id: c['id'].toString(),
              userId: c['user'] ?? '',
              userName: c['user'] ?? '',
              avatar: c['avatar'] ?? '',
              message: c['message'] ?? '',
              timestamp: c['timestamp'] is DateTime 
                  ? c['timestamp'] as DateTime
                  : DateTime.now(),
              isGift: c['isGift'] == true,
              giftEmoji: c['giftEmoji'],
            )).toList(),
            maxVisible: 4,
            padding: const EdgeInsets.only(right: 16, bottom: 200),
          ),

          // Right side actions (Like, Gift buttons) - moved to Stack sibling
          Positioned(
            right: 16,
            bottom: 220,
            child: Column(
              children: [
                // Like button
                _buildActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  label: _formatCount(_likes),
                  color: _isLiked ? AppColors.primaryPink : Colors.white,
                  onTap: _handleLike,
                  isGradient: _isLiked,
                ),
                const SizedBox(height: 12),
                // Reactions button
                _buildActionButton(
                  icon: Icons.emoji_emotions,
                  label: 'React',
                  color: Colors.white,
                  onTap: () => _showReactionsMenu(context),
                  isGradient: false,
                ),
                const SizedBox(height: 12),
                // Gift button
                _buildActionButton(
                  icon: Icons.card_giftcard,
                  label: 'Gift',
                  color: Colors.white,
                  onTap: () {
                    if (!mounted) return;
                    setState(() {
                      _showGiftPanel = true;
                    });
                  },
                  isGradient: true,
                ),
                const SizedBox(height: 12),
                // Coin balance
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.8),
                        Colors.black.withValues(alpha: 0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.coinGold.withValues(alpha: 0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.coinGold.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.coinGold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.monetization_on,
                          color: AppColors.coinGold,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _coinBalance.toString(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.coinGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Top bar with enhanced glassmorphism
          FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.85),
                      Colors.black.withValues(alpha: 0.6),
                      Colors.black.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Enhanced avatar with pulse animation
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.push('/profile/${_stream!.id}');
                          },
                          child: AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: AppColors.primaryGradient,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryPink.withValues(alpha: 0.6 * _pulseAnimation.value),
                                        blurRadius: 16 * _pulseAnimation.value,
                                        offset: const Offset(0, 4),
                                        spreadRadius: 2 * _pulseAnimation.value,
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(2.5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(2.5),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: _stream!.streamerPhoto,
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) => Container(
                                          color: AppColors.cardBackground,
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 14),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            context.push('/profile/${_stream!.id}');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _stream!.streamerName,
                                    style: AppTextStyles.titleMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withValues(alpha: 0.5),
                                          blurRadius: 4,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Note: isVerified would come from user profile, not stream
                                  // For now, we'll show verified badge based on streamer name pattern
                                  if (_stream!.streamerName.contains('Rose') || 
                                      _stream!.streamerName.contains('Lee') ||
                                      _stream!.streamerName.contains('Star')) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryPurple,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primaryPurple.withValues(alpha: 0.4),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  // Live indicator
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.liveRed,
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.liveRed.withValues(alpha: 0.6),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'LIVE',
                                          style: AppTextStyles.caption.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.people,
                                    size: 12,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatCount(_stream!.viewerCount),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (_stream!.startTime != null) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '• ${_stream!.duration}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: Colors.white.withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                  if (_totalGiftsReceived > 0) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.coinGold.withValues(alpha: 0.3),
                                            AppColors.coinGold.withValues(alpha: 0.2),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.coinGold.withValues(alpha: 0.4),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.card_giftcard,
                                            size: 11,
                                            color: AppColors.coinGold,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            _formatCount(_totalGiftsReceived),
                                            style: AppTextStyles.bodySmall.copyWith(
                                              color: AppColors.coinGold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Enhanced close button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom controls (message and gift bars) with enhanced glassmorphism
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.85),
                        Colors.black.withValues(alpha: 0.95),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Enhanced quick gift bar with animations
                    if (!_showGiftPanel)
                      Container(
                        height: 80,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: quickGifts.length,
                          itemBuilder: (context, index) {
                            final gift = quickGifts[index];
                            final canAfford = _coinBalance >= gift.price;
                            return TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: Duration(milliseconds: 300 + (index * 50)),
                              curve: Curves.easeOutBack,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Opacity(
                                    opacity: value,
                                    child: GestureDetector(
                                      onTap: canAfford
                                          ? () {
                                              HapticFeedback.mediumImpact();
                                              _sendGift(gift);
                                            }
                                          : null,
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        margin: const EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                          gradient: canAfford
                                              ? LinearGradient(
                                                  colors: [
                                                    Colors.white.withValues(alpha: 0.2),
                                                    Colors.white.withValues(alpha: 0.1),
                                                    Colors.white.withValues(alpha: 0.05),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,
                                          color: canAfford
                                              ? null
                                              : Colors.white.withValues(alpha: 0.05),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: canAfford
                                                ? AppColors.coinGold.withValues(alpha: 0.5)
                                                : Colors.white.withValues(alpha: 0.15),
                                            width: 1.5,
                                          ),
                                          boxShadow: canAfford
                                              ? [
                                                  BoxShadow(
                                                    color: AppColors.coinGold.withValues(alpha: 0.3),
                                                    blurRadius: 12,
                                                    offset: const Offset(0, 4),
                                                    spreadRadius: 1,
                                                  ),
                                                  BoxShadow(
                                                    color: Colors.black.withValues(alpha: 0.2),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ]
                                              : [
                                                  BoxShadow(
                                                    color: Colors.black.withValues(alpha: 0.1),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                        ),
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              gradient: canAfford
                                                  ? LinearGradient(
                                                      colors: [
                                                        AppColors.coinGold.withValues(alpha: 0.2),
                                                        AppColors.coinGold.withValues(alpha: 0.1),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                    )
                                                  : null,
                                              color: canAfford
                                                  ? null
                                                  : Colors.transparent,
                                              shape: BoxShape.circle,
                                              boxShadow: canAfford
                                                  ? [
                                                      BoxShadow(
                                                        color: AppColors.coinGold.withValues(alpha: 0.2),
                                                        blurRadius: 8,
                                                        offset: const Offset(0, 2),
                                                      ),
                                                    ]
                                                  : null,
                                            ),
                                            child: Opacity(
                                              opacity: canAfford ? 1.0 : 0.4,
                                              child: Text(
                                                gift.emoji,
                                                style: const TextStyle(fontSize: 36),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                    // Enhanced comment input with glassmorphism
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.2),
                                  Colors.white.withValues(alpha: 0.1),
                                  Colors.white.withValues(alpha: 0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: AppColors.primaryPink.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                hintText: 'Say something nice...',
                                hintStyle: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                filled: false,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 16,
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              onSubmitted: (_) => _sendComment(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              _sendComment();
                            },
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryPink.withValues(alpha: 0.5),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),

          // Gift Panel (bottom sheet)
          if (_showGiftPanel)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GiftPanel(
                gifts: AvailableGifts.allGifts,
                selectedCategory: _selectedGiftCategory,
                coinBalance: _coinBalance,
                onGiftSelected: _sendGift,
                onCategoryChanged: (category) {
                  if (!mounted) return;
                  if (mounted) {
                    setState(() {
                      _selectedGiftCategory = category;
                    });
                  }
                },
                onClose: () {
                  if (!mounted) return;
                  if (mounted) {
                    setState(() {
                      _showGiftPanel = false;
                    });
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Map<String, dynamic> comment) {
    final isGift = comment['isGift'] == true;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: isGift
            ? LinearGradient(
                colors: [
                  AppColors.primaryPink.withValues(alpha: 0.3),
                  AppColors.primaryPurple.withValues(alpha: 0.2),
                ],
              )
            : null,
        color: isGift ? null : Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(22),
        border: isGift
            ? Border.all(
                color: AppColors.primaryPink.withValues(alpha: 0.4),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: comment['avatar'] ?? '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: AppColors.cardBackground,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              '${comment['user']}: ${comment['message']}',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: isGift ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isGradient = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(28),
        child: AnimatedBuilder(
          animation: _scaleController,
          builder: (context, child) {
            return Transform.scale(
              scale: label == _formatCount(_likes) && _isLiked ? _scaleAnimation.value : 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isGradient
                      ? LinearGradient(
                          colors: [
                            color.withValues(alpha: 0.4),
                            color.withValues(alpha: 0.25),
                            color.withValues(alpha: 0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: color.withValues(alpha: isGradient ? 0.5 : 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: isGradient ? 0.4 : 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                      spreadRadius: isGradient ? 1 : 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: isGradient
                            ? LinearGradient(
                                colors: [
                                  color.withValues(alpha: 0.3),
                                  color.withValues(alpha: 0.2),
                                ],
                              )
                            : null,
                        color: isGradient ? null : color.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                        boxShadow: isGradient
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  void _showReactionsMenu(BuildContext context) {
    final reactions = ['❤️', '😂', '😮', '🔥', '👏', '👍'];
    final screenSize = MediaQuery.of(context).size;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Reactions',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: reactions.map((emoji) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    final x = (screenSize.width * (reactions.indexOf(emoji) + 1) / (reactions.length + 1));
                    final y = screenSize.height * 0.5;
                    _addReaction(emoji, x, y);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceDark,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryPink.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
