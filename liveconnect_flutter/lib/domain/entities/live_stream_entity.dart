/// Live Stream Entity (Domain Layer)
/// 
/// This is the domain entity representing a live stream.
/// It's independent of data sources and API implementations.
class LiveStreamEntity {
  final String id;
  final String streamerId;
  final String streamerName;
  final String streamerPhoto;
  final String thumbnail;
  final String title;
  final int viewerCount;
  final String? category;
  final String? videoUrl;
  final DateTime? startTime;
  final int totalGiftsReceived;
  final int totalLikes;
  final bool isLive;

  LiveStreamEntity({
    required this.id,
    required this.streamerId,
    required this.streamerName,
    required this.streamerPhoto,
    required this.thumbnail,
    required this.title,
    required this.viewerCount,
    this.category,
    this.videoUrl,
    this.startTime,
    this.totalGiftsReceived = 0,
    this.totalLikes = 0,
    this.isLive = true,
  });

  /// Duration since stream started
  String get duration {
    if (startTime == null) return '0m';
    final now = DateTime.now();
    final difference = now.difference(startTime!);
    
    if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes % 60}m';
    } else {
      return '${difference.inMinutes}m';
    }
  }
}




