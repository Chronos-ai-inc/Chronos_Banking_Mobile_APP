import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/navigation_buttons_widget.dart';
import './widgets/onboarding_slide_widget.dart';
import './widgets/page_indicator_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  // Mock data for onboarding slides
  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Secure Biometric\nBanking",
      "description":
          "Experience the future of banking with Face ID and fingerprint authentication. Your biometric data stays secure on your device while providing instant access to your accounts.",
      "imageUrl":
          "https://images.unsplash.com/photo-1563013544-824ae1b704d3?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
      "iconName": "fingerprint",
    },
    {
      "title": "AI-Powered\nWealth Advice",
      "description":
          "Get personalized investment recommendations and financial insights powered by advanced AI. Make smarter decisions with real-time market analysis and portfolio optimization.",
      "imageUrl":
          "https://images.pexels.com/photos/7947664/pexels-photo-7947664.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "iconName": "psychology",
    },
    {
      "title": "TickPay Credit\nSolutions",
      "description":
          "Access instant credit with our innovative TickPay feature. Get pre-approved credit lines, flexible payment options, and seamless integration with your banking experience.",
      "imageUrl":
          "https://images.pixabay.com/photo/2016/12/27/21/03/credit-card-1934964_1280.jpg",
      "iconName": "credit_card",
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding =
        prefs.getBool('has_seen_onboarding') ?? false;

    if (hasSeenOnboarding && mounted) {
      Navigator.pushReplacementNamed(context, '/registration-screen');
    }
  }

  Future<void> _markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });

    // Haptic feedback for page changes
    HapticFeedback.lightImpact();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    await _markOnboardingComplete();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/registration-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: Stack(
        children: [
          // Main content with PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _totalPages,
            itemBuilder: (context, index) {
              final slideData = _onboardingData[index];
              return OnboardingSlideWidget(
                title: slideData['title'] as String,
                description: slideData['description'] as String,
                imageUrl: slideData['imageUrl'] as String,
                iconName: slideData['iconName'] as String,
              );
            },
          ),

          // Skip button positioned at top-right
          Positioned(
            top: 6.h,
            right: 6.w,
            child: _currentPage < _totalPages - 1
                ? TextButton(
                    onPressed: _skipOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textSecondary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    ),
                    child: Text(
                      'Skip',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Bottom navigation area
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page indicators
                  PageIndicatorWidget(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                  ),

                  SizedBox(height: 4.h),

                  // Navigation buttons
                  NavigationButtonsWidget(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                    onNext: _nextPage,
                    onSkip: _skipOnboarding,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
