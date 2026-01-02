import '../../models/user_model.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';
import '../../errors/app_exceptions.dart';

/// User Repository Interface
abstract class UserRepository {
  Future<UserModel> getUserProfile(String userId);
  Future<List<UserModel>> getFollowers(String userId);
  Future<List<UserModel>> getFollowing(String userId);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<List<UserModel>> searchUsers(String query);
}

/// User Repository Implementation
class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserModel> getUserProfile(String userId) async {
    try {
      // Try to get from cache first
      final cachedUser = await localDataSource.getCachedUserProfile(userId);
      if (cachedUser != null) {
        // Also fetch from API in background to update cache
        remoteDataSource.getUserProfile(userId).then((user) {
          localDataSource.cacheUserProfile(user);
        }).catchError((_) {
          // Ignore background fetch errors
        });
        return cachedUser;
      }

      // If not in cache, fetch from API
      final user = await remoteDataSource.getUserProfile(userId);
      await localDataSource.cacheUserProfile(user);
      return user;
    } catch (e) {
      // Try cache as fallback
      final cachedUser = await localDataSource.getCachedUserProfile(userId);
      if (cachedUser != null) {
        return cachedUser;
      }

      throw e is AppException
          ? e
          : NotFoundException('User not found');
    }
  }

  @override
  Future<List<UserModel>> getFollowers(String userId) async {
    try {
      return await remoteDataSource.getFollowers(userId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to load followers');
    }
  }

  @override
  Future<List<UserModel>> getFollowing(String userId) async {
    try {
      return await remoteDataSource.getFollowing(userId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to load following');
    }
  }

  @override
  Future<void> followUser(String userId) async {
    try {
      await remoteDataSource.followUser(userId);
      // Invalidate cache for this user
      await localDataSource.getCachedUserProfile(userId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to follow user');
    }
  }

  @override
  Future<void> unfollowUser(String userId) async {
    try {
      await remoteDataSource.unfollowUser(userId);
      // Invalidate cache for this user
      await localDataSource.getCachedUserProfile(userId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to unfollow user');
    }
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      return await remoteDataSource.searchUsers(query);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to search users');
    }
  }
}




