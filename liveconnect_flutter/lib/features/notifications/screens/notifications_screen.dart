import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = MockData.mockNotifications;
    final unreadCount = notifications.where((n) => n['isRead'] == false).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.headlineMedium,
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {},
              child: Text(
                'Mark all as read',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryPink,
                ),
              ),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(notification);
              },
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
              Icons.notifications_none,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No notifications',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] == true;
    final type = notification['type'];

    IconData iconData;
    Color iconColor;

    switch (type) {
      case 'gift':
        iconData = Icons.card_giftcard;
        iconColor = AppColors.primaryPink;
        break;
      case 'follow':
        iconData = Icons.person_add;
        iconColor = AppColors.primaryPurple;
        break;
      case 'comment':
        iconData = Icons.comment;
        iconColor = Colors.blue;
        break;
      case 'like':
        iconData = Icons.favorite;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = AppColors.textSecondary;
    }

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRead ? AppColors.cardBackground : AppColors.cardBackground.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: isRead
              ? null
              : Border.all(
                  color: AppColors.primaryPurple.withValues(alpha: 0.3),
                  width: 1,
                ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['title'],
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['message'],
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['time'],
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(notification['avatar']),
            ),
          ],
        ),
      ),
    );
  }
}
