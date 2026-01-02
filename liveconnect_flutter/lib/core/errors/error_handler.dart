import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_exceptions.dart';

/// Global error handler for the app
class ErrorHandler {
  /// Handle and convert exceptions to AppException
  static AppException handleError(
    dynamic error,
    StackTrace? stackTrace, {
    String? defaultMessage,
  }) {
    if (error is AppException) {
      return error;
    }

    // Handle specific error types
    if (error is TimeoutException) {
      return TimeoutException(
        defaultMessage ?? 'Request timed out. Please try again.',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException) {
      return DataException(
        defaultMessage ?? 'Invalid data format. Please try again.',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Handle network errors
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('network') || errorString.contains('connection')) {
      return ConnectionException(
        defaultMessage ?? 'No internet connection. Please check your network.',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    if (errorString.contains('timeout')) {
      return TimeoutException(
        defaultMessage ?? 'Request timed out. Please try again.',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Handle platform errors
    if (errorString.contains('platform') || errorString.contains('channel')) {
      return UnknownException(
        defaultMessage ?? 'Platform error occurred. Please try again.',
        originalError: error,
        stackTrace: stackTrace,
      );
    }

    // Default to unknown exception
    return UnknownException(
      defaultMessage ?? 'An unexpected error occurred. Please try again.',
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  /// Log error for debugging
  static void logError(
    AppException error, {
    bool showInDebug = true,
  }) {
    if (kDebugMode && showInDebug) {
      debugPrint('❌ Error: ${error.message}');
      if (error.originalError != null) {
        debugPrint('Original error: ${error.originalError}');
      }
      if (error.stackTrace != null) {
        debugPrint('Stack trace: ${error.stackTrace}');
      }
    }
  }

  /// Show error snackbar
  static void showErrorSnackBar(
    BuildContext context,
    AppException error, {
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.message),
        backgroundColor: Colors.red,
        duration: duration,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show error dialog
  static Future<void> showErrorDialog(
    BuildContext context,
    AppException error, {
    VoidCallback? onRetry,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(error.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }

  /// Wrap async function with error handling
  static Future<T?> handleAsync<T>({
    required Future<T> Function() operation,
    String? errorMessage,
    bool showSnackBar = false,
    bool showDialog = false,
    BuildContext? context,
    VoidCallback? onError,
  }) async {
    try {
      return await operation();
    } catch (error, stackTrace) {
      final appError = handleError(error, stackTrace, defaultMessage: errorMessage);
      logError(appError);

      if (context != null) {
        if (showSnackBar) {
          showErrorSnackBar(context, appError);
        } else if (showDialog) {
          await showErrorDialog(context, appError);
        }
      }

      onError?.call();
      return null;
    }
  }
}

/// Extension for Future to add error handling
extension FutureErrorHandling<T> on Future<T> {
  /// Handle errors and return AppException
  Future<T?> handleError({
    String? errorMessage,
    bool showSnackBar = false,
    bool showDialog = false,
    BuildContext? context,
    VoidCallback? onError,
  }) {
    return ErrorHandler.handleAsync(
      operation: () => this,
      errorMessage: errorMessage,
      showSnackBar: showSnackBar,
      showDialog: showDialog,
      context: context,
      onError: onError,
    );
  }

  /// Handle errors and return Result
  Future<Result<T>> handleErrorWithResult({
    String? errorMessage,
  }) async {
    try {
      final value = await this;
      return Result.success(value);
    } catch (error, stackTrace) {
      final appError = ErrorHandler.handleError(
        error,
        stackTrace,
        defaultMessage: errorMessage,
      );
      ErrorHandler.logError(appError);
      return Result.failure(appError);
    }
  }
}

/// Result class for error handling
class Result<T> {
  final T? data;
  final AppException? error;
  final bool isSuccess;

  const Result._({
    this.data,
    this.error,
    required this.isSuccess,
  });

  factory Result.success(T data) {
    return Result._(
      data: data,
      isSuccess: true,
    );
  }

  factory Result.failure(AppException error) {
    return Result._(
      error: error,
      isSuccess: false,
    );
  }
}

