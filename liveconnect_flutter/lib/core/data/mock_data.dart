import '../models/live_stream_model.dart';

/// Mock data service for development and testing
class MockData {
  // Live Streams
  static List<LiveStream> get liveStreams => [
    LiveStream(
      id: '1',
      streamerName: 'Emma Rose',
      streamerPhoto: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400',
      title: 'Just chatting and vibing 💕✨',
      viewerCount: 2340,
      category: 'chat',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      startTime: DateTime.now().subtract(const Duration(minutes: 45)),
      totalGiftsReceived: 1250,
      totalLikes: 8234,
    ),
    LiveStream(
      id: '2',
      streamerName: 'Alex Chen',
      streamerPhoto: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=400',
      title: 'Gaming session - Come hang out!',
      viewerCount: 5620,
      category: 'gaming',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      startTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
      totalGiftsReceived: 3200,
      totalLikes: 15620,
    ),
    LiveStream(
      id: '3',
      streamerName: 'Sophie Lee',
      streamerPhoto: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=400',
      title: 'Morning coffee chat ☕',
      viewerCount: 1850,
      category: 'chat',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
      startTime: DateTime.now().subtract(const Duration(minutes: 25)),
      totalGiftsReceived: 850,
      totalLikes: 4200,
    ),
    LiveStream(
      id: '4',
      streamerName: 'Maya Kim',
      streamerPhoto: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=400',
      title: 'Singing your favorite songs 🎤',
      viewerCount: 8920,
      category: 'music',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
      startTime: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
      totalGiftsReceived: 5600,
      totalLikes: 18920,
    ),
    LiveStream(
      id: '5',
      streamerName: 'Jake Wilson',
      streamerPhoto: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=400',
      title: 'Late night gaming stream',
      viewerCount: 3450,
      category: 'gaming',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      startTime: DateTime.now().subtract(const Duration(minutes: 55)),
      totalGiftsReceived: 2100,
      totalLikes: 8900,
    ),
    LiveStream(
      id: '6',
      streamerName: 'Luna Star',
      streamerPhoto: 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=400',
      title: 'Karaoke night! Join me 🎵',
      viewerCount: 6780,
      category: 'music',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
      startTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      totalGiftsReceived: 4800,
      totalLikes: 16780,
    ),
    LiveStream(
      id: '7',
      streamerName: 'Sarah Johnson',
      streamerPhoto: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      title: 'Fashion tips and styling 💃',
      viewerCount: 4200,
      category: 'fashion',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
      startTime: DateTime.now().subtract(const Duration(minutes: 35)),
      totalGiftsReceived: 1800,
      totalLikes: 9200,
    ),
    LiveStream(
      id: '8',
      streamerName: 'Mike Torres',
      streamerPhoto: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      title: 'Pro gaming tips and tricks 🎮',
      viewerCount: 12300,
      category: 'gaming',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
      startTime: DateTime.now().subtract(const Duration(hours: 3, minutes: 30)),
      totalGiftsReceived: 12500,
      totalLikes: 31200,
    ),
    LiveStream(
      id: '9',
      streamerName: 'Lisa Park',
      streamerPhoto: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
      title: 'Trending topics discussion 🔥',
      viewerCount: 5600,
      category: 'trending',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
      startTime: DateTime.now().subtract(const Duration(hours: 1, minutes: 10)),
      totalGiftsReceived: 3400,
      totalLikes: 15600,
    ),
    LiveStream(
      id: '10',
      streamerName: 'David Kim',
      streamerPhoto: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      thumbnail: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
      title: 'Music production live 🎹',
      viewerCount: 3200,
      category: 'music',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
      startTime: DateTime.now().subtract(const Duration(minutes: 40)),
      totalGiftsReceived: 1600,
      totalLikes: 7200,
    ),
  ];

  // Get streams by category
  static List<LiveStream> getStreamsByCategory(String category) {
    if (category == 'all') return liveStreams;
    return liveStreams.where((stream) => stream.category == category).toList();
  }

  // Get trending streams
  static List<LiveStream> get trendingStreams {
    return liveStreams..sort((a, b) => b.viewerCount.compareTo(a.viewerCount));
  }

  // Get hot streams (high viewer count)
  static List<LiveStream> get hotStreams {
    return liveStreams.where((s) => s.viewerCount > 5000).toList();
  }

