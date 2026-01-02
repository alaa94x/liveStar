import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/leaderboard_model.dart';
import '../data/mock_data.dart';

/// Provider for leaderboard data
final leaderboardProvider = FutureProvider.family<Leaderboard, LeaderboardType>((ref, type) async {
  await Future.delayed(const Duration(milliseconds: 500));
  
  // Mock leaderboard data
  final entries = List.generate(10, (index) {
    return LeaderboardEntry(
      userId: 'user_$index',
      userName: 'User ${index + 1}',
      avatar: 'https://i.pravatar.cc/150?img=${index + 1}',
      rank: index + 1,
      score: (1000 - index * 50),
      type: type,
    );
  });

  return Leaderboard(
    type: type,
    entries: entries,
    updatedAt: DateTime.now(),
    currentUserRank: 5, // Mock current user rank
  );
});

