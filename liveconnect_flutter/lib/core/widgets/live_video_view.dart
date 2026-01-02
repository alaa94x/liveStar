import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';

/// Reusable widget for live video playback with fallback
class LiveVideoView extends StatefulWidget {
  final String? videoUrl;
  final String thumbnailUrl;
  final bool autoPlay;
  final bool looping;
  final double volume;
  final BoxFit fit;
  final VoidCallback? onVideoReady;
  final VoidCallback? onVideoError;

  const LiveVideoView({
    super.key,
    this.videoUrl,
    required this.thumbnailUrl,
    this.autoPlay = true,
    this.looping = true,
    this.volume = 0.0,
    this.fit = BoxFit.cover,
    this.onVideoReady,
    this.onVideoError,
  });

  @override
  State<LiveVideoView> createState() => _LiveVideoViewState();
}

class _LiveVideoViewState extends State<LiveVideoView> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  Timer? _initTimer;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    if (widget.videoUrl == null || widget.videoUrl!.isEmpty) return;

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl!),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      // Add timeout for initialization
      _initTimer = Timer(const Duration(seconds: 15), () {
        if (!_isInitialized && mounted) {
          _handleError();
        }
      });

      await _controller!.initialize();

      if (!mounted) {
        _controller?.dispose();
        return;
      }

      if (!_controller!.value.isInitialized) {
        _handleError();
        return;
      }

      _controller!.setLooping(widget.looping);
      _controller!.setVolume(widget.volume);

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _hasError = false;
        });

        if (widget.autoPlay) {
          _controller!.play();
        }

        widget.onVideoReady?.call();
      }
    } catch (e) {
      _handleError();
    }
  }

  void _handleError() {
    if (mounted) {
      setState(() {
        _hasError = true;
        _isInitialized = false;
      });
      widget.onVideoError?.call();
    }
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _initTimer?.cancel();
    _controller?.pause();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show video if initialized, otherwise show thumbnail
    if (_isInitialized && _controller != null && !_hasError) {
      try {
        return SizedBox.expand(
          child: FittedBox(
            fit: widget.fit,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
        );
      } catch (e) {
        return _buildThumbnail();
      }
    }

    return _buildThumbnail();
  }

  Widget _buildThumbnail() {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: widget.thumbnailUrl,
            fit: widget.fit,
            errorWidget: (context, url, error) => Container(
              color: AppColors.cardBackground,
              child: const Center(
                child: Icon(Icons.error, color: Colors.white, size: 48),
              ),
            ),
          ),
          if (_hasError)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Video unavailable',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Public methods for external control
  void play() {
    _controller?.play();
  }

  void pause() {
    _controller?.pause();
  }

  void togglePlayPause() {
    if (_controller?.value.isPlaying ?? false) {
      pause();
    } else {
      play();
    }
  }

  bool get isPlaying => _controller?.value.isPlaying ?? false;
  bool get isReady => _isInitialized && !_hasError;
}

