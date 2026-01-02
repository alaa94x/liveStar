import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import '../../../core/errors/app_exceptions.dart';

/// Chat Repository Implementation
/// 
/// This implements the repository interface using remote data source.
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ChatMessageEntity>> watchMessages(String streamId) {
    // Return real-time stream from remote data source
    // This will be connected to WebSocket/SSE when backend is ready
    return remoteDataSource.watchMessages(streamId);
  }

  @override
  Future<ChatMessageEntity> sendMessage(String streamId, String message) async {
    try {
      return await remoteDataSource.sendMessage(streamId, message);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to send message');
    }
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    try {
      await remoteDataSource.deleteMessage(messageId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to delete message');
    }
  }

  @override
  Future<void> pinMessage(String messageId) async {
    try {
      await remoteDataSource.pinMessage(messageId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to pin message');
    }
  }

  @override
  Future<void> unpinMessage(String messageId) async {
    try {
      await remoteDataSource.unpinMessage(messageId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to unpin message');
    }
  }
}

