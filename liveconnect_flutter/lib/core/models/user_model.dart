class UserModel {
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
  final Map<String, dynamic>? metadata;

  UserModel({
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
    this.metadata,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
      isFollowing: json['isFollowing'] ?? false,
      isFollower: json['isFollower'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      lastActive: json['lastActive'] != null
          ? DateTime.parse(json['lastActive'])
          : null,
      metadata: json['metadata'],
    );
  }

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
      'metadata': metadata,
    };
  }
}

