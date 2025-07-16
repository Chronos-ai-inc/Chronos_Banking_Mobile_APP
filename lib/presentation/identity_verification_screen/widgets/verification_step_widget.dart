import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VerificationStepWidget extends StatelessWidget {
  final String title;
  final String description;
  final String iconName;
  final bool isCompleted;
  final bool isActive;
  final VoidCallback? onTap;

  const VerificationStepWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.iconName,
    this.isCompleted = false,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.accentGold.withValues(alpha: 0.1)
              : AppTheme.darkTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? AppTheme.accentGold
                : isCompleted
                    ? AppTheme.successGreen
                    : AppTheme.dividerColor,
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive ? AppTheme.floatingShadow : AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppTheme.successGreen
                    : isActive
                        ? AppTheme.accentGold
                        : AppTheme.secondaryDark,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? AppTheme.successGreen
                      : isActive
                          ? AppTheme.accentGold
                          : AppTheme.dividerColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: isCompleted
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.textPrimary,
                        size: 20,
                      )
                    : CustomIconWidget(
                        iconName: iconName,
                        color: isActive
                            ? AppTheme.primaryDark
                            : AppTheme.textSecondary,
                        size: 20,
                      ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                      color: isActive
                          ? AppTheme.accentGold
                          : isCompleted
                              ? AppTheme.successGreen
                              : AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    description,
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              CustomIconWidget(
                iconName: 'arrow_forward_ios',
                color: AppTheme.accentGold,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
