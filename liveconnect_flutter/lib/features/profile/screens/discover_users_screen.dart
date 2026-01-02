import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Screen for discovering and adding people to follow
class DiscoverUsersScreen extends ConsumerStatefulWidget {
  const DiscoverUsersScreen({super.key});

  @override
  ConsumerState<DiscoverUsersScreen> createState() => _DiscoverUsersScreenState();
}

class _DiscoverUsersScreenState extends ConsumerState<DiscoverUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Discover People',
          style: AppTextStyles.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by username or name...',
                  hintStyle: AppTextStyles.inputHint,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: AppTextStyles.bodyMedium,
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
          ),

          // Suggested users
          Expanded(
            child: _buildSuggestedUsers(),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildSuggestedUsers() {
    // Mock suggested users - in real app, fetch from API
    final suggestedUsers = List.generate(20, (index) {
      return UserModel(
        id: 'user_$index',
        name: 'User ${index + 1}',
        username: '@user${index + 1}',
        avatar: 'https://i.pravatar.cc/150?img=${index + 1}',
        bio: 'Live streamer and content creator ✨',
        isVerified: index % 5 == 0,
        isLive: index % 3 == 0,
        followersCount: 1000 + (index * 100),
        followingCount: 50 + index,
        likesCount: 5000 + (index * 200),
        isFollowing: false,
      );
    });

    // Filter by search query
    final filteredUsers = _searchQuery.isEmpty
        ? suggestedUsers
        : suggestedUsers.where((user) {
            final query = _searchQuery.toLowerCase();
            return user.name.toLowerCase().contains(query) ||
                user.username.toLowerCase().contains(query);
          }).toList();

    if (filteredUsers.isEmpty) {
      return const EmptyState(
        title: 'No users found',
        message: 'Try a different search term',
        icon: Icons.search_off,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredUsers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return _buildUserCard(user);
      },
    );
  }

  Widget _buildUserCard(UserModel user) {
    final isFollowing = ref.watch(userFollowStateProvider(user.id));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar with live indicator
          Stack(
            children: [
              SafeAvatar(
                imageUrl: user.avatar,
                radius: 32,
                fallbackText: user.name.substring(0, 1),
              ),
              if (user.isLive)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
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
          const SizedBox(width: 16),
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
                        size: 18,
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
                if (user.bio != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    user.bio!,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${_formatNumber(user.followersCount)} followers',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Follow button
          isFollowing
              ? OutlinedButton(
                  onPressed: () {
                    ref.read(userFollowStateProvider(user.id).notifier).toggleFollow();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.textSecondary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Following',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                )
              : GradientButton(
                  text: 'Follow',
                  onPressed: () {
                    ref.read(userFollowStateProvider(user.id).notifier).toggleFollow();
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

