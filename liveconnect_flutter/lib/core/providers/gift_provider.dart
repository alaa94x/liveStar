import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/gift_model.dart';
import '../data/mock_data.dart';

/// Provider for available gifts
final availableGiftsProvider = Provider<List<Gift>>((ref) {
  return AvailableGifts.allGifts;
});

/// Provider for popular gifts
final popularGiftsProvider = Provider<List<Gift>>((ref) {
  return AvailableGifts.popularGifts;
});

/// Provider for premium gifts
final premiumGiftsProvider = Provider<List<Gift>>((ref) {
  return AvailableGifts.premiumGifts;
});

/// Provider for quick gifts
final quickGiftsProvider = Provider<List<Gift>>((ref) {
  return AvailableGifts.quickGifts;
});

/// State notifier for gift sending
class GiftNotifier extends StateNotifier<Map<String, int>> {
  GiftNotifier() : super({});

  void sendGift(String streamId, String giftId, int amount) {
    final current = state[streamId] ?? 0;
    state = {...state, streamId: current + amount};
  }

  void reset(String streamId) {
    final newState = {...state};
    newState.remove(streamId);
    state = newState;
  }

  int getTotalForStream(String streamId) {
    return state[streamId] ?? 0;
  }
}

final giftNotifierProvider = StateNotifierProvider<GiftNotifier, Map<String, int>>((ref) {
  return GiftNotifier();
});

