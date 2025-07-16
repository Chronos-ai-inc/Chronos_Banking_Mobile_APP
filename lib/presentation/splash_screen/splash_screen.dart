import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/chronos_logo_widget.dart';
import './widgets/force_update_modal_widget.dart';
import './widgets/loading_indicator_widget.dart';
import './widgets/retry_button_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  bool _showRetryButton = false;
  bool _showForceUpdateModal = false;
  bool _isInitializationComplete = false;

  // Mock user authentication states
  bool _isUserAuthenticated = false;
  bool _hasBiometricSession = false;
  bool _isNewUser = true;
  bool _needsForceUpdate = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _setSystemUIOverlay();
    await _checkConnectivity();
  }

  Future<void> _setSystemUIOverlay() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.primaryDark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        _showRetryAfterTimeout();
        return;
      }
      await _performInitialization();
    } catch (e) {
      _showRetryAfterTimeout();
    }
  }

  Future<void> _performInitialization() async {
    setState(() {
      _isLoading = true;
      _showRetryButton = false;
    });

    try {
      // Simulate banking service initialization
      await Future.delayed(const Duration(milliseconds: 800));

      // Check for force update requirement
      await _checkForceUpdate();

      if (_needsForceUpdate) {
        setState(() {
          _showForceUpdateModal = true;
          _isLoading = false;
        });
        return;
      }

      // Load user preferences and authentication state
      await _loadUserPreferences();

      // Fetch essential banking configuration
      await _fetchBankingConfig();

      // Prepare cached account data
      await _prepareCachedData();

      setState(() {
        _isInitializationComplete = true;
        _isLoading = false;
      });

      // Navigate based on user state after logo animation
      await Future.delayed(const Duration(milliseconds: 500));
      _navigateToNextScreen();
    } catch (e) {
      _showRetryAfterTimeout();
    }
  }

  Future<void> _checkForceUpdate() async {
    // Mock force update check - in real app, this would check app version
    await Future.delayed(const Duration(milliseconds: 200));

    // Simulate random force update requirement (5% chance for demo)
    final random = DateTime.now().millisecondsSinceEpoch % 20;
    _needsForceUpdate = random == 0;
  }

  Future<void> _loadUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Mock user authentication state
      _isUserAuthenticated = prefs.getBool('user_authenticated') ?? false;
      _hasBiometricSession = prefs.getBool('biometric_session_active') ?? false;
      _isNewUser = prefs.getBool('is_new_user') ?? true;

      await Future.delayed(const Duration(milliseconds: 300));
    } catch (e) {
      // Handle preferences loading error
      _isUserAuthenticated = false;
      _hasBiometricSession = false;
      _isNewUser = true;
    }
  }

  Future<void> _fetchBankingConfig() async {
    // Mock banking configuration fetch
    await Future.delayed(const Duration(milliseconds: 400));

    // Simulate configuration loading
    // In real app: API endpoints, feature flags, security settings
  }

  Future<void> _prepareCachedData() async {
    // Mock cached account data preparation
    await Future.delayed(const Duration(milliseconds: 300));

    // Simulate account data caching
    // In real app: recent transactions, account balances, user profile
  }

  void _showRetryAfterTimeout() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isInitializationComplete) {
        setState(() {
          _isLoading = false;
          _showRetryButton = true;
        });
      }
    });
  }

  void _navigateToNextScreen() {
    if (!mounted) return;

    String nextRoute;

    if (_isUserAuthenticated && _hasBiometricSession) {
      // Authenticated users with active biometric session go to home
      nextRoute = '/home-dashboard';
    } else if (_isNewUser) {
      // New users see onboarding flow
      nextRoute = '/onboarding-flow';
    } else {
      // Returning users reach biometric authentication
      nextRoute = '/biometric-authentication-login';
    }

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  void _handleRetry() {
    setState(() {
      _showRetryButton = false;
    });
    _checkConnectivity();
  }

  void _handleForceUpdate() {
    // In real app, this would redirect to app store
    // For demo, we'll just close the modal and continue
    setState(() {
      _showForceUpdateModal = false;
      _needsForceUpdate = false;
    });
    _performInitialization();
  }

  void _onLogoAnimationComplete() {
    if (_isInitializationComplete && !_showForceUpdateModal) {
      _navigateToNextScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Stack(
          children: [
            // Main splash content
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Chronos logo with animation
                  ChronosLogoWidget(
                    onAnimationComplete: _onLogoAnimationComplete,
                  ),

                  SizedBox(height: 3.h),

                  // App name
                  Text(
                    'CHRONOS',
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 4.0,
                      fontSize: 16.sp,
                    ),
                  ),

                  SizedBox(height: 0.5.h),

                  Text(
                    'BANKING',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentGold,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2.0,
                      fontSize: 11.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Loading indicator
                  LoadingIndicatorWidget(
                    isVisible: _isLoading,
                  ),

                  // Retry button
                  RetryButtonWidget(
                    onRetry: _handleRetry,
                    isVisible: _showRetryButton,
                  ),
                ],
              ),
            ),

            // Force update modal overlay
            if (_showForceUpdateModal)
              ForceUpdateModalWidget(
                onUpdate: _handleForceUpdate,
              ),
          ],
        ),
      ),
    );
  }
}
