import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../domain/entities/user_entity.dart';

/// User Repository Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return ServiceLocator().userRepository;
});

/// Current User Provider
/// 
/// Fetches the current authenticated user.
/// Usage: ref.watch(currentUserProvider)
final currentUserProvider = FutureProvider<UserEntity?>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getCurrentUser();
});

/// User Profile Provider
/// 
/// Fetches a user profile by ID.
/// Usage: ref.watch(userProfileProvider('user_1'))
final userProfileProvider = FutureProvider.family<UserEntity, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getUserProfile(userId);
});

/// Followers Provider
/// 
/// Fetches followers for a user.
/// Usage: ref.watch(followersProvider('user_1'))
final followersProvider = FutureProvider.family<List<UserEntity>, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getFollowers(userId);
});

/// Following Provider
/// 
/// Fetches users that a user is following.
/// Usage: ref.watch(followingProvider('user_1'))
final followingProvider = FutureProvider.family<List<UserEntity>, String>((ref, userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.getFollowing(userId);
});

/// Search Users Provider
/// 
/// Searches for users by query.
/// Usage: ref.watch(searchUsersProvider('john'))
final searchUsersProvider = FutureProvider.family<List<UserEntity>, String>((ref, query) async {
  final repository = ref.watch(userRepositoryProvider);
  return await repository.searchUsers(query);
});

/// Follow User Provider
/// 
/// Follows or unfollows a user.
/// Usage: ref.read(followUserProvider('user_1').notifier).toggle()
final followUserProvider = StateNotifierProvider.family<FollowUserNotifier, bool, String>((ref, userId) {
  return FollowUserNotifier(ref, userId);
});

class FollowUserNotifier extends StateNotifier<bool> {
  final Ref ref;
  final String userId;
  bool _initialState = false;

  FollowUserNotifier(this.ref, this.userId) : super(false) {
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    try {
      final user = await ref.read(userProfileProvider(userId).future);
      _initialState = user.isFollowing;
      state = _initialState;
    } catch (e) {
      // Handle error - default to false
      state = false;
    }
  }

  Future<void> toggle() async {
    final currentState = state;
    state = !currentState; // Optimistic update

    try {
      final repository = ref.read(userRepositoryProvider);
      if (currentState) {
        await repository.unfollowUser(userId);
      } else {
        await repository.followUser(userId);
      }
      
      // Invalidate user profile to refresh
      ref.invalidate(userProfileProvider(userId));
      ref.invalidate(followersProvider(userId));
    } catch (e) {
      // Revert on error
      state = currentState;
      rethrow;
    }
  }
}




