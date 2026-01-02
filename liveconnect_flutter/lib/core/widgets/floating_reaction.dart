import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/reaction_model.dart';

class FloatingReaction extends StatefulWidget {
  final Reaction reaction;
  final VoidCallback onComplete;
  final Duration duration;

  const FloatingReaction({
    super.key,
    required this.reaction,
    required this.onComplete,
    this.duration = const Duration(milliseconds: 2000),
  });

  @override
  State<FloatingReaction> createState() => _FloatingReactionState();
}

class _FloatingReactionState extends State<FloatingReaction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateYAnimation;
  late Animation<double> _translateXAnimation;
  late Animation<double> _rotateAnimation;

  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Fade out animation
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    // Scale animation (pop in, then shrink)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.3),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 1.0),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.8),
        weight: 0.6,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Vertical movement (upward)
    _translateYAnimation = Tween<double>(
      begin: 0.0,
      end: -200.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Horizontal movement (slight random sway)
    final swayAmount = (_random.nextDouble() - 0.5) * 40;
    _translateXAnimation = Tween<double>(
      begin: 0.0,
      end: swayAmount,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Rotation animation
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: _random.nextDouble() * 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().then((_) {
      if (mounted) {
        widget.onComplete();
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
    final screenSize = MediaQuery.of(context).size;
    final startX = (screenSize.width * widget.reaction.startX / 100) - 20;
    final startY = screenSize.height - widget.reaction.startY;

    return Positioned(
      left: startX,
      top: startY,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: Offset(
                _translateXAnimation.value,
                _translateYAnimation.value,
              ),
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.reaction.color.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.reaction.color.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.reaction.color.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      widget.reaction.emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
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

