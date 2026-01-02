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

class FollowersScreen extends ConsumerWidget {
  final String? userId;

  const FollowersScreen({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followersAsync = ref.watch(followersListProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Followers',
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
      body: followersAsync.when(
        data: (followers) {
          if (followers.isEmpty) {
            return const EmptyState(
              title: 'No followers yet',
              message: 'Start streaming to gain followers!',
              icon: Icons.people_outline,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: followers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final user = followers[index];
              return _buildFollowerItem(context, user);
            },
          );
        },
        loading: () => const LoadingWidget(message: 'Loading followers...'),
        error: (error, stack) => ErrorDisplay(
          error: const UnknownException('Failed to load followers'),
          onRetry: () => ref.refresh(followersListProvider),
          title: 'Error loading followers',
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildFollowerItem(BuildContext context, UserModel user) {
    final isFollowing = user.isFollowing;

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
            // Avatar
            SafeAvatar(
              imageUrl: user.avatar,
              radius: 28,
              fallbackText: user.name.substring(0, 1),
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
            // Follow/Unfollow button
            if (!isFollowing)
              TextButton(
                onPressed: () {
                  // Handle follow
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Follow',
                  style: AppTextStyles.labelMedium,
                ),
              )
            else
              OutlinedButton(
                onPressed: () {
                  // Handle unfollow
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.textSecondary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Following',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

