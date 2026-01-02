import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../data/mock_data_service.dart';

/// Provider for current user
final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final profile = await MockDataService.getUserProfile();
  if (profile == null) return null;
  
  return UserModel(
    id: profile['id'] ?? '',
    name: profile['name'] ?? '',
    username: profile['username'] ?? '',
    avatar: profile['avatar'] ?? '',
    bio: profile['bio'],
    isVerified: profile['isVerified'] ?? false,
    isLive: profile['isLive'] ?? false,
    followersCount: profile['followers'] ?? 0,
    followingCount: profile['following'] ?? 0,
    likesCount: profile['likes'] ?? 0,
    coins: profile['coins'] ?? 0,
  );
});

/// Provider for user follow state
final userFollowStateProvider = StateNotifierProvider.family<UserFollowNotifier, bool, String>((ref, userId) {
  return UserFollowNotifier(userId);
});

class UserFollowNotifier extends StateNotifier<bool> {
  final String userId;
  
  UserFollowNotifier(this.userId) : super(false) {
    _loadFollowState();
  }

  Future<void> _loadFollowState() async {
    // Load from mock data - in real app, fetch from API
    final isFollowing = await _checkFollowStatus();
    state = isFollowing;
  }

  Future<bool> _checkFollowStatus() async {
    // Mock implementation
    return false;
  }

  Future<void> toggleFollow() async {
    final newState = !state;
    state = newState;
    
    // In real app, call API to follow/unfollow
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Update followers count
    // This would trigger a refresh of user data
  }
}

/// Provider for user's following list
final followingListProvider = FutureProvider<List<UserModel>>((ref) async {
  // Mock implementation - in real app, fetch from API
  await Future.delayed(const Duration(milliseconds: 500));
  return [];
});

/// Provider for user's followers list
final followersListProvider = FutureProvider<List<UserModel>>((ref) async {
  // Mock implementation - in real app, fetch from API
  await Future.delayed(const Duration(milliseconds: 500));
  return [];
});

