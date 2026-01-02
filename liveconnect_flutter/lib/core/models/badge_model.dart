class Badge {
  final String id;
  final String name;
  final String icon;
  final String description;
  final BadgeType type;
  final int level;
  final DateTime? unlockedAt;

  Badge({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.type,
    this.level = 1,
    this.unlockedAt,
  });
}

enum BadgeType {
  streak,
  gift,
  follower,
  stream,
  special,
  vip,
}

class UserBadge {
  final Badge badge;
  final int progress;
  final int target;
  final bool isUnlocked;

  UserBadge({
    required this.badge,
    required this.progress,
    required this.target,
    this.isUnlocked = false,
  });

  double get progressPercentage => (progress / target).clamp(0.0, 1.0);
}

