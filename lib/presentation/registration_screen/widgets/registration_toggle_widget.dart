import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RegistrationToggleWidget extends StatelessWidget {
  final bool isEmailMode;
  final VoidCallback onToggle;

  const RegistrationToggleWidget({
    super.key,
    required this.isEmailMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 7.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: isEmailMode ? null : onToggle,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isEmailMode ? AppTheme.accentGold : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'email',
                      color: isEmailMode
                          ? AppTheme.primaryDark
                          : AppTheme.textSecondary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Email',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: isEmailMode
                            ? AppTheme.primaryDark
                            : AppTheme.textSecondary,
                        fontWeight:
                            isEmailMode ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: !isEmailMode ? null : onToggle,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color:
                      !isEmailMode ? AppTheme.accentGold : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'phone',
                      color: !isEmailMode
                          ? AppTheme.primaryDark
                          : AppTheme.textSecondary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Phone',
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: !isEmailMode
                            ? AppTheme.primaryDark
                            : AppTheme.textSecondary,
                        fontWeight:
                            !isEmailMode ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
