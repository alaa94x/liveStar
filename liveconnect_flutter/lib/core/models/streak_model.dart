class Streak {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final DateTime lastStreamDate;
  final DateTime? streakStartDate;
  final List<DateTime> streamDates;

  Streak({
    required this.userId,
    this.currentStreak = 0,
    this.longestStreak = 0,
    required this.lastStreamDate,
    this.streakStartDate,
    this.streamDates = const [],
  });

  bool get isActive {
    final now = DateTime.now();
    final daysSinceLastStream = now.difference(lastStreamDate).inDays;
    return daysSinceLastStream <= 1;
  }

  int get daysUntilNextMilestone {
    if (currentStreak < 7) return 7 - currentStreak;
    if (currentStreak < 30) return 30 - currentStreak;
    if (currentStreak < 100) return 100 - currentStreak;
    return 365 - (currentStreak % 365);
  }

  String get milestoneName {
    if (currentStreak >= 365) return 'Year Master';
    if (currentStreak >= 100) return 'Centurion';
    if (currentStreak >= 30) return 'Monthly Champion';
    if (currentStreak >= 7) return 'Weekly Warrior';
    return 'Getting Started';
  }
}

