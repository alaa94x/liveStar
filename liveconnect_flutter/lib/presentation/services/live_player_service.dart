import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

/// Live Player Service
/// 
/// This service handles video player logic separately from UI.
/// It makes it easy to replace mock/video URL with real streaming backend later.
class LivePlayerService extends ChangeNotifier {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _hasError = false;
  String? _errorMessage;

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _isPlaying;
  bool get hasError => _hasError;
  String? get errorMessage => _errorMessage;

  /// Initialize video player with URL
  /// 
  /// [videoUrl] - The video URL to play
  /// [autoPlay] - Whether to auto-play the video
  /// [loop] - Whether to loop the video
  /// [mute] - Whether to mute the video
  Future<void> initialize({
    required String videoUrl,
    bool autoPlay = true,
    bool loop = true,
    bool mute = true,
  }) async {
    try {
      _hasError = false;
      _errorMessage = null;
      notifyListeners();

      // Dispose previous controller if exists
      await _controller?.dispose();

      // Create new controller
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false,
          allowBackgroundPlayback: false,
        ),
      );

      // Initialize with timeout
      await _controller!.initialize().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Video initialization timed out');
        },
      );

      // Configure player
      _controller!.setLooping(loop);
      _controller!.setVolume(mute ? 0.0 : 1.0);

      _isInitialized = true;

      // Auto-play if requested
      if (autoPlay) {
        await play();
      }

      notifyListeners();

      // Listen to player state changes
      _controller!.addListener(_onPlayerStateChanged);
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      _isInitialized = false;
      notifyListeners();

      // Dispose controller on error
      await _controller?.dispose();
      _controller = null;
    }
  }

  void _onPlayerStateChanged() {
    if (_controller == null) return;

    final wasPlaying = _isPlaying;
    _isPlaying = _controller!.value.isPlaying;

    if (wasPlaying != _isPlaying) {
      notifyListeners();
    }
  }

  /// Play the video
  Future<void> play() async {
    if (_controller == null || !_isInitialized) return;

    try {
      await _controller!.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Pause the video
  Future<void> pause() async {
    if (_controller == null || !_isInitialized) return;

    try {
      await _controller!.pause();
      _isPlaying = false;
      notifyListeners();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  /// Dispose the service
  @override
  void dispose() {
    _controller?.removeListener(_onPlayerStateChanged);
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
    _isPlaying = false;
    super.dispose();
  }
}

/// Timeout Exception
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => message;
}




