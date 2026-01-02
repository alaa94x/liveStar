import 'package:flutter/material.dart';
import '../errors/app_exceptions.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Error display widget
class ErrorDisplay extends StatelessWidget {
  final AppException error;
  final VoidCallback? onRetry;
  final String? title;
  final IconData? icon;

  const ErrorDisplay({
    super.key,
    required this.error,
    this.onRetry,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppColors.destructive,
            ),
            const SizedBox(height: 16),
            Text(
              title ?? 'Oops! Something went wrong',
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.message,
              style: AppTextStyles.bodySecondary,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state widget
class EmptyState extends StatelessWidget {
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.inbox,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: AppTextStyles.bodySecondary,
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading widget with error handling
class LoadingWidget extends StatelessWidget {
  final Widget? child;
  final String? message;

  const LoadingWidget({
    super.key,
    this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (child != null)
            child!
          else
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
            ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ],
      ),
    );
  }
}

/// Error boundary widget
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext, AppException)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppException? _error;

  @override
  void initState() {
    super.initState();
    // Catch Flutter errors
    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _error = UnknownException(
          details.exception.toString(),
          originalError: details.exception,
          stackTrace: details.stack,
        );
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, _error!);
      }
      return ErrorDisplay(error: _error!);
    }

    return widget.child;
  }
}

/// Safe image widget with error handling
class SafeImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SafeImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            Container(
              width: width,
              height: height,
              color: AppColors.cardBackground,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primaryPurple,
                  ),
                ),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: AppColors.cardBackground,
              child: Icon(
                Icons.broken_image,
                size: (width != null && height != null)
                    ? (width! < height! ? width! * 0.5 : height! * 0.5)
                    : 48,
                color: AppColors.textTertiary,
              ),
            );
      },
    );
  }
}

/// Safe network image for avatars
class SafeAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? fallbackText;

  const SafeAvatar({
    super.key,
    this.imageUrl,
    this.radius = 20,
    this.fallbackText,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: AppColors.primaryPurple,
        child: Text(
          fallbackText ?? '?',
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.6,
          ),
        ),
      );
    }

    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(imageUrl!),
      onBackgroundImageError: (exception, stackTrace) {
        // Handle error silently - will show fallback
      },
      child: imageUrl != null
          ? null
          : Text(
              fallbackText ?? '?',
              style: TextStyle(
                color: Colors.white,
                fontSize: radius * 0.6,
              ),
            ),
    );
  }
}

