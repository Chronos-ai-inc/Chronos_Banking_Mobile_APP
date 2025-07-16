import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NavigationButtonsWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const NavigationButtonsWidget({
    Key? key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPage == totalPages - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button (hidden on last page)
          isLastPage
              ? SizedBox(width: 20.w)
              : TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                  ),
                  child: Text(
                    'Skip',
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

          // Next/Get Started button
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGold,
              foregroundColor: AppTheme.primaryDark,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isLastPage ? 'Get Started' : 'Next',
                  style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!isLastPage) ...[
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    color: AppTheme.primaryDark,
                    size: 4.w,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
