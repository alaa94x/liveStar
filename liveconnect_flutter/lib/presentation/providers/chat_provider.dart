import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../../domain/entities/chat_message_entity.dart';

/// Chat Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ServiceLocator().chatRepository;
});

/// Watch Messages Provider
/// 
/// Watches messages for a live stream in real-time.
/// Usage: ref.watch(watchMessagesProvider('stream_1'))
final watchMessagesProvider = StreamProvider.family<List<ChatMessageEntity>, String>((ref, streamId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.watchMessages(streamId);
});

/// Send Message Provider
/// 
/// Sends a message to a live stream.
/// Usage: ref.read(sendMessageProvider('stream_1').notifier).send('Hello!')
final sendMessageProvider = StateNotifierProvider.family<SendMessageNotifier, AsyncValue<void>, String>((ref, streamId) {
  return SendMessageNotifier(ref, streamId);
});

class SendMessageNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final String streamId;

  SendMessageNotifier(this.ref, this.streamId) : super(const AsyncValue.data(null));

  Future<void> send(String message) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(chatRepositoryProvider);
      await repository.sendMessage(streamId, message);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}




