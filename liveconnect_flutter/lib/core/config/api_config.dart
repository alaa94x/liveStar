/// API Configuration
/// 
/// This file contains API endpoint configuration.
/// Update the base URL and endpoints when you integrate your backend.
class ApiConfig {
  // Base URL - Update this with your backend URL
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.liveconnect.app', // Replace with your API URL
  );

  // API Version
  static const String apiVersion = '/v1';

  // Full API URL
  static String get apiUrl => '$baseUrl$apiVersion';

  // Endpoints
  static const String auth = '/auth';
  static const String users = '/users';
  static const String streams = '/streams';
  static const String gifts = '/gifts';
  static const String comments = '/comments';
  static const String messages = '/messages';
  static const String notifications = '/notifications';
  static const String rewards = '/rewards';
  static const String wallet = '/wallet';
  static const String leaderboard = '/leaderboard';
  static const String search = '/search';

  // Auth Endpoints
  static String get login => '$auth/login';
  static String get register => '$auth/register';
  static String get verify => '$auth/verify';
  static String get refreshToken => '$auth/refresh';
  static String get logout => '$auth/logout';
  static String get forgotPassword => '$auth/forgot-password';
  static String get resetPassword => '$auth/reset-password';

  // User Endpoints
  static String userProfile(String userId) => '$users/$userId';
  static String userFollowers(String userId) => '$users/$userId/followers';
  static String userFollowing(String userId) => '$users/$userId/following';
  static String followUser(String userId) => '$users/$userId/follow';
  static String unfollowUser(String userId) => '$users/$userId/unfollow';
  static String get currentUser => '$users/me';
  static String updateProfile(String userId) => '$users/$userId';
  static String uploadAvatar(String userId) => '$users/$userId/avatar';

  // Stream Endpoints
  static String get liveStreams => '$streams/live';
  static String streamById(String streamId) => '$streams/$streamId';
  static String get goLive => '$streams/go-live';
  static String endStream(String streamId) => '$streams/$streamId/end';
  static String streamViewers(String streamId) => '$streams/$streamId/viewers';
  static String streamComments(String streamId) => '$streams/$streamId/comments';
  static String streamGifts(String streamId) => '$streams/$streamId/gifts';
  static String streamLike(String streamId) => '$streams/$streamId/like';
  static String streamShare(String streamId) => '$streams/$streamId/share';
  static String streamReactions(String streamId) => '$streams/$streamId/reactions';

  // Gift Endpoints
  static String get availableGifts => '$gifts';
  static String sendGift(String streamId) => '$gifts/send/$streamId';
  static String giftHistory(String userId) => '$gifts/history/$userId';

  // Comment Endpoints
  static String sendComment(String streamId) => '$comments/$streamId';
  static String deleteComment(String commentId) => '$comments/$commentId';

  // Message Endpoints
  static String get conversations => '$messages/conversations';
  static String conversation(String conversationId) => '$messages/conversations/$conversationId';
  static String sendMessage(String conversationId) => '$messages/conversations/$conversationId/messages';

  // Notification Endpoints
  static String get notificationsList => '$notifications';
  static String markNotificationRead(String notificationId) => '$notifications/$notificationId/read';
  static String markAllNotificationsRead => '$notifications/read-all';

  // Reward Endpoints
  static String get rewards => '$rewards';
  static String claimReward(String rewardId) => '$rewards/$rewardId/claim';

  // Wallet Endpoints
  static String get walletBalance => '$wallet/balance';
  static String get walletTransactions => '$wallet/transactions';
  static String addCoins => '$wallet/add-coins';

  // Leaderboard Endpoints
  static String leaderboardByType(String type) => '$leaderboard/$type'; // daily, weekly, monthly, all-time

  // Search Endpoints
  static String searchUsers(String query) => '$search/users?q=$query';
  static String searchStreams(String query) => '$search/streams?q=$query';

  // Timeout Configuration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);
}




