import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/verification_screen.dart';
import '../../features/auth/screens/interest_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/explore/screens/explore_screen.dart';
import '../../features/live_stream/screens/live_stream_screen.dart';
import '../../features/go_live/screens/go_live_setup_screen.dart';
import '../../features/messages/screens/messages_screen.dart';
import '../../features/messages/screens/chat_conversation_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/followers_screen.dart';
import '../../features/profile/screens/following_screen.dart';
import '../../features/profile/screens/discover_users_screen.dart';
import '../../features/gifts/screens/gift_store_screen.dart';
import '../../features/rewards/screens/rewards_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/brand_kit/screens/brand_kit_screen.dart';
import '../../features/test/screens/text_field_test_screen.dart';
import '../../core/theme/color_tester.dart';
import '../../core/widgets/color_palette_display.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/verification',
        name: 'verification',
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: '/interest',
        name: 'interest',
        builder: (context, state) => const InterestScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/explore',
        name: 'explore',
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: '/live/:id',
        name: 'live',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return LiveStreamScreen(streamId: id);
        },
      ),
      GoRoute(
        path: '/go-live',
        name: 'go-live',
        builder: (context, state) => const GoLiveSetupScreen(),
      ),
      GoRoute(
        path: '/messages',
        name: 'messages',
        builder: (context, state) => const MessagesScreen(),
      ),
      GoRoute(
        path: '/chat/:id',
        name: 'chat',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return ChatConversationScreen(chatId: id);
        },
      ),
             GoRoute(
               path: '/profile/:id?',
               name: 'profile',
               builder: (context, state) {
                 final id = state.pathParameters['id'];
                 return ProfileScreen(userId: id);
               },
             ),
             GoRoute(
               path: '/profile/:id/followers',
               name: 'followers',
               builder: (context, state) {
                 final id = state.pathParameters['id'];
                 return FollowersScreen(userId: id == 'current' ? null : id);
               },
             ),
             GoRoute(
               path: '/profile/:id/following',
               name: 'following',
               builder: (context, state) {
                 final id = state.pathParameters['id'];
                 return FollowingScreen(userId: id == 'current' ? null : id);
               },
             ),
             GoRoute(
               path: '/discover',
               name: 'discover',
               builder: (context, state) => const DiscoverUsersScreen(),
             ),
      GoRoute(
        path: '/gifts',
        name: 'gifts',
        builder: (context, state) => const GiftStoreScreen(),
      ),
      GoRoute(
        path: '/rewards',
        name: 'rewards',
        builder: (context, state) => const RewardsScreen(),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/brand-kit',
        name: 'brand-kit',
        builder: (context, state) => const BrandKitScreen(),
      ),
      GoRoute(
        path: '/test/text-fields',
        name: 'text-field-test',
        builder: (context, state) => const TextFieldTestScreen(),
      ),
      GoRoute(
        path: '/test/colors',
        name: 'color-test',
        builder: (context, state) => const ColorTestWidget(),
      ),
      GoRoute(
        path: '/test/color-palette',
        name: 'color-palette',
        builder: (context, state) => const ColorPaletteDisplay(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}

