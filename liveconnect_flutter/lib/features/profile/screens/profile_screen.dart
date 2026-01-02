import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data_service.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/providers/user_provider.dart';
import 'followers_screen.dart';
import 'following_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String? userId;

  const ProfileScreen({
    super.key,
    this.userId,
  });

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Map<String, dynamic>? _profile;
  List<Map<String, dynamic>> _pastStreams = [];
  bool _isLoading = true;
  AppException? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final profile = await MockDataService.getUserProfile();
      final streams = await MockDataService.getVideos();
      setState(() {
        _profile = profile;
        _pastStreams = streams;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e is AppException
            ? e
            : const UnknownException('Failed to load profile');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: const LoadingWidget(message: 'Loading profile...'),
        bottomNavigationBar: const BottomNavBar(),
      );
    }

    if (_error != null || _profile == null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: ErrorDisplay(
          error: _error ?? const UnknownException('Failed to load profile'),
          onRetry: _loadData,
          title: 'Failed to load profile',
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(_profile!),

              const SizedBox(height: 24),

              // Stats
              _buildStats(_profile!),

              const SizedBox(height: 24),

              // Actions
              _buildActions(context),

              const SizedBox(height: 32),

              // Past Streams / Videos
              _buildPastStreamsSection(_pastStreams),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildProfileHeader(Map<String, dynamic> profile) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              SafeAvatar(
                imageUrl: profile['avatar'],
                radius: 50,
                fallbackText: profile['name']?.substring(0, 1) ?? '?',
              ),
              if (profile['isLive'] == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.liveRed,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.backgroundDark,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.fiber_manual_record,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                profile['name'],
                style: AppTextStyles.headlineMedium,
              ),
              if (profile['isVerified'] == true) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.verified,
                  color: AppColors.primaryPurple,
                  size: 20,
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            profile['username'],
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 8),
          Text(
            profile['bio'],
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStats(Map<String, dynamic> profile) {
    final isOwnProfile = widget.userId == null;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Followers',
            profile['followers'],
            onTap: () => context.push('/profile/${widget.userId ?? 'current'}/followers'),
          ),
          _buildStatItem(
            'Following',
            profile['following'],
            onTap: () => context.push('/profile/${widget.userId ?? 'current'}/following'),
          ),
          _buildStatItem('Likes', profile['likes']),
          _buildStatItem('Coins', profile['coins']),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value, {VoidCallback? onTap}) {
    final widget = GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            _formatNumber(value),
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );

    if (onTap != null) {
      return widget;
    }
    return Column(
      children: [
        Text(
          _formatNumber(value),
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildActions(BuildContext context) {
    final isOwnProfile = widget.userId == null;
    final isFollowing = ref.watch(userFollowStateProvider(widget.userId ?? ''));
    
    if (isOwnProfile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GradientButton(
                    text: 'Edit Profile',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.push('/settings'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: AppColors.primaryPurple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Settings',
                      style: AppTextStyles.buttonMedium.copyWith(
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.push('/discover'),
              icon: const Icon(Icons.person_add, size: 18),
              label: const Text('Discover People'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                side: BorderSide(color: AppColors.primaryPink),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Other user's profile - show Follow/Unfollow button
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: isFollowing
                ? OutlinedButton(
                    onPressed: () {
                      ref.read(userFollowStateProvider(widget.userId!).notifier).toggleFollow();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: AppColors.textSecondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Following',
                      style: AppTextStyles.buttonMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  )
                : GradientButton(
                    text: 'Follow',
                    onPressed: () {
                      ref.read(userFollowStateProvider(widget.userId!).notifier).toggleFollow();
                    },
                  ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              // Share profile
            },
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.cardBackground,
              padding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              // More options
            },
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.cardBackground,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastStreamsSection(List<Map<String, dynamic>> streams) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Past Streams / Videos',
              style: AppTextStyles.headlineMedium,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: streams.length,
            itemBuilder: (context, index) {
              final stream = streams[index];
              return _buildVideoCard(stream);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, dynamic> video) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thumbnail
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: SafeImage(
                      imageUrl: video['thumbnail'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Duration badge
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        video['duration'],
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title'],
                      style: AppTextStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatNumber(video['views']),
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
