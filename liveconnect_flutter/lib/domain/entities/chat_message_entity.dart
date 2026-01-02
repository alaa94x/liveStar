/// Chat Message Entity (Domain Layer)
/// 
/// This is the domain entity representing a chat message.
/// It's independent of data sources and API implementations.
class ChatMessageEntity {
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
  final String? streamId;

  ChatMessageEntity({
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
    this.streamId,
  });
}




