import 'live_stream_remote_data_source.dart';
import '../../domain/entities/live_stream_entity.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/data/mock_data_service.dart';

/// Mock Live Stream Remote Data Source
/// 
/// This provides mock data using the existing mock data service.
/// TODO: Replace with real API implementation when backend is ready.
class LiveStreamRemoteDataSourceMock implements LiveStreamRemoteDataSource {
  @override
  Future<List<LiveStreamEntity>> getLiveStreams({String? category}) async {
    // Use existing mock data service
    final streams = await MockDataService.getLiveStreams(category: category);
    
    // Convert to domain entities
    // Note: Using existing LiveStream model from core/models
    // In production, this would convert from DTOs
    return streams.map((stream) {
      return LiveStreamEntity(
        id: stream.id,
        streamerId: stream.streamerName.toLowerCase().replaceAll(' ', '_'), // Generate streamer ID from name
        streamerName: stream.streamerName,
        streamerPhoto: stream.streamerPhoto,
        thumbnail: stream.thumbnail,
        title: stream.title,
        viewerCount: stream.viewerCount,
        category: stream.category,
        videoUrl: stream.videoUrl,
        startTime: stream.startTime,
        totalGiftsReceived: stream.totalGiftsReceived,
        totalLikes: stream.totalLikes,
        isLive: true,
      );
    }).toList();
  }

  @override
  Future<LiveStreamEntity> getStreamById(String streamId) async {
    final stream = await MockDataService.getLiveStreamById(streamId);
    if (stream == null) {
      throw Exception('Stream not found: $streamId');
    }
    
    return LiveStreamEntity(
      id: stream.id,
      streamerId: stream.streamerName.toLowerCase().replaceAll(' ', '_'), // Generate streamer ID from name
      streamerName: stream.streamerName,
      streamerPhoto: stream.streamerPhoto,
      thumbnail: stream.thumbnail,
      title: stream.title,
      viewerCount: stream.viewerCount,
      category: stream.category,
      videoUrl: stream.videoUrl,
      startTime: stream.startTime,
      totalGiftsReceived: stream.totalGiftsReceived,
      totalLikes: stream.totalLikes,
      isLive: true,
    );
  }

  @override
  Future<LiveStreamEntity> goLive(Map<String, dynamic> streamData) async {
    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    return LiveStreamEntity(
      id: 'new_stream_${DateTime.now().millisecondsSinceEpoch}',
      streamerId: streamData['streamerId'] ?? 'user_1',
      streamerName: streamData['streamerName'] ?? 'User',
      streamerPhoto: streamData['streamerPhoto'] ?? '',
      thumbnail: streamData['thumbnail'] ?? '',
      title: streamData['title'] ?? 'Live Stream',
      viewerCount: 0,
      category: streamData['category'],
      videoUrl: streamData['videoUrl'],
      startTime: DateTime.now(),
      totalGiftsReceived: 0,
      totalLikes: 0,
      isLive: true,
    );
  }

  @override
  Future<void> endStream(String streamId) async {
    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> likeStream(String streamId) async {
    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> shareStream(String streamId) async {
    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Stream<List<LiveStreamEntity>> watchLiveStreams() {
    // MOCK IMPLEMENTATION – replace when backend is ready
    // For now, return periodic updates with mock data
    return Stream.periodic(
      const Duration(seconds: 5),
      (_) async {
        return await getLiveStreams();
      },
    ).asyncMap((future) => future);
  }

  @override
  Stream<LiveStreamEntity> watchStream(String streamId) {
    // MOCK IMPLEMENTATION – replace when backend is ready
    // For now, return periodic updates with mock stream data
    return Stream.periodic(
      const Duration(seconds: 3),
      (_) async {
        return await getStreamById(streamId);
      },
    ).asyncMap((future) => future);
  }
}

