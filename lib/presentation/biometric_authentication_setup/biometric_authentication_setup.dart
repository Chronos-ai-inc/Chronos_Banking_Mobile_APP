import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/biometric_icon_widget.dart';
import './widgets/privacy_info_widget.dart';
import './widgets/security_benefits_widget.dart';
import './widgets/trust_signals_widget.dart';

class BiometricAuthenticationSetup extends StatefulWidget {
  const BiometricAuthenticationSetup({Key? key}) : super(key: key);

  @override
  State<BiometricAuthenticationSetup> createState() =>
      _BiometricAuthenticationSetupState();
}

class _BiometricAuthenticationSetupState
    extends State<BiometricAuthenticationSetup> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  bool _isLoading = false;
  String _biometricType = 'fingerprint';
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkBiometricAvailability();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _slideController.forward();
    _fadeController.forward();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      if (kIsWeb) {
        setState(() {
          _isBiometricAvailable = true;
          _biometricType = 'fingerprint';
        });
        return;
      }

      // Simulate biometric availability check
      await Future.delayed(const Duration(milliseconds: 500));

      if (!kIsWeb && Platform.isIOS) {
        // iOS Face ID/Touch ID detection simulation
        setState(() {
          _isBiometricAvailable = true;
          _biometricType = 'face'; // Could be 'face' or 'fingerprint'
        });
      } else {
        // Android fingerprint detection simulation
        setState(() {
          _isBiometricAvailable = true;
          _biometricType = 'fingerprint';
        });
      }
    } catch (e) {
      setState(() {
        _isBiometricAvailable = false;
        _biometricType = 'fingerprint';
      });
    }
  }

  Future<void> _enableBiometricLogin() async {
    if (!_isBiometricAvailable) {
      _showErrorDialog(
          'Biometric authentication is not available on this device.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate biometric enrollment process
      await Future.delayed(const Duration(seconds: 2));

      if (kIsWeb) {
        // Web implementation - show success
        _showSuccessAndNavigate();
      } else {
        // Mobile implementation - simulate platform-specific enrollment
        if (Platform.isIOS) {
          // iOS Face ID/Touch ID enrollment
          await _simulateIOSBiometricSetup();
        } else {
          // Android BiometricPrompt enrollment
          await _simulateAndroidBiometricSetup();
        }
        _showSuccessAndNavigate();
      }
    } catch (e) {
      _showErrorDialog(
          'Failed to set up biometric authentication. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _simulateIOSBiometricSetup() async {
    // Simulate iOS biometric setup with system prompts
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate haptic feedback
    HapticFeedback.lightImpact();

    // Store biometric preference
    await _storeBiometricPreference(true);
  }

  Future<void> _simulateAndroidBiometricSetup() async {
    // Simulate Android BiometricPrompt setup
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate haptic feedback
    HapticFeedback.selectionClick();

    // Store biometric preference
    await _storeBiometricPreference(true);
  }

  Future<void> _storeBiometricPreference(bool enabled) async {
    // Simulate storing biometric preference securely
    await Future.delayed(const Duration(milliseconds: 300));
  }

  void _showSuccessAndNavigate() {
    // Show success feedback
    HapticFeedback.heavyImpact();

    // Navigate to biometric login screen
    Navigator.pushReplacementNamed(context, '/biometric-authentication-login');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Setup Failed',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          message,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(color: AppTheme.accentGold),
            ),
          ),
        ],
      ),
    );
  }

  void _setupLater() {
    // Store preference to remind later
    _storeBiometricPreference(false);

    // Navigate to biometric login screen (will show password option)
    Navigator.pushReplacementNamed(context, '/biometric-authentication-login');
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.textPrimary,
            size: 6.w,
          ),
        ),
        title: Text(
          'Biometric Setup',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                children: [
                  SizedBox(height: 4.h),

                  // Biometric Icon with Animation
                  BiometricIconWidget(biometricType: _biometricType),

                  SizedBox(height: 4.h),

                  // Main Title
                  Text(
                    'Secure Your Account',
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 2.h),

                  // Subtitle
                  Text(
                    'Enable biometric authentication for fast and secure access to your Chronos Banking account.',
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 5.h),

                  // Security Benefits
                  const SecurityBenefitsWidget(),

                  SizedBox(height: 4.h),

                  // Trust Signals
                  const TrustSignalsWidget(),

                  SizedBox(height: 4.h),

                  // Privacy Information
                  const PrivacyInfoWidget(),

                  SizedBox(height: 5.h),

                  // Action Buttons
                  ActionButtonsWidget(
                    onEnableBiometric: _enableBiometricLogin,
                    onSetupLater: _setupLater,
                    isLoading: _isLoading,
                  ),

                  SizedBox(height: 3.h),

                  // Footer Note
                  Text(
                    'You can change this setting anytime in your account preferences.',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
