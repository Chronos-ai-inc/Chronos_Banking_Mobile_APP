import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/create_account_button_widget.dart';
import './widgets/google_oauth_button_widget.dart';
import './widgets/registration_form_widget.dart';
import './widgets/registration_toggle_widget.dart';
import './widgets/terms_checkbox_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  // State variables
  bool _isEmailMode = true;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isTermsAccepted = false;
  bool _isPrivacyAccepted = false;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  String _selectedCountryCode = '+1';

  // Error messages
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Mock user data for demonstration
  final List<Map<String, dynamic>> _existingUsers = [
    {
      "email": "john.doe@example.com",
      "phone": "+1234567890",
      "password": "Password123!",
      "name": "John Doe",
      "registrationDate": "2025-01-15",
    },
    {
      "email": "jane.smith@chronos.com",
      "phone": "+1987654321",
      "password": "SecurePass456!",
      "name": "Jane Smith",
      "registrationDate": "2025-01-14",
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupTextControllerListeners();
    _setupFocusNodeListeners();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _scrollController.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _setupTextControllerListeners() {
    _emailController.addListener(() {
      if (_emailError != null) {
        setState(() => _emailError = null);
      }
    });

    _phoneController.addListener(() {
      if (_phoneError != null) {
        setState(() => _phoneError = null);
      }
    });

    _passwordController.addListener(() {
      if (_passwordError != null) {
        setState(() => _passwordError = null);
      }
      if (_confirmPasswordController.text.isNotEmpty) {
        setState(() {});
      }
    });

    _confirmPasswordController.addListener(() {
      if (_confirmPasswordError != null) {
        setState(() => _confirmPasswordError = null);
      }
      setState(() {});
    });
  }

  void _setupFocusNodeListeners() {
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        _scrollToField();
      }
    });

    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus) {
        _scrollToField();
      }
    });

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _scrollToField();
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (_confirmPasswordFocusNode.hasFocus) {
        _scrollToField();
      }
    });
  }

  void _scrollToField() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  bool _validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\d{10,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[^\d]'), ''));
  }

  bool _validatePassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'));
  }

  bool _isFormValid() {
    if (_isEmailMode) {
      return _emailController.text.isNotEmpty &&
          _validateEmail(_emailController.text) &&
          _passwordController.text.isNotEmpty &&
          _validatePassword(_passwordController.text) &&
          _confirmPasswordController.text == _passwordController.text &&
          _isTermsAccepted &&
          _isPrivacyAccepted;
    } else {
      return _phoneController.text.isNotEmpty &&
          _validatePhone(_phoneController.text) &&
          _passwordController.text.isNotEmpty &&
          _validatePassword(_passwordController.text) &&
          _confirmPasswordController.text == _passwordController.text &&
          _isTermsAccepted &&
          _isPrivacyAccepted;
    }
  }

  bool _checkUserExists() {
    if (_isEmailMode) {
      return (_existingUsers as List).any((user) =>
          (user as Map<String, dynamic>)["email"] == _emailController.text);
    } else {
      final fullPhone = _selectedCountryCode + _phoneController.text;
      return (_existingUsers as List)
          .any((user) => (user as Map<String, dynamic>)["phone"] == fullPhone);
    }
  }

  void _handleRegistration() async {
    if (!_isFormValid()) return;

    setState(() => _isLoading = true);

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    // Validate inputs
    bool hasErrors = false;

    if (_isEmailMode) {
      if (!_validateEmail(_emailController.text)) {
        setState(() => _emailError = 'Please enter a valid email address');
        hasErrors = true;
      } else if (_checkUserExists()) {
        setState(
            () => _emailError = 'An account with this email already exists');
        hasErrors = true;
      }
    } else {
      if (!_validatePhone(_phoneController.text)) {
        setState(() => _phoneError = 'Please enter a valid phone number');
        hasErrors = true;
      } else if (_checkUserExists()) {
        setState(() =>
            _phoneError = 'An account with this phone number already exists');
        hasErrors = true;
      }
    }

    if (!_validatePassword(_passwordController.text)) {
      setState(() => _passwordError =
          'Password must be at least 8 characters with uppercase, lowercase, and number');
      hasErrors = true;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _confirmPasswordError = 'Passwords do not match');
      hasErrors = true;
    }

    if (hasErrors) {
      setState(() => _isLoading = false);
      return;
    }

    // Simulate registration process
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    // Trigger haptic feedback
    HapticFeedback.lightImpact();

    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created successfully! Please verify your identity.',
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          backgroundColor: AppTheme.successGreen,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      // Navigate to identity verification
      Navigator.pushNamed(context, '/identity-verification-screen');
    }
  }

  void _handleGoogleSignUp() async {
    setState(() => _isGoogleLoading = true);

    // Simulate Google OAuth process
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isGoogleLoading = false);

    // Trigger haptic feedback
    HapticFeedback.lightImpact();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Google sign-up successful! Please complete identity verification.',
            style: AppTheme.darkTheme.textTheme.bodyMedium,
          ),
          backgroundColor: AppTheme.successGreen,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

      // Navigate to identity verification
      Navigator.pushNamed(context, '/identity-verification-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // Header with back button and logo
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: AppTheme.textPrimary,
                        size: 6.w,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: AppTheme.accentGold,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: Center(
                                child: Text(
                                  'C',
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.primaryDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              'Chronos',
                              style: AppTheme.darkTheme.textTheme.titleLarge
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w), // Balance the back button
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),

                      // Title and subtitle
                      Text(
                        'Create Account',
                        style: AppTheme.darkTheme.textTheme.headlineMedium
                            ?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Join Chronos Banking for secure, AI-powered financial services with biometric authentication.',
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      // Registration mode toggle
                      RegistrationToggleWidget(
                        isEmailMode: _isEmailMode,
                        onToggle: () {
                          setState(() {
                            _isEmailMode = !_isEmailMode;
                            _emailError = null;
                            _phoneError = null;
                          });
                        },
                      ),

                      SizedBox(height: 3.h),

                      // Registration form
                      RegistrationFormWidget(
                        isEmailMode: _isEmailMode,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        selectedCountryCode: _selectedCountryCode,
                        onCountryCodeChanged: (code) {
                          setState(() => _selectedCountryCode = code);
                        },
                        onTogglePasswordVisibility: () {
                          setState(
                              () => _isPasswordVisible = !_isPasswordVisible);
                        },
                        onToggleConfirmPasswordVisibility: () {
                          setState(() => _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible);
                        },
                        isPasswordVisible: _isPasswordVisible,
                        isConfirmPasswordVisible: _isConfirmPasswordVisible,
                        emailError: _emailError,
                        phoneError: _phoneError,
                        passwordError: _passwordError,
                        confirmPasswordError: _confirmPasswordError,
                      ),

                      SizedBox(height: 4.h),

                      // Terms and privacy checkboxes
                      TermsCheckboxWidget(
                        isTermsAccepted: _isTermsAccepted,
                        isPrivacyAccepted: _isPrivacyAccepted,
                        onTermsChanged: () {
                          setState(() => _isTermsAccepted = !_isTermsAccepted);
                        },
                        onPrivacyChanged: () {
                          setState(
                              () => _isPrivacyAccepted = !_isPrivacyAccepted);
                        },
                      ),

                      SizedBox(height: 4.h),

                      // Create account button
                      CreateAccountButtonWidget(
                        onPressed: _handleRegistration,
                        isEnabled: _isFormValid(),
                        isLoading: _isLoading,
                      ),

                      SizedBox(height: 3.h),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppTheme.dividerColor,
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              'Or sign up with',
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppTheme.dividerColor,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Google OAuth button
                      GoogleOAuthButtonWidget(
                        onPressed: _handleGoogleSignUp,
                        isLoading: _isGoogleLoading,
                      ),

                      SizedBox(height: 4.h),

                      // Sign in link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/biometric-authentication-login');
                          },
                          child: RichText(
                            text: TextSpan(
                              style: AppTheme.darkTheme.textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style:
                                      TextStyle(color: AppTheme.textSecondary),
                                ),
                                TextSpan(
                                  text: 'Sign In',
                                  style: TextStyle(
                                    color: AppTheme.accentGold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 2.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
