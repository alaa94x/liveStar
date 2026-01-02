import '../entities/chat_message_entity.dart';

/// Chat Repository Interface (Domain Layer)
/// 
/// This defines the contract for chat data operations.
/// Implementations are in the data layer.
abstract class ChatRepository {
  /// Watch messages for a live stream
  /// 
  /// [streamId] - The stream ID
  /// Returns a stream of chat messages for real-time updates
  Stream<List<ChatMessageEntity>> watchMessages(String streamId);

  /// Send a message to a live stream
  /// 
  /// [streamId] - The stream ID
  /// [message] - The message text
  /// Returns the sent message entity
  Future<ChatMessageEntity> sendMessage(String streamId, String message);

  /// Delete a message
  /// 
  /// [messageId] - The message ID to delete
  Future<void> deleteMessage(String messageId);

  /// Pin a message (host only)
  /// 
  /// [messageId] - The message ID to pin
  Future<void> pinMessage(String messageId);

  /// Unpin a message (host only)
  /// 
  /// [messageId] - The message ID to unpin
  Future<void> unpinMessage(String messageId);
}




