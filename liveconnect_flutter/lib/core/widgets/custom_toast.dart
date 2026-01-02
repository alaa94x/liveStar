import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Custom toast widget for better positioning and styling
class CustomToast extends StatefulWidget {
  final String message;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;

  const CustomToast({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor = AppColors.primaryPink,
    this.textColor = Colors.white,
    this.duration = const Duration(seconds: 2),
  });

  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor ?? AppColors.primaryPink,
        textColor: textColor ?? Colors.white,
        duration: duration ?? const Duration(seconds: 2),
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);

    // Auto-remove after duration
    Future.delayed(duration ?? const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  @override
  State<CustomToast> createState() => _CustomToastState();
}

class _CustomToastState extends State<CustomToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 60,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: widget.backgroundColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.textColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          widget.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: widget.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToastOverlay extends StatefulWidget {
  final String message;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Duration duration;
  final VoidCallback onDismiss;

  const _ToastOverlay({
    required this.message,
    this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // Auto-dismiss
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
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
    // Position toast below top bar (80px from top) to avoid overlapping with icons
    final topPadding = MediaQuery.of(context).padding.top;
    return Positioned(
      top: topPadding + 80, // Position below top bar
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.backgroundColor,
                        widget.backgroundColor.withValues(alpha: 0.9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: widget.backgroundColor.withValues(alpha: 0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.textColor,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Flexible(
                        child: Text(
                          widget.message,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: widget.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

