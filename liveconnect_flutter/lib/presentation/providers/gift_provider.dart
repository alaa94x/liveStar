import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/service_locator.dart';
import '../../../domain/repositories/gift_repository.dart';
import '../../../domain/entities/gift_entity.dart';

/// Gift Repository Provider
final giftRepositoryProvider = Provider<GiftRepository>((ref) {
  return ServiceLocator().giftRepository;
});

/// Available Gifts Provider
/// 
/// Fetches all available gifts.
/// Usage: ref.watch(availableGiftsProvider)
final availableGiftsProvider = FutureProvider<List<GiftEntity>>((ref) async {
  final repository = ref.watch(giftRepositoryProvider);
  return await repository.getAvailableGifts();
});

/// Coin Balance Provider
/// 
/// Fetches user's coin balance.
/// Usage: ref.watch(coinBalanceProvider)
final coinBalanceProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(giftRepositoryProvider);
  return await repository.getCoinBalance();
});

/// Send Gift Provider
/// 
/// Sends a gift to a live stream.
/// Usage: ref.read(sendGiftProvider('stream_1').notifier).send('gift_1', 1)
final sendGiftProvider = StateNotifierProvider.family<SendGiftNotifier, AsyncValue<Map<String, dynamic>>, String>((ref, streamId) {
  return SendGiftNotifier(ref, streamId);
});

class SendGiftNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final Ref ref;
  final String streamId;

  SendGiftNotifier(this.ref, this.streamId) : super(const AsyncValue.data({}));

  Future<void> send(String giftId, int quantity) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(giftRepositoryProvider);
      final result = await repository.sendGift(streamId, giftId, quantity);
      state = AsyncValue.data(result);
      
      // Refresh coin balance
      ref.invalidate(coinBalanceProvider);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}




