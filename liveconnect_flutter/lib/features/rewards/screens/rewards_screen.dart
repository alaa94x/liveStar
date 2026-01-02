import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = MockData.mockRewards;
    final totalEarned = rewards.fold(0, (sum, r) => sum + (r['amount'] as int));

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Rewards',
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          // Total Rewards Card
          _buildTotalRewardsCard(totalEarned),

          const SizedBox(height: 16),

          // Rewards List
          Expanded(
            child: rewards.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: rewards.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final reward = rewards[index];
                      return _buildRewardItem(reward);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRewardsCard(int totalEarned) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total Rewards',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                totalEarned.toString(),
                style: AppTextStyles.displayMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.stars,
                color: AppColors.coinGold,
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Coins earned from gifts',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No rewards yet',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start streaming to receive gifts!',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(Map<String, dynamic> reward) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Gift Icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryPink.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                reward['giftEmoji'] ?? '🎁',
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reward['title'],
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(reward['avatar']),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'From ${reward['from']}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(reward['date']),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '+${reward['amount']}',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.coinGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.stars,
                    color: AppColors.coinGold,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}
