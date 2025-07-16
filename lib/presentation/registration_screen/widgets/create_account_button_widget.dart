import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;

  const CreateAccountButtonWidget({
    super.key,
    required this.onPressed,
    required this.isEnabled,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(
        onPressed: isEnabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled ? AppTheme.accentGold : AppTheme.dividerColor,
          foregroundColor:
              isEnabled ? AppTheme.primaryDark : AppTheme.textSecondary,
          elevation: isEnabled ? 2 : 0,
          shadowColor: AppTheme.shadowDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 5.w,
                height: 5.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.primaryDark),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'person_add',
                    color: isEnabled
                        ? AppTheme.primaryDark
                        : AppTheme.textSecondary,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Create Account',
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? AppTheme.primaryDark
                          : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
