import '../entities/gift_entity.dart';

/// Gift Repository Interface (Domain Layer)
/// 
/// This defines the contract for gift data operations.
/// Implementations are in the data layer.
abstract class GiftRepository {
  /// Get all available gifts
  /// 
  /// Returns list of available gift entities
  Future<List<GiftEntity>> getAvailableGifts();

  /// Send a gift to a live stream
  /// 
  /// [streamId] - The stream ID
  /// [giftId] - The gift ID to send
  /// [quantity] - Number of gifts to send (default: 1)
  /// Returns the transaction result
  Future<Map<String, dynamic>> sendGift(String streamId, String giftId, int quantity);

  /// Get user's coin balance
  /// 
  /// Returns the current coin balance
  Future<int> getCoinBalance();

  /// Get gift history
  /// 
  /// [userId] - Optional user ID filter
  /// Returns list of gift transactions
  Future<List<Map<String, dynamic>>> getGiftHistory({String? userId});
}




