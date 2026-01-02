/// User Entity (Domain Layer)
/// 
/// This is the domain entity representing a user.
/// It's independent of data sources and API implementations.
class UserEntity {
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

  UserEntity({
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
}




