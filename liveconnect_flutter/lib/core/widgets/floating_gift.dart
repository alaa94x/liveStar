import 'package:flutter/material.dart';

/// Widget for displaying floating gift animations on live stream
class FloatingGift extends StatefulWidget {
  final String emoji;
  final double startX; // Percentage from left (0-100)
  final VoidCallback onAnimationComplete;

  const FloatingGift({
    super.key,
    required this.emoji,
    required this.startX,
    required this.onAnimationComplete,
  });

  @override
  State<FloatingGift> createState() => _FloatingGiftState();
}

class _FloatingGiftState extends State<FloatingGift>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateYAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
    ));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.5, end: 1.2),
        weight: 0.3,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 0.4,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.8),
        weight: 0.3,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _translateYAnimation = Tween<double>(
      begin: 0.0,
      end: -200.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward().then((_) {
      // Only call callback if widget is still mounted
      if (mounted) {
        try {
          widget.onAnimationComplete();
        } catch (e) {
          // Ignore errors if parent widget is disposed
          // This prevents lifecycle errors
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final startX = (screenWidth * widget.startX / 100) - 20; // Center the emoji

    return Positioned(
      left: startX,
      bottom: 80,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, _translateYAnimation.value),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    widget.emoji,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

