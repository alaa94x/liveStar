import '../entities/live_stream_entity.dart';

/// Live Stream Repository Interface (Domain Layer)
/// 
/// This defines the contract for live stream data operations.
/// Implementations are in the data layer.
abstract class LiveStreamRepository {
  /// Get all live streams
  /// 
  /// [category] - Optional category filter
  /// Returns list of live streams
  Future<List<LiveStreamEntity>> getLiveStreams({String? category});

  /// Get a specific live stream by ID
  /// 
  /// [streamId] - The stream ID
  /// Returns the live stream entity
  Future<LiveStreamEntity> getStreamById(String streamId);

  /// Start a live stream
  /// 
  /// [streamData] - Stream configuration data
  /// Returns the created stream entity
  Future<LiveStreamEntity> goLive(Map<String, dynamic> streamData);

  /// End a live stream
  /// 
  /// [streamId] - The stream ID to end
  Future<void> endStream(String streamId);

  /// Like a stream
  /// 
  /// [streamId] - The stream ID to like
  Future<void> likeStream(String streamId);

  /// Share a stream
  /// 
  /// [streamId] - The stream ID to share
  Future<void> shareStream(String streamId);

  /// Watch live streams (real-time updates)
  /// 
  /// Returns a stream of live streams for real-time updates
  Stream<List<LiveStreamEntity>> watchLiveStreams();

  /// Watch a specific stream (real-time updates)
  /// 
  /// [streamId] - The stream ID to watch
  /// Returns a stream of stream entity updates
  Stream<LiveStreamEntity> watchStream(String streamId);
}