  // Mock Comments
  static List<Map<String, dynamic>> get mockComments => [
    {
      'id': 1,
      'user': 'Sarah123',
      'message': 'Love this stream! 💕',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'id': 2,
      'user': 'Mike_89',
      'message': 'Amazing content!',
      'avatar': 'https://i.pravatar.cc/150?img=2',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 3)),
    },
    {
      'id': 3,
      'user': 'Luna_xo',
      'message': 'You are so talented! ✨',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 1)),
    },
    {
      'id': 4,
      'user': 'GamerPro',
      'message': 'Great game!',
      'avatar': 'https://i.pravatar.cc/150?img=4',
      'timestamp': DateTime.now(),
    },
    {
      'id': 5,
      'user': 'MusicLover',
      'message': 'This song is amazing! 🎵',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'timestamp': DateTime.now(),
    },
  ];

  // Mock Chat Messages
  static List<Map<String, dynamic>> get mockChatMessages => [
    {
      'id': 1,
      'text': 'Hey! Thanks for joining my stream today! 💕',
      'sender': 'them',
      'time': '10:30 AM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': 2,
      'text': 'I loved it! You were amazing 🎉',
      'sender': 'me',
      'time': '10:32 AM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2, minutes: 28)),
    },
    {
      'id': 3,
      'text': 'Thank you so much! That means a lot to me ✨',
      'sender': 'them',
      'time': '10:33 AM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2, minutes: 27)),
    },
    {
      'id': 4,
      'text': 'When is your next stream?',
      'sender': 'me',
      'time': '10:35 AM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2, minutes: 25)),
    },
    {
      'id': 5,
      'text': 'Tomorrow at 8 PM! Hope to see you there 🎬',
      'sender': 'them',
      'time': '10:36 AM',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2, minutes: 24)),
    },
  ];

  // Mock Conversations
  static List<Map<String, dynamic>> get mockConversations => [
    {
      'id': '1',
      'name': 'Emma Rose',
      'avatar': 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
      'lastMessage': 'Thanks for joining! 💕',
      'time': '2h ago',
      'unreadCount': 2,
      'isOnline': true,
      'username': '@emmarose',
    },
    {
      'id': '2',
      'name': 'Alex Chen',
      'avatar': 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
      'lastMessage': 'Gaming session was amazing!',
      'time': '5h ago',
      'unreadCount': 0,
      'isOnline': false,
      'username': '@alexchen',
    },
    {
      'id': '3',
      'name': 'Sophie Lee',
      'avatar': 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
      'lastMessage': 'See you tomorrow! ☕',
      'time': '1d ago',
      'unreadCount': 1,
      'isOnline': true,
      'username': '@sophielee',
    },
    {
      'id': '4',
      'name': 'Maya Kim',
      'avatar': 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
      'lastMessage': 'Your voice is beautiful! 🎤',
      'time': '2d ago',
      'unreadCount': 0,
      'isOnline': false,
      'username': '@mayakim',
    },
    {
      'id': '5',
      'name': 'Mike Torres',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      'lastMessage': 'Great tips on your stream!',
      'time': '3d ago',
      'unreadCount': 0,
      'isOnline': true,
      'username': '@miketorres',
    },
    {
      'id': '6',
      'name': 'Sarah Johnson',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      'lastMessage': 'Love your fashion sense! 💃',
      'time': '4d ago',
      'unreadCount': 3,
      'isOnline': false,
      'username': '@sarahjohnson',
    },
    {
      'id': '7',
      'name': 'Lisa Park',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
      'lastMessage': 'Thanks for the follow!',
      'time': '5d ago',
      'unreadCount': 0,
      'isOnline': true,
      'username': '@lisapark',
    },
    {
      'id': '8',
      'name': 'David Kim',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      'lastMessage': 'Amazing production skills!',
      'time': '6d ago',
      'unreadCount': 0,
      'isOnline': false,
      'username': '@davidkim',
    },
  ];

  // Mock Notifications
  static List<Map<String, dynamic>> get mockNotifications => [
    {
      'id': '1',
      'type': 'gift',
      'title': 'You received a gift!',
      'message': 'Emma Rose sent you a 🌹 Rose',
      'avatar': 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
      'time': '5m ago',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'isRead': false,
      'amount': 50,
    },
    {
      'id': '2',
      'type': 'follow',
      'title': 'New follower',
      'message': 'Alex Chen started following you',
      'avatar': 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
      'time': '1h ago',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'isRead': false,
    },
    {
      'id': '3',
      'type': 'comment',
      'title': 'New comment',
      'message': 'Sophie Lee commented on your stream',
      'avatar': 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
      'time': '2h ago',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': true,
    },
    {
      'id': '4',
      'type': 'like',
      'title': 'Stream liked',
      'message': 'Maya Kim and 15 others liked your stream',
      'avatar': 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
      'time': '3h ago',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
      'isRead': true,
    },
    {
      'id': '5',
      'type': 'gift',
      'title': 'You received a gift!',
      'message': 'Mike Torres sent you a 💎 Diamond',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      'time': '4h ago',
      'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
      'isRead': true,
      'amount': 200,
    },
    {
      'id': '6',
      'type': 'follow',
      'title': 'New follower',
      'message': 'Sarah Johnson started following you',
      'avatar': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      'time': '5h ago',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'isRead': true,
    },
    {
      'id': '7',
      'type': 'gift',
      'title': 'You received a gift!',
      'message': 'Luna Star sent you a 🚀 Rocket',
      'avatar': 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=200',
      'time': '1d ago',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
      'amount': 1000,
    },
    {
      'id': '8',
      'type': 'comment',
      'title': 'New comment',
      'message': 'David Kim commented on your video',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      'time': '2d ago',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
    },
  ];

  // Mock User Profile
  static Map<String, dynamic> get mockUserProfile => {
    'id': 'current_user',
    'name': 'Your Name',
    'username': '@yourname',
    'avatar': 'https://i.pravatar.cc/150?img=10',
    'bio': 'Live streamer and content creator ✨',
    'followers': 12500,
    'following': 450,
    'likes': 89200,
    'coins': 3450,
    'isVerified': false,
    'isLive': false,
  };

  // Mock Past Streams / Videos
  static List<Map<String, dynamic>> get mockPastStreams => [
    {
      'id': '1',
      'thumbnail': 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=400',
      'title': 'Just chatting and vibing 💕✨',
      'views': 12400,
      'duration': '2:45:30',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'streamerName': 'Emma Rose',
      'streamerPhoto': 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
      'category': 'chat',
      'likes': 1240,
    },
    {
      'id': '2',
      'thumbnail': 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=400',
      'title': 'Morning coffee chat ☕',
      'views': 8900,
      'duration': '1:30:15',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'streamerName': 'Sophie Lee',
      'streamerPhoto': 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
      'category': 'chat',
      'likes': 890,
    },
    {
      'id': '3',
      'thumbnail': 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=400',
      'title': 'Singing your favorite songs 🎤',
      'views': 15600,
      'duration': '3:15:00',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'streamerName': 'Maya Kim',
      'streamerPhoto': 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
      'category': 'music',
      'likes': 1560,
    },
    {
      'id': '4',
      'thumbnail': 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=400',
      'title': 'Epic Gaming Session - Final Boss Fight!',
      'views': 23400,
      'duration': '4:20:00',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'streamerName': 'Alex Chen',
      'streamerPhoto': 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
      'category': 'gaming',
      'likes': 2340,
    },
    {
      'id': '5',
      'thumbnail': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
      'title': 'Summer Fashion Haul 2024 👗',
      'views': 18900,
      'duration': '1:45:30',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'streamerName': 'Sarah Johnson',
      'streamerPhoto': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
      'category': 'fashion',
      'likes': 1890,
    },
    {
      'id': '6',
      'thumbnail': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'title': 'Pro Gaming Tips - Master Your Skills',
      'views': 45600,
      'duration': '3:00:00',
      'date': DateTime.now().subtract(const Duration(days: 6)),
      'streamerName': 'Mike Torres',
      'streamerPhoto': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      'category': 'gaming',
      'likes': 4560,
    },
    {
      'id': '7',
      'thumbnail': 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=400',
      'title': 'Karaoke Night - Best Hits Collection',
      'views': 32100,
      'duration': '2:30:00',
      'date': DateTime.now().subtract(const Duration(days: 8)),
      'streamerName': 'Luna Star',
      'streamerPhoto': 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=200',
      'category': 'music',
      'likes': 3210,
    },
    {
      'id': '8',
      'thumbnail': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
      'title': 'Trending Topics Discussion - Weekly Roundup',
      'views': 16700,
      'duration': '1:15:00',
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'streamerName': 'Lisa Park',
      'streamerPhoto': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200',
      'category': 'trending',
      'likes': 1670,
    },
    {
      'id': '9',
      'thumbnail': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
      'title': 'Music Production Live - Creating Beats',
      'views': 12800,
      'duration': '2:00:00',
      'date': DateTime.now().subtract(const Duration(days: 12)),
      'streamerName': 'David Kim',
      'streamerPhoto': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
      'category': 'music',
      'likes': 1280,
    },
    {
      'id': '10',
      'thumbnail': 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=400',
      'title': 'Late Night Gaming - Chill Vibes',
      'views': 9800,
      'duration': '3:45:00',
      'date': DateTime.now().subtract(const Duration(days: 14)),
      'streamerName': 'Jake Wilson',
      'streamerPhoto': 'https://images.unsplash.com/photo-1624749076719-52c184a2e2e3?w=200',
      'category': 'gaming',
      'likes': 980,
    },
  ];

  // Get videos by category
  static List<Map<String, dynamic>> getVideosByCategory(String category) {
    if (category == 'all') return mockPastStreams;
    return mockPastStreams.where((video) => video['category'] == category).toList();
  }

  // Get trending videos
  static List<Map<String, dynamic>> get trendingVideos {
    final sorted = List<Map<String, dynamic>>.from(mockPastStreams);
    sorted.sort((a, b) => b['views'].compareTo(a['views']));
    return sorted;
  }

  // Mock Rewards
  static List<Map<String, dynamic>> get mockRewards => [
    {
      'id': '1',
      'type': 'gift',
      'title': 'Received 🌹 Rose',
      'amount': 50,
      'from': 'Emma Rose',
      'avatar': 'https://images.unsplash.com/photo-1635080472002-ca760a070e37?w=200',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'giftEmoji': '🌹',
    },
    {
      'id': '2',
      'type': 'gift',
      'title': 'Received 💎 Diamond',
      'amount': 200,
      'from': 'Alex Chen',
      'avatar': 'https://images.unsplash.com/photo-1668531282396-96bea4cacab5?w=200',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'giftEmoji': '💎',
    },
    {
      'id': '3',
      'type': 'gift',
      'title': 'Received 🚀 Rocket',
      'amount': 1000,
      'from': 'Sophie Lee',
      'avatar': 'https://images.unsplash.com/photo-1758272423042-fb02e32195f0?w=200',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'giftEmoji': '🚀',
    },
    {
      'id': '4',
      'type': 'gift',
      'title': 'Received 🎁 Gift Box',
      'amount': 500,
      'from': 'Mike Torres',
      'avatar': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'giftEmoji': '🎁',
    },
    {
      'id': '5',
      'type': 'gift',
      'title': 'Received ⭐ Star',
      'amount': 100,
      'from': 'Maya Kim',
      'avatar': 'https://images.unsplash.com/photo-1589553009868-c7b2bb474531?w=200',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'giftEmoji': '⭐',
    },
    {
      'id': '6',
      'type': 'gift',
      'title': 'Received 💐 Bouquet',
      'amount': 300,
      'from': 'Luna Star',
      'avatar': 'https://images.unsplash.com/photo-1544704512-12bc4c1628ed?w=200',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'giftEmoji': '💐',
    },
  ];

  // Mock Wallet Transactions
  static List<Map<String, dynamic>> get mockTransactions => [
    {
      'id': '1',
      'type': 'earned',
      'description': 'Gift from Emma Rose',
      'amount': 50,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'icon': '🌹',
    },
    {
      'id': '2',
      'type': 'spent',
      'description': 'Sent gift to Alex Chen',
      'amount': -200,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'icon': '💎',
    },
    {
      'id': '3',
      'type': 'purchased',
      'description': 'Purchased 1000 coins',
      'amount': 1000,
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'icon': '💳',
    },
    {
      'id': '4',
      'type': 'earned',
      'description': 'Gift from Sophie Lee',
      'amount': 1000,
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'icon': '🚀',
    },
    {
      'id': '5',
      'type': 'spent',
      'description': 'Sent gift to Maya Kim',
      'amount': -100,
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'icon': '⭐',
    },
    {
      'id': '6',
      'type': 'purchased',
      'description': 'Purchased 500 coins',
      'amount': 500,
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'icon': '💳',
    },
    {
      'id': '7',
      'type': 'earned',
      'description': 'Gift from Mike Torres',
      'amount': 500,
      'date': DateTime.now().subtract(const Duration(days: 8)),
      'icon': '🎁',
    },
    {
      'id': '8',
      'type': 'spent',
      'description': 'Sent gift to Luna Star',
      'amount': -300,
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'icon': '💐',
    },
  ];

  // Get wallet balance
  static int get walletBalance {
    int balance = 0;
    for (var transaction in mockTransactions) {
      balance += (transaction['amount'] as num).toInt();
    }
    return balance;
  }

  // Get total earned
  static int get totalEarned {
    return mockTransactions
        .where((t) => t['type'] == 'earned')
        .fold(0, (sum, t) => sum + (t['amount'] as int));
  }

  // Get total spent
  static int get totalSpent {
    return mockTransactions
        .where((t) => t['type'] == 'spent')
        .fold(0, (sum, t) => sum + (t['amount'] as int).abs());
  }
}


