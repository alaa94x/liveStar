import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ChatConversationScreen extends StatelessWidget {
  final String chatId;

  const ChatConversationScreen({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const Center(
        child: Text(
          'Chat Conversation Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

