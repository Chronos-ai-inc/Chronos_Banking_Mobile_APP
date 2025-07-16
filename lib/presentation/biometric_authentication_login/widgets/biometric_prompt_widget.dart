import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BiometricPromptWidget extends StatefulWidget {
  final VoidCallback onBiometricSuccess;
  final VoidCallback onBiometricFailure;
  final VoidCallback onUsePassword;

  const BiometricPromptWidget({
    Key? key,
    required this.onBiometricSuccess,
    required this.onBiometricFailure,
    required this.onUsePassword,
  }) : super(key: key);

  @override
  State<BiometricPromptWidget> createState() => _BiometricPromptWidgetState();
}

class _BiometricPromptWidgetState extends State<BiometricPromptWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;

  bool _isAuthenticating = false;
  bool _authenticationFailed = false;
  int _failureCount = 0;
  bool _isLockedOut = false;
  int _lockoutTimer = 0;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startBiometricAuthentication();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    _pulseController.repeat(reverse: true);
  }

  Future<void> _startBiometricAuthentication() async {
    if (_isLockedOut) return;

    setState(() {
      _isAuthenticating = true;
      _authenticationFailed = false;
    });

    try {
      // Simulate biometric authentication delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock authentication result - in real app, use local_auth package
      final bool isAuthenticated =
          DateTime.now().millisecond % 3 != 0; // 66% success rate

      if (isAuthenticated) {
        _handleAuthenticationSuccess();
      } else {
        _handleAuthenticationFailure();
      }
    } catch (e) {
      _handleAuthenticationFailure();
    }
  }

  void _handleAuthenticationSuccess() {
    setState(() {
      _isAuthenticating = false;
      _authenticationFailed = false;
    });

    _pulseController.stop();
    widget.onBiometricSuccess();
  }

  void _handleAuthenticationFailure() {
    setState(() {
      _isAuthenticating = false;
      _authenticationFailed = true;
      _failureCount++;
    });

    _shakeController.forward().then((_) {
      _shakeController.reset();
    });

    if (_failureCount >= 3) {
      _startLockoutTimer();
    } else {
      // Auto retry after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _startBiometricAuthentication();
        }
      });
    }
  }

  void _startLockoutTimer() {
    setState(() {
      _isLockedOut = true;
      _lockoutTimer = 30;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_lockoutTimer <= 1) {
        timer.cancel();
        setState(() {
          _isLockedOut = false;
          _failureCount = 0;
          _lockoutTimer = 0;
        });
        _pulseController.repeat(reverse: true);
      } else {
        setState(() {
          _lockoutTimer--;
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Biometric Icon with Animation
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_shakeAnimation.value, 0),
                    child: Transform.scale(
                      scale: _isAuthenticating ? _pulseAnimation.value : 1.0,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _authenticationFailed
                              ? AppTheme.errorRed.withValues(alpha: 0.2)
                              : AppTheme.accentGold.withValues(alpha: 0.2),
                          border: Border.all(
                            color: _authenticationFailed
                                ? AppTheme.errorRed
                                : AppTheme.accentGold,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: _authenticationFailed
                                ? 'error_outline'
                                : 'fingerprint',
                            size: 8.w,
                            color: _authenticationFailed
                                ? AppTheme.errorRed
                                : AppTheme.accentGold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),

          SizedBox(height: 3.h),

          // Status Text
          Text(
            _getStatusText(),
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: _authenticationFailed
                  ? AppTheme.errorRed
                  : AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 1.h),

          // Subtitle Text
          Text(
            _getSubtitleText(),
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          if (_failureCount > 0 && !_isLockedOut) ...[
            SizedBox(height: 2.h),
            Text(
              'Attempt ${_failureCount}/3',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.warningAmber,
              ),
            ),
          ],

          if (_isLockedOut) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.errorRed.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'Too many attempts. Try again in ${_lockoutTimer}s',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ),
          ],

          SizedBox(height: 4.h),

          // Use Password Button
          TextButton(
            onPressed: _isAuthenticating ? null : widget.onUsePassword,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
            ),
            child: Text(
              'Use Password Instead',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.accentGold,
                decoration: TextDecoration.underline,
                decorationColor: AppTheme.accentGold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusText() {
    if (_isLockedOut) {
      return 'Authentication Locked';
    } else if (_isAuthenticating) {
      return 'Authenticating...';
    } else if (_authenticationFailed) {
      return 'Authentication Failed';
    } else {
      return 'Touch Sensor';
    }
  }

  String _getSubtitleText() {
    if (_isLockedOut) {
      return 'Please wait before trying again';
    } else if (_isAuthenticating) {
      return 'Please place your finger on the sensor';
    } else if (_authenticationFailed) {
      return 'Please try again';
    } else {
      return 'Place your finger on the sensor to continue';
    }
  }
}
