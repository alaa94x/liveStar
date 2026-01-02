import '../../domain/entities/gift_entity.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/gift_model.dart' as gift_model;

/// Gift Remote Data Source Interface
abstract class GiftRemoteDataSource {
  Future<List<GiftEntity>> getAvailableGifts();
  Future<Map<String, dynamic>> sendGift(String streamId, String giftId, int quantity);
  Future<int> getCoinBalance();
  Future<List<Map<String, dynamic>>> getGiftHistory({String? userId});
}

/// Gift Remote Data Source Implementation
/// 
/// TODO: Replace mock implementations with real API calls when backend is ready.
class GiftRemoteDataSourceImpl implements GiftRemoteDataSource {
  @override
  Future<List<GiftEntity>> getAvailableGifts() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(ApiConfig.availableGifts);
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => (json as List)
    //       .map((e) => GiftDTO.fromJson(e as Map<String, dynamic>))
    //       .map((dto) => dto.toEntity())
    //       .toList(),
    // ).data;
    // return data ?? [];

    // MOCK IMPLEMENTATION – replace when backend is ready
    // Use existing mock gift data
    await Future.delayed(const Duration(milliseconds: 300));
    
    return gift_model.AvailableGifts.allGifts.map((gift) {
      return GiftEntity(
        id: gift.id,
        name: gift.name,
        emoji: gift.emoji,
        price: gift.price,
        category: gift.category,
        animationType: gift.animationType,
        isPopular: gift.isPopular,
      );
    }).toList();
  }

  @override
  Future<Map<String, dynamic>> sendGift(String streamId, String giftId, int quantity) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.post(
    //   ApiConfig.sendGift(streamId),
    //   data: {'giftId': giftId, 'quantity': quantity},
    // );
    // final data = ApiResponse.fromJson(response.data, (json) => json as Map<String, dynamic>).data;
    // return data ?? {};

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    
    return {
      'success': true,
      'giftId': giftId,
      'quantity': quantity,
      'streamId': streamId,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<int> getCoinBalance() async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(ApiConfig.walletBalance);
    // final data = ApiResponse.fromJson(response.data, (json) => json['balance'] as int).data;
    // return data ?? 0;

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 300));
    return 3450; // Mock balance
  }

  @override
  Future<List<Map<String, dynamic>>> getGiftHistory({String? userId}) async {
    // TODO: Replace with real API call when backend is ready
    // final response = await apiClient.get(
    //   ApiConfig.giftHistory(userId ?? 'current'),
    // );
    // final data = ApiResponse.fromJson(
    //   response.data,
    //   (json) => (json as List).map((e) => Map<String, dynamic>.from(e)).toList(),
    // ).data;
    // return data ?? [];

    // MOCK IMPLEMENTATION – replace when backend is ready
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}




