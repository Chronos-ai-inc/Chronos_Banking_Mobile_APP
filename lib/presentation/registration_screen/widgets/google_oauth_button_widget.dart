import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GoogleOAuthButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleOAuthButtonWidget({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppTheme.surfaceDark,
          side: BorderSide(color: AppTheme.dividerColor, width: 1),
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
                      AlwaysStoppedAnimation<Color>(AppTheme.accentGold),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageWidget(
                    imageUrl:
                        'https://developers.google.com/identity/images/g-logo.png',
                    width: 6.w,
                    height: 6.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Continue with Google',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
