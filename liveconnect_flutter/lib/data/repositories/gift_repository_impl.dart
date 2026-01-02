import '../../domain/entities/gift_entity.dart';
import '../../domain/repositories/gift_repository.dart';
import '../datasources/gift_remote_data_source.dart';
import '../../../core/errors/app_exceptions.dart';

/// Gift Repository Implementation
/// 
/// This implements the repository interface using remote data source.
class GiftRepositoryImpl implements GiftRepository {
  final GiftRemoteDataSource remoteDataSource;

  GiftRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<GiftEntity>> getAvailableGifts() async {
    try {
      return await remoteDataSource.getAvailableGifts();
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to load available gifts');
    }
  }

  @override
  Future<Map<String, dynamic>> sendGift(String streamId, String giftId, int quantity) async {
    try {
      return await remoteDataSource.sendGift(streamId, giftId, quantity);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to send gift');
    }
  }

  @override
  Future<int> getCoinBalance() async {
    try {
      return await remoteDataSource.getCoinBalance();
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to get coin balance');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getGiftHistory({String? userId}) async {
    try {
      return await remoteDataSource.getGiftHistory(userId: userId);
    } catch (e) {
      throw e is AppException
          ? e
          : NetworkException('Failed to load gift history');
    }
  }
}

