import 'package:flutter/material.dart';

import '../presentation/biometric_authentication_login/biometric_authentication_login.dart';
import '../presentation/biometric_authentication_setup/biometric_authentication_setup.dart';
import '../presentation/cards_management_screen/cards_management_screen.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/identity_verification_screen/identity_verification_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String biometricAuthenticationSetup =
      '/biometric-authentication-setup';
  static const String biometricAuthenticationLogin =
      '/biometric-authentication-login';
  static const String registrationScreen = '/registration-screen';
  static const String identityVerificationScreen =
      '/identity-verification-screen';
  static const String homeDashboard = '/home-dashboard';
  static const String cardsManagementScreen = '/cards-management-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    biometricAuthenticationSetup: (context) =>
        const BiometricAuthenticationSetup(),
    biometricAuthenticationLogin: (context) =>
        const BiometricAuthenticationLogin(),
    registrationScreen: (context) => const RegistrationScreen(),
    identityVerificationScreen: (context) => const IdentityVerificationScreen(),
    homeDashboard: (context) => const HomeDashboard(),
    cardsManagementScreen: (context) => const CardsManagementScreen(),
    // TODO: Add your other routes here
  };
}
