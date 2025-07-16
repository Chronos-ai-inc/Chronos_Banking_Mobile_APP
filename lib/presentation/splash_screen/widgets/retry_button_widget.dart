import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RetryButtonWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final bool isVisible;

  const RetryButtonWidget({
    Key? key,
    required this.onRetry,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, isVisible ? 0 : 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'wifi_off',
              color: AppTheme.textSecondary,
              size: 8.w,
            ),
            SizedBox(height: 2.h),
            Text(
              'Connection timeout',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentGold,
                foregroundColor: AppTheme.primaryDark,
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 1.5.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 2.0,
              ),
              child: Text(
                'Retry',
                style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
