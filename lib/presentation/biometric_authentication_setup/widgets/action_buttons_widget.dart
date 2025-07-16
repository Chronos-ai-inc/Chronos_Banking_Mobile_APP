import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onEnableBiometric;
  final VoidCallback onSetupLater;
  final bool isLoading;

  const ActionButtonsWidget({
    Key? key,
    required this.onEnableBiometric,
    required this.onSetupLater,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 7.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : onEnableBiometric,
            style: AppTheme.darkTheme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppTheme.accentGold.withValues(alpha: 0.5);
                }
                return AppTheme.accentGold;
              }),
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5.w,
                        height: 5.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryDark,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Setting up...',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'fingerprint',
                        color: AppTheme.primaryDark,
                        size: 5.w,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Enable Biometric Login',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          height: 7.h,
          child: OutlinedButton(
            onPressed: isLoading ? null : onSetupLater,
            style: AppTheme.darkTheme.outlinedButtonTheme.style?.copyWith(
              side: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(
                    color: AppTheme.accentGold.withValues(alpha: 0.3),
                    width: 1,
                  );
                }
                return const BorderSide(
                  color: AppTheme.accentGold,
                  width: 1,
                );
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return AppTheme.accentGold.withValues(alpha: 0.5);
                }
                return AppTheme.accentGold;
              }),
            ),
            child: Text(
              'Set Up Later',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: isLoading
                    ? AppTheme.accentGold.withValues(alpha: 0.5)
                    : AppTheme.accentGold,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
