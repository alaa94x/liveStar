import '../repositories/gift_repository.dart';
import '../repositories/user_repository.dart';

/// Send Gift Use Case
/// 
/// This use case handles the business logic for sending gifts.
/// It validates coin balance and sends the gift.
class SendGiftUseCase {
  final GiftRepository giftRepository;
  final UserRepository userRepository;

  SendGiftUseCase({
    required this.giftRepository,
    required this.userRepository,
  });

  /// Execute the use case
  /// 
  /// [streamId] - The stream ID
  /// [giftId] - The gift ID to send
  /// [quantity] - Number of gifts to send
  /// Returns the transaction result
  /// Throws [InsufficientCoinsException] if user doesn't have enough coins
  Future<Map<String, dynamic>> execute({
    required String streamId,
    required String giftId,
    int quantity = 1,
  }) async {
    // Get user's coin balance
    final balance = await giftRepository.getCoinBalance();
    
    // Get gift details
    final gifts = await giftRepository.getAvailableGifts();
    final gift = gifts.firstWhere((g) => g.id == giftId);
    
    // Check if user has enough coins
    final totalCost = gift.price * quantity;
    if (balance < totalCost) {
      throw InsufficientCoinsException(
        'Insufficient coins. Required: $totalCost, Available: $balance',
      );
    }
    
    // Send the gift
    return await giftRepository.sendGift(streamId, giftId, quantity);
  }
}

/// Exception for insufficient coins
class InsufficientCoinsException implements Exception {
  final String message;
  InsufficientCoinsException(this.message);
  
  @override
  String toString() => message;
}




