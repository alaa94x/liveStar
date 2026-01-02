# Dummy Data Documentation

The LiveConnect Flutter app includes comprehensive dummy data for development and testing purposes.

## ✅ Available Mock Data

### 1. Live Streams (`MockData.liveStreams`)
- **10 live streams** with different categories
- Includes streamer names, photos, thumbnails, titles, and viewer counts
- Categories: chat, gaming, music, fashion, trending

**Usage:**
```dart
import 'package:liveconnect/core/data/mock_data.dart';

List<LiveStream> streams = MockData.liveStreams;
```

### 2. Gifts (`AvailableGifts`)
- **12 different gifts** (already in `gift_model.dart`)
- Price range: 50-2000 coins
- Categories: popular, premium

**Usage:**
```dart
import 'package:liveconnect/core/models/gift_model.dart';

List<Gift> gifts = AvailableGifts.allGifts;
List<Gift> popular = AvailableGifts.popularGifts;
List<Gift> premium = AvailableGifts.premiumGifts;
```

### 3. Comments (`MockData.mockComments`)
- **5 mock comments** for live streams
- Includes user names, avatars, messages, and timestamps

**Usage:**
```dart
List<Map<String, dynamic>> comments = MockData.mockComments;
```

### 4. Chat Messages (`MockData.mockChatMessages`)
- **5 mock chat messages** for conversations
- Includes sender info, message text, and timestamps

**Usage:**
```dart
List<Map<String, dynamic>> messages = MockData.mockChatMessages;
```

### 5. Conversations (`MockData.mockConversations`)
- **4 mock conversations** for messages list
- Includes user info, last message, unread count, online status

**Usage:**
```dart
List<Map<String, dynamic>> conversations = MockData.mockConversations;
```

### 6. Notifications (`MockData.mockNotifications`)
- **4 mock notifications** of different types
- Types: gift, follow, comment, like
- Includes read/unread status

**Usage:**
```dart
List<Map<String, dynamic>> notifications = MockData.mockNotifications;
```

### 7. User Profile (`MockData.mockUserProfile`)
- **Current user profile** data
- Includes followers, following, likes, coins

**Usage:**
```dart
Map<String, dynamic> profile = MockData.mockUserProfile;
```

### 8. Past Streams (`MockData.mockPastStreams`)
- **3 past stream recordings**
- Includes thumbnails, views, duration, dates

**Usage:**
```dart
List<Map<String, dynamic>> pastStreams = MockData.mockPastStreams;
```

### 9. Rewards (`MockData.mockRewards`)
- **3 reward transactions**
- Gift receipts with amounts and senders

**Usage:**
```dart
List<Map<String, dynamic>> rewards = MockData.mockRewards;
```

### 10. Wallet Transactions (`MockData.mockTransactions`)
- **3 wallet transactions**
- Types: earned, spent, purchased

**Usage:**
```dart
List<Map<String, dynamic>> transactions = MockData.mockTransactions;
```

## 📋 Helper Methods

### Get Streams by Category
```dart
List<LiveStream> gamingStreams = MockData.getStreamsByCategory('gaming');
List<LiveStream> musicStreams = MockData.getStreamsByCategory('music');
List<LiveStream> allStreams = MockData.getStreamsByCategory('all');
```

### Get Trending Streams
```dart
List<LiveStream> trending = MockData.trendingStreams;
```

### Get Hot Streams
```dart
List<LiveStream> hot = MockData.hotStreams;
```

## 🎯 Where Data is Used

### Already Integrated:
- ✅ **Home Screen**: Uses `MockData.getStreamsByCategory()` for filtered streams
- ✅ **Gift Model**: Uses `AvailableGifts` for all gift data
- ✅ **Topics**: Uses `AvailableTopics` for topic filtering

### Ready to Use:
- 📝 **Live Stream Screen**: Can use `MockData.mockComments`
- 📝 **Messages Screen**: Can use `MockData.mockConversations`
- 📝 **Chat Screen**: Can use `MockData.mockChatMessages`
- 📝 **Notifications Screen**: Can use `MockData.mockNotifications`
- 📝 **Profile Screen**: Can use `MockData.mockUserProfile` and `MockData.mockPastStreams`
- 📝 **Rewards Screen**: Can use `MockData.mockRewards`
- 📝 **Wallet Screen**: Can use `MockData.mockTransactions`

## 📦 Data Structure

### Live Stream
```dart
LiveStream(
  id: '1',
  streamerName: 'Emma Rose',
  streamerPhoto: 'https://...',
  thumbnail: 'https://...',
  title: 'Just chatting and vibing 💕✨',
  viewerCount: 2340,
  category: 'chat',
)
```

### Gift
```dart
Gift(
  id: '1',
  emoji: '🌹',
  name: 'Rose',
  price: 50,
  category: 'popular',
)
```

### Comment
```dart
{
  'id': 1,
  'user': 'Sarah123',
  'message': 'Love this stream! 💕',
  'avatar': 'https://...',
  'timestamp': DateTime.now(),
}
```

## 🚀 Running the App

The app is ready to run with all dummy data:

```bash
cd /Users/alaa/liveStar/liveconnect_flutter
flutter run
```

## 📝 Notes

- All images use Unsplash URLs (will load from internet)
- Avatar images use Pravatar (placeholder service)
- Data is static but can be easily replaced with API calls
- All timestamps are relative to current time
- Mock data is suitable for development and UI testing

## 🔄 Future Integration

When ready to integrate with a backend API:
1. Replace `MockData` calls with API service calls
2. Keep the same data structure for consistency
3. Add loading states and error handling
4. Implement caching if needed

---

**Status**: ✅ Complete dummy data available  
**Location**: `lib/core/data/mock_data.dart`  
**Usage**: Import and use throughout the app


