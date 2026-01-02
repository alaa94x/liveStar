import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import '../models/live_stream_model.dart';
import '../theme/app_colors.dart';

class LiveCard extends StatefulWidget {
  final LiveStream stream;
  final bool autoPlay; // Whether to auto-play video when visible

  const LiveCard({
    super.key,
    required this.stream,
    this.autoPlay = false, // Default to false for performance
  });

  @override
  State<LiveCard> createState() => _LiveCardState();
}

class _LiveCardState extends State<LiveCard> {
  VideoPlayerController? _controller;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;
  bool _isPreviewing = false; // For hover/long press preview

  @override
  void initState() {
    super.initState();
    // Don't auto-initialize video, only on preview request
  }

  Future<void> _initializeVideo({bool autoPlay = false}) async {
    // Only initialize video if videoUrl is available
    if (widget.stream.videoUrl == null || widget.stream.videoUrl!.isEmpty) {
      return;
    }

    // If already initialized, just play
    if (_controller != null && _isVideoInitialized) {
      if (autoPlay && mounted) {
        _controller!.play();
      }
      return;
    }

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.stream.videoUrl!),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true, // Allow mixing with other audio
        ),
      );

      await _controller!.initialize();
      
      if (!mounted) {
        _controller?.dispose();
        _controller = null;
        return;
      }
      
      _controller!.setLooping(true);
      _controller!.setVolume(0.0); // Mute by default

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
          _hasVideoError = false;
        });

        // Auto-play if enabled
        if (autoPlay && mounted) {
          _controller!.play();
        }
      }
    } catch (e) {
      // Video failed to load, fallback to thumbnail
      _controller?.dispose();
      _controller = null;
      
      if (mounted) {
        setState(() {
          _hasVideoError = true;
          _isVideoInitialized = false;
        });
      }
    }
  }

  void _startPreview() {
    if (!mounted) return;
    if (!_isPreviewing && widget.stream.videoUrl != null && widget.stream.videoUrl!.isNotEmpty) {
      setState(() {
        _isPreviewing = true;
      });
      _initializeVideo(autoPlay: true);
    }
  }

  void _stopPreview() {
    if (!mounted) return;
    if (_isPreviewing) {
      setState(() {
        _isPreviewing = false;
      });
      _controller?.pause();
    }
  }


  @override
  void dispose() {
    // Stop any active preview
    if (_isPreviewing) {
      _controller?.pause();
    }
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    // Check if widget is still mounted before building
    if (!mounted) {
      return const SizedBox.shrink();
    }
    
    final hasLiveVideo = widget.stream.videoUrl != null &&
        widget.stream.videoUrl!.isNotEmpty &&
        !_hasVideoError;

    // Safely get aspect ratio for video
    double? videoAspectRatio;
    bool canShowVideo = false;
    if (hasLiveVideo && 
        _isVideoInitialized && 
        _controller != null && 
        _isPreviewing) {
      try {
        if (_controller!.value.isInitialized && _controller!.value.aspectRatio > 0) {
          videoAspectRatio = _controller!.value.aspectRatio;
          canShowVideo = true;
        }
      } catch (e) {
        // Controller might be disposed, don't show video
        canShowVideo = false;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!mounted) return;
        
        // Stop preview before navigating (but don't dispose here - let dispose() handle it)
        if (_isPreviewing && mounted) {
          _controller?.pause();
          if (mounted) {
            setState(() {
              _isPreviewing = false;
            });
          }
        }
        
        // Navigate immediately
        if (hasLiveVideo) {
          context.push('/live/${widget.stream.id}');
        } else {
          // If no video, still navigate (might be a recorded stream)
          context.push('/live/${widget.stream.id}');
        }
      },
      onLongPressStart: (_) {
        if (!mounted) return;
        // Start preview on long press
        if (hasLiveVideo) {
          _startPreview();
        }
      },
      onLongPressEnd: (_) {
        if (!mounted) return;
        // Stop preview when long press ends
        _stopPreview();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Video or Thumbnail
              if (canShowVideo && videoAspectRatio != null)
                // Video Player (only shown during preview)
                AspectRatio(
                  aspectRatio: videoAspectRatio!,
                  child: VideoPlayer(_controller!),
                )
              else
                // Thumbnail fallback
                CachedNetworkImage(
                  imageUrl: widget.stream.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.cardBackground,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.cardBackground,
                    child: const Icon(Icons.error, color: Colors.white),
                  ),
                ),

              // Preview indicator (only show when previewing)
              if (_isPreviewing && hasLiveVideo)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryPink,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

              // Gradient Overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.cardGradient,
                ),
              ),

              // Streamer Avatar
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.stream.streamerPhoto,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.cardBackground,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Live Badge (only show if there's an actual live video)
              if (hasLiveVideo)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.liveRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'LIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Viewer Count
              Positioned(
                top: 48,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.stream.viewerCount >= 1000
                            ? '${(widget.stream.viewerCount / 1000).toStringAsFixed(1)}K'
                            : widget.stream.viewerCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Title
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    widget.stream.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

