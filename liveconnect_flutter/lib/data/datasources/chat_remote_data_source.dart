import 'dart:async';
import '../../domain/entities/chat_message_entity.dart';

/// Chat Remote Data Source Interface
/// 
/// This handles API calls for chat data.
abstract class ChatRemoteDataSource {
  Stream<List<ChatMessageEntity>> watchMessages(String streamId);
  Future<ChatMessageEntity> sendMessage(String streamId, String message);
  Future<void> deleteMessage(String messageId);
  Future<void> pinMessage(String messageId);
  Future<void> unpinMessage(String messageId);
}

/// Chat Remote Data Source Implementation
/// 
/// TODO: Replace mock implementations with real API calls when backend is ready.
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Map<String, StreamController<List<ChatMessageEntity>>> _streamControllers = {};
  final Map<String, List<ChatMessageEntity>> _messageCache = {};

  @override
  Stream<List<ChatMessageEntity>> watchMessages(String streamId) {
    // TODO: Replace with real WebSocket/SSE connection when backend is ready
    // This should connect to a WebSocket endpoint for real-time chat
    // Example:
    // final channel = WebSocketChannel.connect(Uri.parse('ws://api.liveconnect.app/streams/$streamId/chat'));
    // return channel.stream.map((data) {
    //   final json = jsonDecode(data);
    //   return (json as List).map((e) => ChatMessageDTO.fromJson(e).toEntity()).toList();
    // });

    // MOCK IMPLEMENTATION – replace when backend is ready
    // Create or get stream controller for this stream
    if (!_streamControllers.containsKey(streamId)) {
      final controller = StreamController<List<ChatMessageEntity>>.broadcast();
      _streamControllers[streamId] = controller;
      _messageCache[streamId] = [];
      
      // Simulate incoming messages
      _simulateMessages(streamId, controller);
    }
    
    return _streamControllers[streamId]!.stream;
  }

  void _simulateMessages(String streamId, StreamController<List<ChatMessageEntity>> controller) {
    // MOCK IMPLEMENTATION – simulate periodic messages
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_streamControllers.containsKey(streamId)) {
        timer.cancel();
        return;
      }
      
      // Add a mock message
      final messages = _messageCache[streamId] ?? [];
      final newMessage = ChatMessageEntity(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        userId: 'user_${messages.length % 5}',
        userName: 'User ${messages.length % 5}',
        avatar: 'https://i.pravatar.cc/150?img=${messages.length % 5}',
        message: 'Mock message ${messages.length + 1}',
        timestamp: DateTime.now(),
        streamId: streamId,
      );
      
      messages.add(newMessage);
      _messageCache[streamId] = messages;
      controller.add(List.from(messages));
    });
  }

  @override
  Future<ChatMessageEntity> sendMessage(String streamId, String message) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.post(
    //   ApiConfig.sendComment(streamId),
    //   data: {'message': message},
    // );
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => ChatMessageDTO.fromJson(json as Map<String, dynamic>).toEntity(),
    // ).data;
    // return data!;

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
    
    final newMessage = ChatMessageEntity(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'current_user',
      userName: 'You',
      avatar: 'https://i.pravatar.cc/150',
      message: message,
      timestamp: DateTime.now(),
      streamId: streamId,
    );
    
    // Add to cache and notify stream
    final messages = _messageCache[streamId] ?? [];
    messages.add(newMessage);
    _messageCache[streamId] = messages;
    _streamControllers[streamId]?.add(List.from(messages));
    
    return newMessage;
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    // TODO: Replace with real API call when backend is ready
    // await apiClient.delete(ApiConfig.deleteComment(messageId));

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Remove from cache
    for (var entry in _messageCache.entries) {
      entry.value.removeWhere((msg) => msg.id == messageId);
      _streamControllers[entry.key]?.add(List.from(entry.value));
    }
  }

  @override
  Future<void> pinMessage(String messageId) async {
    // TODO: Replace with real API call when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unpinMessage(String messageId) async {
    // TODO: Replace with real API call when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Dispose all stream controllers
  void dispose() {
    for (var controller in _streamControllers.values) {
      controller.close();
    }
    _streamControllers.clear();
    _messageCache.clear();
  }
}




