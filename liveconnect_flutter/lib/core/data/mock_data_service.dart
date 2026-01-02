import '../errors/app_exceptions.dart';
import '../errors/error_handler.dart';
import 'mock_data.dart';
import '../models/live_stream_model.dart';

/// Service for accessing mock data with error handling
class MockDataService {
  /// Get live streams with error handling
  static Future<List<LiveStream>> getLiveStreams({
    String? category,
  }) async {
    return await ErrorHandler.handleAsync<List<LiveStream>>(
      operation: () async {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Simulate random errors (10% chance)
        if (DateTime.now().millisecond % 10 == 0) {
          throw ConnectionException('Failed to load streams');
        }

        if (category != null) {
          return MockData.getStreamsByCategory(category);
        }
        return MockData.liveStreams;
      },
      errorMessage: 'Failed to load live streams',
    ) ?? [];
  }

  /// Get videos with error handling
  static Future<List<Map<String, dynamic>>> getVideos({
    String? category,
  }) async {
    return await ErrorHandler.handleAsync<List<Map<String, dynamic>>>(
      operation: () async {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Simulate random errors (10% chance)
        if (DateTime.now().millisecond % 10 == 0) {
          throw ConnectionException('Failed to load videos');
        }

        if (category != null) {
          return MockData.getVideosByCategory(category);
        }
        return MockData.mockPastStreams;
      },
      errorMessage: 'Failed to load videos',
    ) ?? [];
  }

  /// Get conversations with error handling
  static Future<List<Map<String, dynamic>>> getConversations() async {
    return await ErrorHandler.handleAsync<List<Map<String, dynamic>>>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return MockData.mockConversations;
      },
      errorMessage: 'Failed to load conversations',
    ) ?? [];
  }

  /// Get notifications with error handling
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    return await ErrorHandler.handleAsync<List<Map<String, dynamic>>>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return MockData.mockNotifications;
      },
      errorMessage: 'Failed to load notifications',
    ) ?? [];
  }

  /// Get user profile with error handling
  static Future<Map<String, dynamic>?> getUserProfile() async {
    return await ErrorHandler.handleAsync<Map<String, dynamic>>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return MockData.mockUserProfile;
      },
      errorMessage: 'Failed to load user profile',
    );
  }

  /// Get rewards with error handling
  static Future<List<Map<String, dynamic>>> getRewards() async {
    return await ErrorHandler.handleAsync<List<Map<String, dynamic>>>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return MockData.mockRewards;
      },
      errorMessage: 'Failed to load rewards',
    ) ?? [];
  }

  /// Get wallet transactions with error handling
  static Future<List<Map<String, dynamic>>> getTransactions() async {
    return await ErrorHandler.handleAsync<List<Map<String, dynamic>>>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return MockData.mockTransactions;
      },
      errorMessage: 'Failed to load transactions',
    ) ?? [];
  }

  /// Get a live stream by ID with error handling
  static Future<LiveStream?> getLiveStreamById(String streamId) async {
    final result = await ErrorHandler.handleAsync<LiveStream>(
      operation: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        try {
          return MockData.liveStreams.firstWhere(
            (stream) => stream.id == streamId,
          );
        } catch (e) {
          throw NotFoundException('Stream not found');
        }
      },
      errorMessage: 'Failed to load stream',
    );
    return result;
  }
}

