class LeaderboardEntry {
  final String userId;
  final String userName;
  final String avatar;
  final int rank;
  final int score;
  final LeaderboardType type;
  final Map<String, dynamic>? metadata;

  LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.rank,
    required this.score,
    required this.type,
    this.metadata,
  });
}

enum LeaderboardType {
  daily,
  weekly,
  monthly,
  allTime,
  gifts,
  viewers,
  streams,
}

class Leaderboard {
  final LeaderboardType type;
  final List<LeaderboardEntry> entries;
  final DateTime updatedAt;
  final int? currentUserRank;

  Leaderboard({
    required this.type,
    required this.entries,
    required this.updatedAt,
    this.currentUserRank,
  });
}

