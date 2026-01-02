import '../../domain/entities/live_stream_entity.dart';
import '../../domain/repositories/live_stream_repository.dart';
import '../datasources/live_stream_remote_data_source.dart';
import '../datasources/live_stream_local_data_source.dart';
import '../../../core/errors/app_exceptions.dart';

/// Live Stream Repository Implementation
/// 
/// This implements the repository interface using remote and local data sources.
/// It handles error handling, caching, and data transformation.
class LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamRemoteDataSource remoteDataSource;
  final LiveStreamLocalDataSource localDataSource;

  LiveStreamRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<LiveStreamEntity>> getLiveStreams({String? category}) async {
    try {
      // Try to get data from remote source (API)
      final streams = await remoteDataSource.getLiveStreams(category: category);
      
      // Cache the data for offline access
      await localDataSource.cacheLiveStreams(streams);
      
      return streams;
    } catch (e) {
      // If API fails, try to get from cache
      final cachedStreams = await localDataSource.getCachedLiveStreams();
      if (cachedStreams != null && cachedStreams.isNotEmpty) {
        return cachedStreams;
      }
      
      // If cache is also empty, rethrow the error
      throw e is AppException
          ? e
          : ConnectionException('Failed to load live streams');
    }
  }

  @override
  Future<LiveStreamEntity> getStreamById(String streamId) async {
    try {
      // Try to get from remote source first
      final stream = await remoteDataSource.getStreamById(streamId);
      
      // Cache the stream
      await localDataSource.cacheStream(stream);
      
      return stream;
    } catch (e) {
      // Try cache as fallback
      final cachedStream = await localDataSource.getCachedStream(streamId);
      if (cachedStream != null) {
        return cachedStream;
      }

      throw e is AppException
          ? e
          : NotFoundException('Stream not found: $streamId');
    }
  }

  @override
  Future<LiveStreamEntity> goLive(Map<String, dynamic> streamData) async {
    try {
      final stream = await remoteDataSource.goLive(streamData);
      await localDataSource.cacheStream(stream);
      return stream;
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to start live stream');
    }
  }

  @override
  Future<void> endStream(String streamId) async {
    try {
      await remoteDataSource.endStream(streamId);
      // Clear cached stream
      await localDataSource.getCachedStream(streamId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to end stream');
    }
  }

  @override
  Future<void> likeStream(String streamId) async {
    try {
      await remoteDataSource.likeStream(streamId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to like stream');
    }
  }

  @override
  Future<void> shareStream(String streamId) async {
    try {
      await remoteDataSource.shareStream(streamId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to share stream');
    }
  }

  @override
  Stream<List<LiveStreamEntity>> watchLiveStreams() {
    // Return real-time stream from remote data source
    // This will be connected to WebSocket/SSE when backend is ready
    return remoteDataSource.watchLiveStreams();
  }

  @override
  Stream<LiveStreamEntity> watchStream(String streamId) {
    // Return real-time stream updates from remote data source
    // This will be connected to WebSocket/SSE when backend is ready
    return remoteDataSource.watchStream(streamId);
  }
}

