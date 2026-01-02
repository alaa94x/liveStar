import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      icon: Icons.videocam,
      title: 'Go Live and Be Seen',
      description: 'Share your moments with the world. Start streaming in seconds and build your audience.',
    ),
    OnboardingSlide(
      icon: Icons.people,
      title: 'Chat and Meet New Friends',
      description: 'Connect with people worldwide. Make new friends and join vibrant communities.',
    ),
    OnboardingSlide(
      icon: Icons.card_giftcard,
      title: 'Earn Rewards and Gifts',
      description: 'Get rewarded for your content. Receive virtual gifts and turn them into real earnings.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  void _handleSkip() {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple.withOpacity(0.2),
              AppColors.primaryPink.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _handleSkip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                
                // Page View
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      return _OnboardingSlideWidget(slide: _slides[index]);
                    },
                  ),
                ),
                
                // Dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _slides.length,
                    (index) => Container(
                      width: _currentPage == index ? 32 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        gradient: _currentPage == index
                            ? AppColors.primaryGradient
                            : null,
                        color: _currentPage == index
                            ? null
                            : Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Next/Get Started button
                GradientButton(
                  text: _currentPage < _slides.length - 1 ? 'Next' : 'Get Started',
                  onPressed: _handleNext,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlideWidget extends StatelessWidget {
  final OnboardingSlide slide;

  const _OnboardingSlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPurple.withOpacity(0.5),
                blurRadius: 60,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Icon(
            slide.icon,
            size: 64,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 48),
        Text(
          slide.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            slide.description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });
}

