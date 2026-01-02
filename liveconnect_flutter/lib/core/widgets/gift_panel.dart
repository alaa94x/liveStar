import 'package:flutter/material.dart';
import '../models/gift_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Panel for selecting and sending gifts
class GiftPanel extends StatelessWidget {
  final List<Gift> gifts;
  final String selectedCategory;
  final int coinBalance;
  final Function(Gift) onGiftSelected;
  final Function(String) onCategoryChanged;
  final VoidCallback onClose;

  const GiftPanel({
    super.key,
    required this.gifts,
    required this.selectedCategory,
    required this.coinBalance,
    required this.onGiftSelected,
    required this.onCategoryChanged,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // Filter gifts by category field (not price)
    final filteredGifts = selectedCategory == 'all'
        ? gifts
        : selectedCategory == 'popular'
            ? gifts.where((g) => g.category == 'popular').toList()
            : selectedCategory == 'premium'
                ? gifts.where((g) => g.category == 'premium').toList()
                : gifts;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send a Gift',
                  style: AppTextStyles.headlineSmall,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.monetization_on,
                      color: AppColors.coinGold,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      coinBalance.toString(),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.coinGold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textPrimary),
                  onPressed: onClose,
                ),
              ],
            ),
          ),

          // Category tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildCategoryTab('all', 'All'),
                const SizedBox(width: 8),
                _buildCategoryTab('popular', 'Popular'),
                const SizedBox(width: 8),
                _buildCategoryTab('premium', 'Premium'),
              ],
            ),
          ),

          const Divider(color: AppColors.borderColor),

          // Gifts grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredGifts.length,
              itemBuilder: (context, index) {
                final gift = filteredGifts[index];
                final canAfford = coinBalance >= gift.price;
                return _buildGiftItem(gift, canAfford);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String category, String label) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () => onCategoryChanged(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryPurple : AppColors.borderColor,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? AppColors.primaryPurple : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGiftItem(Gift gift, bool canAfford) {
    return GestureDetector(
      onTap: canAfford ? () => onGiftSelected(gift) : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: canAfford
                ? AppColors.borderColor
                : AppColors.textTertiary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: canAfford ? 1.0 : 0.5,
              child: Text(
                gift.emoji,
                style: const TextStyle(fontSize: 32),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              gift.name,
              style: AppTextStyles.bodySmall.copyWith(
                color: canAfford
                    ? AppColors.textPrimary
                    : AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 12,
                  color: canAfford
                      ? AppColors.coinGold
                      : AppColors.textTertiary,
                ),
                const SizedBox(width: 2),
                Text(
                  gift.price.toString(),
                  style: AppTextStyles.caption.copyWith(
                    color: canAfford
                        ? AppColors.coinGold
                        : AppColors.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

