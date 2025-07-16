import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/authentication_status_widget.dart';
import './widgets/biometric_prompt_widget.dart';
import './widgets/chronos_logo_widget.dart';
import './widgets/user_avatar_widget.dart';

class BiometricAuthenticationLogin extends StatefulWidget {
  const BiometricAuthenticationLogin({Key? key}) : super(key: key);

  @override
  State<BiometricAuthenticationLogin> createState() =>
      _BiometricAuthenticationLoginState();
}

class _BiometricAuthenticationLoginState
    extends State<BiometricAuthenticationLogin> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late Animation<double> _backgroundAnimation;

  bool _isAuthenticating = false;
  bool _authenticationSuccess = false;
  bool _authenticationFailed = false;
  String _statusMessage = '';

  // Mock user data
  final Map<String, dynamic> _userData = {
    "id": 1,
    "name": "Sarah Johnson",
    "email": "sarah.johnson@chronosbank.com",
    "avatar":
        "https://images.unsplash.com/photo-1494790108755-2616b9e2b8b8?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
    "biometric_enabled": true,
    "last_login": "2025-07-16T15:45:30.000Z",
    "account_balance": "\$12,847.50",
    "account_number": "****1234"
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startBackgroundAnimation();
    _prepareAuthentication();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _backgroundAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundController,
      curve: Curves.easeInOut,
    ));
  }

  void _startBackgroundAnimation() {
    _backgroundController.forward();
  }

  void _prepareAuthentication() {
    // Simulate background data preparation
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _statusMessage = 'Ready for authentication';
        });
      }
    });
  }

  void _handleBiometricSuccess() {
    setState(() {
      _isAuthenticating = false;
      _authenticationSuccess = true;
      _authenticationFailed = false;
      _statusMessage = 'Authentication successful';
    });

    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Navigate to dashboard after success animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });
  }

  void _handleBiometricFailure() {
    setState(() {
      _isAuthenticating = false;
      _authenticationSuccess = false;
      _authenticationFailed = true;
      _statusMessage = 'Authentication failed. Please try again.';
    });

    // Provide haptic feedback for failure
    HapticFeedback.heavyImpact();
  }

  void _handleUsePassword() {
    Navigator.pushReplacementNamed(context, '/password-login');
  }

  void _navigateToRegistration() {
    Navigator.pushNamed(context, '/registration-screen');
  }

  void _navigateToOnboarding() {
    Navigator.pushNamed(context, '/onboarding-flow');
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: AnimatedBuilder(
        animation: _backgroundAnimation,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryDark,
                  AppTheme.secondaryDark
                      .withValues(alpha: _backgroundAnimation.value * 0.5),
                  AppTheme.primaryDark,
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100.h -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Top Section - Logo
                      Column(
                        children: [
                          SizedBox(height: 4.h),
                          const ChronosLogoWidget(),
                        ],
                      ),

                      // Middle Section - User Avatar and Biometric Prompt
                      Column(
                        children: [
                          UserAvatarWidget(
                            userName: (_userData["name"] as String?) ?? "User",
                            avatarUrl: _userData["avatar"] as String?,
                          ),
                          SizedBox(height: 2.h),
                          BiometricPromptWidget(
                            onBiometricSuccess: _handleBiometricSuccess,
                            onBiometricFailure: _handleBiometricFailure,
                            onUsePassword: _handleUsePassword,
                          ),
                        ],
                      ),

                      // Bottom Section - Status and Additional Options
                      Column(
                        children: [
                          if (_statusMessage.isNotEmpty)
                            AuthenticationStatusWidget(
                              isLoading: _isAuthenticating,
                              isSuccess: _authenticationSuccess,
                              isError: _authenticationFailed,
                              message: _statusMessage,
                            ),

                          SizedBox(height: 2.h),

                          // Additional Options
                          Container(
                            width: 80.w,
                            child: Column(
                              children: [
                                // Divider
                                Container(
                                  height: 1,
                                  color: AppTheme.dividerColor,
                                  margin: EdgeInsets.symmetric(vertical: 2.h),
                                ),

                                // Quick Actions
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: _navigateToOnboarding,
                                      child: Text(
                                        'Learn More',
                                        style: AppTheme
                                            .darkTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 4.h,
                                      color: AppTheme.dividerColor,
                                    ),
                                    TextButton(
                                      onPressed: _navigateToRegistration,
                                      child: Text(
                                        'New User?',
                                        style: AppTheme
                                            .darkTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppTheme.accentGold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 2.h),

                                // Security Notice
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.5.h),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceDark
                                        .withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppTheme.dividerColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'security',
                                        size: 4.w,
                                        color: AppTheme.accentGold,
                                      ),
                                      SizedBox(width: 2.w),
                                      Expanded(
                                        child: Text(
                                          'Your biometric data is encrypted and stored securely on your device',
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textSecondary,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 4.h),
                        ],
                      ),
                    ],
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
