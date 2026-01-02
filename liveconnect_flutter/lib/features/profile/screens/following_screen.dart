import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/errors/app_exceptions.dart';

class FollowingScreen extends ConsumerWidget {
  final String? userId;

  const FollowingScreen({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followingAsync = ref.watch(followingListProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Following',
          style: AppTextStyles.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              // Implement search
            },
          ),
        ],
      ),
      body: followingAsync.when(
        data: (following) {
          if (following.isEmpty) {
            return const EmptyState(
              title: 'Not following anyone',
              message: 'Discover and follow creators you love!',
              icon: Icons.person_add_outlined,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: following.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final user = following[index];
              return _buildFollowingItem(context, user);
            },
          );
        },
        loading: () => const LoadingWidget(message: 'Loading following...'),
        error: (error, stack) => ErrorDisplay(
          error: const UnknownException('Failed to load following'),
          onRetry: () => ref.refresh(followingListProvider),
          title: 'Error loading following',
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildFollowingItem(BuildContext context, UserModel user) {
    return GestureDetector(
      onTap: () => context.push('/profile/${user.id}'),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar with live indicator
            Stack(
              children: [
                SafeAvatar(
                  imageUrl: user.avatar,
                  radius: 28,
                  fallbackText: user.name.substring(0, 1),
                ),
                if (user.isLive)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.liveRed,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.cardBackground,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: AppTextStyles.titleMedium,
                      ),
                      if (user.isVerified) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified,
                          color: AppColors.primaryPurple,
                          size: 16,
                        ),
                      ],
                      if (user.isLive) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.liveRed,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'LIVE',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.username,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            // Unfollow button
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
              onPressed: () {
                _showUnfollowDialog(context, user);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUnfollowDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: Text(
          'Unfollow ${user.name}?',
          style: AppTextStyles.titleLarge,
        ),
        content: Text(
          'You will no longer receive notifications about their streams.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.buttonMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle unfollow
              Navigator.pop(context);
            },
            child: Text(
              'Unfollow',
              style: AppTextStyles.buttonMedium.copyWith(
                color: AppColors.destructive,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

