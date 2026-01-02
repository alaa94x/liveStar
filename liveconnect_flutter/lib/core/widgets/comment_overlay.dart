import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CommentOverlay extends StatelessWidget {
  final List<CommentItem> comments;
  final int maxVisible;
  final EdgeInsets? padding;

  const CommentOverlay({
    super.key,
    required this.comments,
    this.maxVisible = 5,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) return const SizedBox.shrink();

    final visibleComments = comments.take(maxVisible).toList();

    return Positioned(
      right: padding?.right ?? 16,
      bottom: padding?.bottom ?? 200,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: visibleComments.reversed.map((comment) {
            return _CommentBubble(
              comment: comment,
              margin: const EdgeInsets.only(bottom: 10),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CommentItem {
  final String id;
  final String userId;
  final String userName;
  final String avatar;
  final String message;
  final DateTime timestamp;
  final bool isGift;
  final String? giftEmoji;
  final bool isModerator;
  final bool isVIP;

  CommentItem({
    required this.id,
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.message,
    required this.timestamp,
    this.isGift = false,
    this.giftEmoji,
    this.isModerator = false,
    this.isVIP = false,
  });
}

class _CommentBubble extends StatelessWidget {
  final CommentItem comment;
  final EdgeInsets margin;

  const _CommentBubble({
    required this.comment,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: comment.isGift
            ? LinearGradient(
                colors: [
                  AppColors.primaryPink.withValues(alpha: 0.3),
                  AppColors.primaryPurple.withValues(alpha: 0.2),
                ],
              )
            : null,
        color: comment.isGift
            ? null
            : Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(22),
        border: comment.isGift
            ? Border.all(
                color: AppColors.primaryPink.withValues(alpha: 0.4),
                width: 1,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with badges
          Stack(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: comment.isVIP
                        ? AppColors.coinGold
                        : Colors.white.withValues(alpha: 0.3),
                    width: comment.isVIP ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: comment.avatar,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.cardBackground,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
              if (comment.isModerator)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryPurple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  // Username with VIP badge
                  TextSpan(
                    text: comment.userName,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: comment.isVIP
                          ? AppColors.coinGold
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  if (comment.isVIP)
                    const TextSpan(
                      text: ' 👑',
                      style: TextStyle(fontSize: 13),
                    ),
                  const TextSpan(text: ': '),
                  // Message
                  TextSpan(
                    text: comment.message,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white,
                      fontWeight: comment.isGift
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                  if (comment.giftEmoji != null)
                    TextSpan(
                      text: ' ${comment.giftEmoji}',
                      style: const TextStyle(fontSize: 13),
                    ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

