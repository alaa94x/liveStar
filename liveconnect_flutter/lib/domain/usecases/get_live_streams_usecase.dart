import '../entities/live_stream_entity.dart';
import '../repositories/live_stream_repository.dart';

/// Get Live Streams Use Case
/// 
/// This use case handles the business logic for fetching live streams.
/// It's part of the domain layer and doesn't know about data sources.
class GetLiveStreamsUseCase {
  final LiveStreamRepository repository;

  GetLiveStreamsUseCase(this.repository);

  /// Execute the use case
  /// 
  /// [category] - Optional category filter
  /// Returns list of live streams
  Future<List<LiveStreamEntity>> execute({String? category}) async {
    return await repository.getLiveStreams(category: category);
  }
}




