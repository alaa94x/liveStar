import '../../domain/entities/user_entity.dart';

/// User DTO (Data Transfer Object)
/// 
/// This is used for data transfer between API and domain layer.
class UserDTO {
  final String id;
  final String name;
  final String username;
  final String avatar;
  final String? bio;
  final bool isVerified;
  final bool isLive;
  final int followersCount;
  final int followingCount;
  final int likesCount;
  final int coins;
  final int vipLevel;
  final bool isFollowing;
  final bool isFollower;
  final bool isBlocked;
  final DateTime? lastActive;

  UserDTO({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    this.bio,
    this.isVerified = false,
    this.isLive = false,
    this.followersCount = 0,
    this.followingCount = 0,
    this.likesCount = 0,
    this.coins = 0,
    this.vipLevel = 0,
    this.isFollowing = false,
    this.isFollower = false,
    this.isBlocked = false,
    this.lastActive,
  });

  /// Convert from JSON
  /// 
  /// TODO: Replace with real API response parsing when backend is ready
  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      avatar: json['avatar'] ?? json['avatarUrl'] ?? '',
      bio: json['bio'],
      isVerified: json['isVerified'] ?? json['is_verified'] ?? false,
      isLive: json['isLive'] ?? json['is_live'] ?? false,
      followersCount: json['followersCount'] ?? json['followers_count'] ?? 0,
      followingCount: json['followingCount'] ?? json['following_count'] ?? 0,
      likesCount: json['likesCount'] ?? json['likes_count'] ?? 0,
      coins: json['coins'] ?? 0,
      vipLevel: json['vipLevel'] ?? json['vip_level'] ?? 0,
      isFollowing: json['isFollowing'] ?? json['is_following'] ?? false,
      isFollower: json['isFollower'] ?? json['is_follower'] ?? false,
      isBlocked: json['isBlocked'] ?? json['is_blocked'] ?? false,
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'])
          : json['last_active'] != null
              ? DateTime.parse(json['last_active'])
              : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'avatar': avatar,
      'bio': bio,
      'isVerified': isVerified,
      'isLive': isLive,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'likesCount': likesCount,
      'coins': coins,
      'vipLevel': vipLevel,
      'isFollowing': isFollowing,
      'isFollower': isFollower,
      'isBlocked': isBlocked,
      'lastActive': lastActive?.toIso8601String(),
    };
  }

  /// Convert to domain entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      avatar: avatar,
      bio: bio,
      isVerified: isVerified,
      isLive: isLive,
      followersCount: followersCount,
      followingCount: followingCount,
      likesCount: likesCount,
      coins: coins,
      vipLevel: vipLevel,
      isFollowing: isFollowing,
      isFollower: isFollower,
      isBlocked: isBlocked,
      lastActive: lastActive,
    );
  }

  /// Convert from domain entity
  factory UserDTO.fromEntity(UserEntity entity) {
    return UserDTO(
      id: entity.id,
      name: entity.name,
      username: entity.username,
      avatar: entity.avatar,
      bio: entity.bio,
      isVerified: entity.isVerified,
      isLive: entity.isLive,
      followersCount: entity.followersCount,
      followingCount: entity.followingCount,
      likesCount: entity.likesCount,
      coins: entity.coins,
      vipLevel: entity.vipLevel,
      isFollowing: entity.isFollowing,
      isFollower: entity.isFollower,
      isBlocked: entity.isBlocked,
      lastActive: entity.lastActive,
    );
  }
}




