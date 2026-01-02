import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../../core/widgets/error_widgets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/data/mock_data_service.dart';
import '../../../core/errors/app_exceptions.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Map<String, dynamic>> _conversations = [];
  bool _isLoading = true;
  AppException? _error;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final conversations = await MockDataService.getConversations();
      setState(() {
        _conversations = conversations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e is AppException
            ? e
            : const UnknownException('Failed to load conversations');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          title: Text(
            'Messages',
            style: AppTextStyles.headlineMedium,
          ),
        ),
        body: const LoadingWidget(message: 'Loading messages...'),
        bottomNavigationBar: const BottomNavBar(),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: AppColors.backgroundDark,
        appBar: AppBar(
          title: Text(
            'Messages',
            style: AppTextStyles.headlineMedium,
          ),
        ),
        body: ErrorDisplay(
          error: _error!,
          onRetry: _loadConversations,
          title: 'Failed to load messages',
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: AppTextStyles.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: _conversations.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _conversations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final conversation = _conversations[index];
                return _buildConversationItem(context, conversation);
              },
            ),
      bottomNavigationBar: const BottomNavBar(),
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
              Icons.chat_bubble_outline,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              'No messages yet',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a conversation with someone',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversationItem(
    BuildContext context,
    Map<String, dynamic> conversation,
  ) {
    return InkWell(
      onTap: () => context.push('/chat/${conversation['id']}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                SafeAvatar(
                  imageUrl: conversation['avatar'],
                  radius: 28,
                  fallbackText: conversation['name']?.substring(0, 1) ?? '?',
                ),
                if (conversation['isOnline'] == true)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.backgroundDark,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['name'],
                          style: AppTextStyles.titleMedium,
                        ),
                      ),
                      Text(
                        conversation['time'],
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation['lastMessage'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation['unreadCount'] > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            conversation['unreadCount'].toString(),
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
