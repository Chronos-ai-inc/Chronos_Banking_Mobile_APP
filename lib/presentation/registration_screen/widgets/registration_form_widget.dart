import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RegistrationFormWidget extends StatefulWidget {
  final bool isEmailMode;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? selectedCountryCode;
  final Function(String) onCountryCodeChanged;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final String? confirmPasswordError;

  const RegistrationFormWidget({
    super.key,
    required this.isEmailMode,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedCountryCode,
    required this.onCountryCodeChanged,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    this.emailError,
    this.phoneError,
    this.passwordError,
    this.confirmPasswordError,
  });

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final List<Map<String, String>> _countryCodes = [
    {"code": "+1", "country": "US"},
    {"code": "+44", "country": "UK"},
    {"code": "+91", "country": "IN"},
    {"code": "+86", "country": "CN"},
    {"code": "+81", "country": "JP"},
    {"code": "+49", "country": "DE"},
    {"code": "+33", "country": "FR"},
    {"code": "+39", "country": "IT"},
    {"code": "+34", "country": "ES"},
    {"code": "+7", "country": "RU"},
  ];

  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '';
    if (password.length < 6) return 'Weak';
    if (password.length < 8) return 'Fair';
    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return 'Strong';
    }
    return 'Good';
  }

  Color _getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'Weak':
        return AppTheme.errorRed;
      case 'Fair':
        return AppTheme.warningAmber;
      case 'Good':
        return AppTheme.accentGold;
      case 'Strong':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email/Phone Input
        if (widget.isEmailMode) ...[
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTheme.darkTheme.textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'email',
                  color: AppTheme.textSecondary,
                  size: 5.w,
                ),
              ),
              errorText: widget.emailError,
            ),
          ),
        ] else ...[
          Row(
            children: [
              // Country Code Picker
              Container(
                width: 25.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.dividerColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: widget.selectedCountryCode,
                    isExpanded: true,
                    dropdownColor: AppTheme.surfaceDark,
                    style: AppTheme.darkTheme.textTheme.bodyLarge,
                    icon: CustomIconWidget(
                      iconName: 'keyboard_arrow_down',
                      color: AppTheme.textSecondary,
                      size: 5.w,
                    ),
                    items: _countryCodes.map((country) {
                      return DropdownMenuItem<String>(
                        value: country['code'],
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            '${country['country']} ${country['code']}',
                            style: AppTheme.darkTheme.textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        widget.onCountryCodeChanged(value);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              // Phone Number Input
              Expanded(
                child: TextFormField(
                  controller: widget.phoneController,
                  keyboardType: TextInputType.phone,
                  style: AppTheme.darkTheme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter phone number',
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'phone',
                        color: AppTheme.textSecondary,
                        size: 5.w,
                      ),
                    ),
                    errorText: widget.phoneError,
                  ),
                ),
              ),
            ],
          ),
        ],

        SizedBox(height: 3.h),

        // Password Input
        TextFormField(
          controller: widget.passwordController,
          obscureText: !widget.isPasswordVisible,
          style: AppTheme.darkTheme.textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Create a strong password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: widget.onTogglePasswordVisibility,
              icon: CustomIconWidget(
                iconName:
                    widget.isPasswordVisible ? 'visibility_off' : 'visibility',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
            errorText: widget.passwordError,
          ),
        ),

        // Password Strength Indicator
        if (widget.passwordController.text.isNotEmpty) ...[
          SizedBox(height: 1.h),
          Row(
            children: [
              Text(
                'Password Strength: ',
                style: AppTheme.darkTheme.textTheme.bodySmall,
              ),
              Text(
                _getPasswordStrength(widget.passwordController.text),
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: _getPasswordStrengthColor(
                      _getPasswordStrength(widget.passwordController.text)),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],

        SizedBox(height: 3.h),

        // Confirm Password Input
        TextFormField(
          controller: widget.confirmPasswordController,
          obscureText: !widget.isConfirmPasswordVisible,
          style: AppTheme.darkTheme.textTheme.bodyLarge,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: widget.onToggleConfirmPasswordVisibility,
              icon: CustomIconWidget(
                iconName: widget.isConfirmPasswordVisible
                    ? 'visibility_off'
                    : 'visibility',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
            errorText: widget.confirmPasswordError,
          ),
        ),

        // Password Match Indicator
        if (widget.confirmPasswordController.text.isNotEmpty) ...[
          SizedBox(height: 1.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: widget.passwordController.text ==
                        widget.confirmPasswordController.text
                    ? 'check_circle'
                    : 'cancel',
                color: widget.passwordController.text ==
                        widget.confirmPasswordController.text
                    ? AppTheme.successGreen
                    : AppTheme.errorRed,
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                widget.passwordController.text ==
                        widget.confirmPasswordController.text
                    ? 'Passwords match'
                    : 'Passwords do not match',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: widget.passwordController.text ==
                          widget.confirmPasswordController.text
                      ? AppTheme.successGreen
                      : AppTheme.errorRed,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
