import 'package:flutter/material.dart';

enum ReactionType {
  like,
  love,
  laugh,
  wow,
  fire,
  clap,
}

class Reaction {
  final String id;
  final ReactionType type;
  final String emoji;
  final Color color;
  final double startX;
  final double startY;
  final DateTime timestamp;

  Reaction({
    required this.id,
    required this.type,
    required this.emoji,
    required this.color,
    required this.startX,
    required this.startY,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  static ReactionType getTypeFromEmoji(String emoji) {
    switch (emoji) {
      case '❤️':
        return ReactionType.love;
      case '😂':
        return ReactionType.laugh;
      case '😮':
        return ReactionType.wow;
      case '🔥':
        return ReactionType.fire;
      case '👏':
        return ReactionType.clap;
      default:
        return ReactionType.like;
    }
  }

  static Reaction fromEmoji(String emoji, double startX, double startY) {
    final type = getTypeFromEmoji(emoji);
    return Reaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      emoji: emoji,
      color: _getColorForType(type),
      startX: startX,
      startY: startY,
    );
  }

  static Color _getColorForType(ReactionType type) {
    switch (type) {
      case ReactionType.love:
        return Colors.red;
      case ReactionType.laugh:
        return Colors.orange;
      case ReactionType.wow:
        return Colors.yellow;
      case ReactionType.fire:
        return Colors.deepOrange;
      case ReactionType.clap:
        return Colors.blue;
      default:
        return Colors.pink;
    }
  }
}

