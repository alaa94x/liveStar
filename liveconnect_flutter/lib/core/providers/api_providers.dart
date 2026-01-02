import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/service_locator.dart';
import '../data/repositories/stream_repository.dart';
import '../data/repositories/user_repository.dart';

/// API Repository Providers
/// 
/// These providers expose repositories through Riverpod.
/// Use these in your widgets instead of accessing ServiceLocator directly.

final streamRepositoryProvider = Provider<StreamRepository>((ref) {
  return ServiceLocator().streamRepository;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return ServiceLocator().userRepository;
});

/// Example: Stream Provider using Repository
/// 
/// This is an example of how to use repositories in providers.
/// You can create similar providers for other data.
final liveStreamsProvider = FutureProvider.family<List<dynamic>, String?>((ref, category) async {
  final repository = ref.watch(streamRepositoryProvider);
  return await repository.getLiveStreams(category: category);
});

/// Example: User Profile Provider using Repository
final userProfileProvider = FutureProvider.family<dynamic, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getUserProfile(userId);
});




