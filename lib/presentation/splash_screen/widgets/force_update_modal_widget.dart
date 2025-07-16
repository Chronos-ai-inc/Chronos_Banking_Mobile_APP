import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ForceUpdateModalWidget extends StatelessWidget {
  final VoidCallback onUpdate;

  const ForceUpdateModalWidget({
    Key? key,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppTheme.primaryDark.withValues(alpha: 0.9),
      child: Center(
        child: Container(
          width: 80.w,
          constraints: BoxConstraints(maxWidth: 400),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: AppTheme.floatingShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: CustomIconWidget(
                  iconName: 'system_update',
                  color: AppTheme.accentGold,
                  size: 8.w,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Update Required',
                style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'A new version of Chronos Banking is available. Please update to continue using the app securely.',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 12.sp,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentGold,
                    foregroundColor: AppTheme.primaryDark,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 2.0,
                  ),
                  child: Text(
                    'Update Now',
                    style: AppTheme.darkTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.primaryDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
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
