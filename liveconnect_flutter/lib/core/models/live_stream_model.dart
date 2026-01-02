class LiveStream {
  final String id;
  final String streamerName;
  final String streamerPhoto;
  final String thumbnail;
  final String title;
  final int viewerCount;
  final String? category;
  final String? videoUrl; // Optional video URL for live streaming
  final DateTime? startTime; // When the stream started
  final int totalGiftsReceived; // Total coins received from gifts
  final int totalLikes; // Total likes on the stream

  LiveStream({
    required this.id,
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
  });

  factory LiveStream.fromJson(Map<String, dynamic> json) {
    return LiveStream(
      id: json['id'] ?? '',
      streamerName: json['streamerName'] ?? '',
      streamerPhoto: json['streamerPhoto'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
      viewerCount: json['viewerCount'] ?? 0,
      category: json['category'],
      videoUrl: json['videoUrl'],
      startTime: json['startTime'] != null 
          ? DateTime.parse(json['startTime']) 
          : null,
      totalGiftsReceived: json['totalGiftsReceived'] ?? 0,
      totalLikes: json['totalLikes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'streamerName': streamerName,
      'streamerPhoto': streamerPhoto,
      'thumbnail': thumbnail,
      'title': title,
      'viewerCount': viewerCount,
      'category': category,
      'videoUrl': videoUrl,
      'startTime': startTime?.toIso8601String(),
      'totalGiftsReceived': totalGiftsReceived,
      'totalLikes': totalLikes,
    };
  }

  /// Get stream duration in human-readable format
  String get duration {
    if (startTime == null) return '';
    final duration = DateTime.now().difference(startTime!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}

