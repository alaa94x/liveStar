import 'package:flutter/material.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = MockData.walletBalance;
    final totalEarned = MockData.totalEarned;
    final totalSpent = MockData.totalSpent;
    final transactions = MockData.mockTransactions;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Wallet',
          style: AppTextStyles.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          // Balance Card
          _buildBalanceCard(balance, totalEarned, totalSpent),

          const SizedBox(height: 24),

          // Quick Actions
          _buildQuickActions(context),

          const SizedBox(height: 24),

          // Transactions Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Recent Transactions',
                  style: AppTextStyles.titleLarge,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: transactions.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return _buildTransactionItem(transaction);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(int balance, int totalEarned, int totalSpent) {
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
            'Current Balance',
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
                balance.toString(),
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
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatColumn('Earned', totalEarned, Colors.green),
              _buildStatColumn('Spent', totalSpent, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GradientButton(
              text: 'Add Coins',
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: AppColors.primaryPurple),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Withdraw',
                style: AppTextStyles.buttonMedium.copyWith(
                  color: AppColors.primaryPurple,
                ),
              ),
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
              Icons.account_balance_wallet,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No transactions yet',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your transaction history will appear here',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final type = transaction['type'];
    final amount = transaction['amount'];
    final isPositive = amount > 0;

    Color typeColor;
    IconData typeIcon;

    switch (type) {
      case 'earned':
        typeColor = Colors.green;
        typeIcon = Icons.arrow_downward;
        break;
      case 'spent':
        typeColor = Colors.orange;
        typeIcon = Icons.arrow_upward;
        break;
      case 'purchased':
        typeColor = AppColors.primaryPurple;
        typeIcon = Icons.add_circle;
        break;
      default:
        typeColor = AppColors.textSecondary;
        typeIcon = Icons.swap_horiz;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              typeIcon,
              color: typeColor,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['description'],
                  style: AppTextStyles.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(transaction['date']),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          // Amount
          Row(
            children: [
              Text(
                isPositive ? '+${amount.abs()}' : '-${amount.abs()}',
                style: AppTextStyles.titleLarge.copyWith(
                  color: isPositive ? Colors.green : Colors.orange,
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
