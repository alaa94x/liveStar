import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/repositories/live_stream_repository.dart';
import '../../../domain/entities/live_stream_entity.dart';

/// Live Stream Repository Provider
/// 
/// Provides access to the live stream repository through Riverpod.
final liveStreamRepositoryProvider = Provider<LiveStreamRepository>((ref) {
  return ServiceLocator().liveStreamRepository;
});

/// Live Streams Provider
/// 
/// Fetches all live streams.
/// Usage: ref.watch(liveStreamsProvider(category: 'gaming'))
final liveStreamsProvider = FutureProvider.family<List<LiveStreamEntity>, String?>((ref, category) async {
  final repository = ref.watch(liveStreamRepositoryProvider);
  return await repository.getLiveStreams(category: category);
});

/// Live Stream by ID Provider
/// 
/// Fetches a specific live stream by ID.
/// Usage: ref.watch(liveStreamByIdProvider('stream_1'))
final liveStreamByIdProvider = FutureProvider.family<LiveStreamEntity, String>((ref, streamId) async {
  final repository = ref.watch(liveStreamRepositoryProvider);
  return await repository.getStreamById(streamId);
});

/// Watch Live Streams Provider (Real-time)
/// 
/// Watches live streams for real-time updates.
/// Usage: ref.watch(watchLiveStreamsProvider)
final watchLiveStreamsProvider = StreamProvider<List<LiveStreamEntity>>((ref) {
  final repository = ref.watch(liveStreamRepositoryProvider);
  return repository.watchLiveStreams();
});

/// Watch Stream Provider (Real-time)
/// 
/// Watches a specific stream for real-time updates.
/// Usage: ref.watch(watchStreamProvider('stream_1'))
final watchStreamProvider = StreamProvider.family<LiveStreamEntity, String>((ref, streamId) {
  final repository = ref.watch(liveStreamRepositoryProvider);
  return repository.watchStream(streamId);
});




