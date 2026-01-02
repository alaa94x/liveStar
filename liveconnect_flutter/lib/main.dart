import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/errors/app_exceptions.dart';
import 'core/errors/error_handler.dart';
import 'core/widgets/error_widgets.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Service Locator (API client, repositories, etc.)
  // This sets up all dependencies for API integration
  await ServiceLocator().init();
  
  // Set up global error handling
  _setupErrorHandling();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(
    const ProviderScope(
      child: LiveConnectApp(),
    ),
  );
}

/// Set up global error handling
void _setupErrorHandling() {
  // Handle Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    
    final error = ErrorHandler.handleError(
      details.exception,
      details.stack,
      defaultMessage: 'An unexpected error occurred',
    );
    
    ErrorHandler.logError(error);
  };

  // Handle asynchronous errors
  PlatformDispatcher.instance.onError = (error, stack) {
    final appError = ErrorHandler.handleError(
      error,
      stack,
      defaultMessage: 'An unexpected error occurred',
    );
    
    ErrorHandler.logError(appError);
    
    // Return true to indicate the error was handled
    return true;
  };

  // Note: Zone errors are handled by PlatformDispatcher.instance.onError
  // which is set above
}

class LiveConnectApp extends StatelessWidget {
  const LiveConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LiveConnect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Always use dark theme
      routerConfig: AppRouter.router,
      builder: (context, child) {
        // Wrap with error boundary
        return ErrorBoundary(
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
