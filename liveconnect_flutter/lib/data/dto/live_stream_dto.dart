import '../../domain/entities/live_stream_entity.dart';

/// Live Stream DTO (Data Transfer Object)
/// 
/// This is used for data transfer between API and domain layer.
/// It handles JSON serialization/deserialization.
class LiveStreamDTO {
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

  LiveStreamDTO({
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

  /// Convert from JSON
  /// 
  /// TODO: Replace with real API response parsing when backend is ready
  factory LiveStreamDTO.fromJson(Map<String, dynamic> json) {
    return LiveStreamDTO(
      id: json['id'] ?? '',
      streamerId: json['streamerId'] ?? json['streamer_id'] ?? '',
      streamerName: json['streamerName'] ?? json['streamer_name'] ?? '',
      streamerPhoto: json['streamerPhoto'] ?? json['streamer_photo'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
      viewerCount: json['viewerCount'] ?? json['viewer_count'] ?? 0,
      category: json['category'],
      videoUrl: json['videoUrl'] ?? json['video_url'],
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : json['start_time'] != null
              ? DateTime.parse(json['start_time'])
              : null,
      totalGiftsReceived: json['totalGiftsReceived'] ?? json['total_gifts_received'] ?? 0,
      totalLikes: json['totalLikes'] ?? json['total_likes'] ?? 0,
      isLive: json['isLive'] ?? json['is_live'] ?? true,
    );
  }

  /// Convert to JSON
  /// 
  /// TODO: Update to match your API's expected format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'streamerId': streamerId,
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
      'isLive': isLive,
    };
  }

  /// Convert to domain entity
  LiveStreamEntity toEntity() {
    return LiveStreamEntity(
      id: id,
      streamerId: streamerId,
      streamerName: streamerName,
      streamerPhoto: streamerPhoto,
      thumbnail: thumbnail,
      title: title,
      viewerCount: viewerCount,
      category: category,
      videoUrl: videoUrl,
      startTime: startTime,
      totalGiftsReceived: totalGiftsReceived,
      totalLikes: totalLikes,
      isLive: isLive,
    );
  }

  /// Convert from domain entity
  factory LiveStreamDTO.fromEntity(LiveStreamEntity entity) {
    return LiveStreamDTO(
      id: entity.id,
      streamerId: entity.streamerId,
      streamerName: entity.streamerName,
      streamerPhoto: entity.streamerPhoto,
      thumbnail: entity.thumbnail,
      title: entity.title,
      viewerCount: entity.viewerCount,
      category: entity.category,
      videoUrl: entity.videoUrl,
      startTime: entity.startTime,
      totalGiftsReceived: entity.totalGiftsReceived,
      totalLikes: entity.totalLikes,
      isLive: entity.isLive,
    );
  }
}




