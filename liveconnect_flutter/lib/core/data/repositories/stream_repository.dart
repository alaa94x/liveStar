import '../../models/live_stream_model.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../../errors/app_exceptions.dart';

/// Stream Repository Interface
/// 
/// This defines the contract for stream data operations.
abstract class StreamRepository {
  Future<List<LiveStream>> getLiveStreams({String? category});
  Future<LiveStream> getStreamById(String streamId);
  Future<void> goLive(Map<String, dynamic> streamData);
  Future<void> endStream(String streamId);
  Future<void> likeStream(String streamId);
  Future<void> shareStream(String streamId);
}

/// Stream Repository Implementation
/// 
/// Implements the repository pattern with:
/// - Remote data source (API calls)
/// - Local data source (caching)
/// - Error handling
class StreamRepositoryImpl implements StreamRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  StreamRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<LiveStream>> getLiveStreams({String? category}) async {
    try {
      // Try to get data from API
      final streams = await remoteDataSource.getLiveStreams(category: category);
      
      // Cache the data
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
          : ConnectionException('Failed to load streams');
    }
  }

  @override
  Future<LiveStream> getStreamById(String streamId) async {
    try {
      return await remoteDataSource.getStreamById(streamId);
    } catch (e) {
      throw e is AppException
          ? e
          : NotFoundException('Stream not found');
    }
  }

  @override
  Future<void> goLive(Map<String, dynamic> streamData) async {
    try {
      await remoteDataSource.goLive(streamData);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to start stream');
    }
  }

  @override
  Future<void> endStream(String streamId) async {
    try {
      await remoteDataSource.endStream(streamId);
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
}




