import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/data/mock_data_service.dart';
import '../../../core/errors/app_exceptions.dart';

/// User Repository Implementation
/// 
/// TODO: Replace mock implementations with real API calls when backend is ready.
class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity?> getCurrentUser() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(ApiConfig.currentUser);
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => UserDTO.fromJson(json as Map<String, dynamic>).toEntity(),
    // ).data;
    // return data;

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
    
    final mockUser = MockData.mockUserProfile;
    return UserEntity(
      id: mockUser['id'] ?? 'user_1',
      name: mockUser['name'] ?? 'User',
      username: mockUser['username'] ?? '@user',
      avatar: mockUser['avatar'] ?? '',
      bio: mockUser['bio'],
      isVerified: mockUser['isVerified'] ?? false,
      isLive: mockUser['isLive'] ?? false,
      followersCount: mockUser['followersCount'] ?? 0,
      followingCount: mockUser['followingCount'] ?? 0,
      likesCount: mockUser['likesCount'] ?? 0,
      coins: mockUser['coins'] ?? 0,
      vipLevel: mockUser['vipLevel'] ?? 0,
    );
  }

  @override
  Future<UserEntity> getUserProfile(String userId) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(ApiConfig.userProfile(userId));
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => UserDTO.fromJson(json as Map<String, dynamic>).toEntity(),
    // ).data;
    // return data!;

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      final profile = await MockDataService.getUserProfile();
      return UserEntity(
        id: profile['id'] ?? userId,
        name: profile['name'] ?? 'User',
        username: profile['username'] ?? '@user',
        avatar: profile['avatar'] ?? '',
        bio: profile['bio'],
        isVerified: profile['isVerified'] ?? false,
        isLive: profile['isLive'] ?? false,
        followersCount: profile['followers'] ?? 0,
        followingCount: profile['following'] ?? 0,
        likesCount: profile['likes'] ?? 0,
        coins: profile['coins'] ?? 0,
        vipLevel: profile['vipLevel'] ?? 0,
      );
    } catch (e) {
      throw NotFoundException('User not found: $userId');
    }
  }

  @override
  Future<List<UserEntity>> getFollowers(String userId) async {
    // TODO: Replace with real API call when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Use existing mock data
    final followersData = MockData.mockFollowers
        .where((f) => f['followingId'] == userId)
        .map((f) => f['followerData'] as Map<String, dynamic>)
        .toList();
    
    return followersData.map((json) {
      return UserEntity(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        avatar: json['avatar'] ?? '',
        bio: json['bio'],
        isVerified: json['isVerified'] ?? false,
        isLive: json['isLive'] ?? false,
        followersCount: json['followersCount'] ?? 0,
        followingCount: json['followingCount'] ?? 0,
        likesCount: json['likesCount'] ?? 0,
        coins: json['coins'] ?? 0,
        vipLevel: json['vipLevel'] ?? 0,
      );
    }).toList();
  }

  @override
  Future<List<UserEntity>> getFollowing(String userId) async {
    // TODO: Replace with real API call when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Use existing mock data
    final followingData = MockData.mockFollowing
        .where((f) => f['followerId'] == userId)
        .map((f) => f['followingData'] as Map<String, dynamic>)
        .toList();
    
    return followingData.map((json) {
      return UserEntity(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        avatar: json['avatar'] ?? '',
        bio: json['bio'],
        isVerified: json['isVerified'] ?? false,
        isLive: json['isLive'] ?? false,
        followersCount: json['followersCount'] ?? 0,
        followingCount: json['followingCount'] ?? 0,
        likesCount: json['likesCount'] ?? 0,
        coins: json['coins'] ?? 0,
        vipLevel: json['vipLevel'] ?? 0,
      );
    }).toList();
  }

  @override
  Future<void> followUser(String userId) async {
    // TODO: Replace with real API call when backend is ready
    // await apiClient.post(ApiConfig.followUser(userId));
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unfollowUser(String userId) async {
    // TODO: Replace with real API call when backend is ready
    // await apiClient.delete(ApiConfig.unfollowUser(userId));
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<List<UserEntity>> searchUsers(String query) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(ApiConfig.searchUsers(query));
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => (json as List)
    //       .map((e) => UserDTO.fromJson(e as Map<String, dynamic>).toEntity())
    //       .toList(),
    // ).data;
    // return data ?? [];

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    final allUsers = MockData.mockUsers.map((json) {
      return UserEntity(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        avatar: json['avatar'] ?? '',
        bio: json['bio'],
        isVerified: json['isVerified'] ?? false,
        isLive: json['isLive'] ?? false,
        followersCount: json['followersCount'] ?? 0,
        followingCount: json['followingCount'] ?? 0,
        likesCount: json['likesCount'] ?? 0,
        coins: json['coins'] ?? 0,
        vipLevel: json['vipLevel'] ?? 0,
      );
    }).toList();
    
    // Filter by query
    final queryLower = query.toLowerCase();
    return allUsers.where((user) {
      return user.name.toLowerCase().contains(queryLower) ||
          user.username.toLowerCase().contains(queryLower);
    }).toList();
  }

  @override
  Future<UserEntity> updateProfile(String userId, Map<String, dynamic> data) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.put(
    //   ApiConfig.updateProfile(userId),
    //   data: data,
    // );
    // final result = ApiResponse.fromJson(
    //   response.data,
    //   (json) => UserDTO.fromJson(json as Map<String, dynamic>).toEntity(),
    // ).data;
    // return result!;

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw NotFoundException('User not found: $userId');
    }
    
    return UserEntity(
      id: currentUser.id,
      name: data['name'] ?? currentUser.name,
      username: data['username'] ?? currentUser.username,
      avatar: data['avatar'] ?? currentUser.avatar,
      bio: data['bio'] ?? currentUser.bio,
      isVerified: currentUser.isVerified,
      isLive: currentUser.isLive,
      followersCount: currentUser.followersCount,
      followingCount: currentUser.followingCount,
      likesCount: currentUser.likesCount,
      coins: currentUser.coins,
      vipLevel: currentUser.vipLevel,
    );
  }
}

