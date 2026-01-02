import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  bool _isActiveRoute(BuildContext context, String route) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.matches.last.matchedLocation;
    return location == route;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home,
                label: 'Home',
                route: '/home',
              ),
              _buildNavItem(
                context,
                icon: Icons.explore,
                label: 'Explore',
                route: '/explore',
              ),
              _buildGoLiveButton(context),
              _buildNavItem(
                context,
                icon: Icons.chat_bubble_outline,
                label: 'Messages',
                route: '/messages',
              ),
              _buildNavItem(
                context,
                icon: Icons.person_outline,
                label: 'Profile',
                route: '/profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    final isActive = _isActiveRoute(context, route);
    
    return GestureDetector(
      onTap: () => context.go(route),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primaryPink : AppColors.textTertiary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoLiveButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/go-live'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withOpacity(0.6),
              blurRadius: 30,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: const Icon(
          Icons.radio,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}

