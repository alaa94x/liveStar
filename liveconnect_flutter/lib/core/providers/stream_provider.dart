import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/live_stream_model.dart';
import '../data/mock_data_service.dart';

/// Provider for all live streams
final liveStreamsProvider = FutureProvider<List<LiveStream>>((ref) async {
  return await MockDataService.getLiveStreams();
});

/// Provider for a specific live stream by ID
final liveStreamProvider = FutureProvider.family<LiveStream?, String>((ref, streamId) async {
  return await MockDataService.getLiveStreamById(streamId);
});

/// Provider for viewer count (simulated real-time updates)
final viewerCountProvider = StreamProvider.family<int, String>((ref, streamId) async* {
  // Simulate real-time viewer count updates
  final stream = await ref.watch(liveStreamProvider(streamId).future);
  if (stream == null) return;
  
  int count = stream.viewerCount;
  
  while (true) {
    await Future.delayed(const Duration(seconds: 3));
    // Simulate viewer count changes
    final change = (count * 0.05).round(); // ±5% change
    count += (count % 2 == 0 ? 1 : -1) * change;
    count = count.clamp(stream.viewerCount ~/ 2, stream.viewerCount * 2);
    yield count;
  }
});

