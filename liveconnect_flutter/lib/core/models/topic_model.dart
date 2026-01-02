import 'package:flutter/material.dart';

class Topic {
  final String id;
  final String label;
  final IconData icon;

  Topic({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class AvailableTopics {
  static List<Topic> get topics => [
    Topic(id: 'all', label: 'For You', icon: Icons.star),
    Topic(id: 'trending', label: 'Trending', icon: Icons.trending_up),
    Topic(id: 'hot', label: 'Hot', icon: Icons.local_fire_department),
    Topic(id: 'gaming', label: 'Gaming', icon: Icons.sports_esports),
    Topic(id: 'music', label: 'Music', icon: Icons.music_note),
    Topic(id: 'chat', label: 'Chat', icon: Icons.chat),
    Topic(id: 'fashion', label: 'Fashion', icon: Icons.checkroom),
  ];
}

