import '../entities/user_entity.dart';

/// User Repository Interface (Domain Layer)
/// 
/// This defines the contract for user data operations.
/// Implementations are in the data layer.
abstract class UserRepository {
  /// Get current authenticated user
  /// 
  /// Returns the current user entity, or null if not authenticated
  Future<UserEntity?> getCurrentUser();

  /// Get user profile by ID
  /// 
  /// [userId] - The user ID
  /// Returns the user entity
  Future<UserEntity> getUserProfile(String userId);

  /// Get user's followers
  /// 
  /// [userId] - The user ID
  /// Returns list of follower entities
  Future<List<UserEntity>> getFollowers(String userId);

  /// Get users that a user is following
  /// 
  /// [userId] - The user ID
  /// Returns list of following entities
  Future<List<UserEntity>> getFollowing(String userId);

  /// Follow a user
  /// 
  /// [userId] - The user ID to follow
  Future<void> followUser(String userId);

  /// Unfollow a user
  /// 
  /// [userId] - The user ID to unfollow
  Future<void> unfollowUser(String userId);

  /// Search users
  /// 
  /// [query] - Search query
  /// Returns list of matching user entities
  Future<List<UserEntity>> searchUsers(String query);

  /// Update user profile
  /// 
  /// [userId] - The user ID
  /// [data] - Profile data to update
  /// Returns updated user entity
  Future<UserEntity> updateProfile(String userId, Map<String, dynamic> data);
}




