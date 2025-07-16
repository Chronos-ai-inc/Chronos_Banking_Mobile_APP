import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const ProgressIndicatorWidget({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Identity Verification',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Step $currentStep of $totalSteps',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildProgressBar(),
          SizedBox(height: 1.h),
          Text(
            stepTitles[currentStep - 1],
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.accentGold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep - 1;
        final isCurrent = index == currentStep - 1;
        final isUpcoming = index > currentStep - 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent
                        ? AppTheme.accentGold
                        : AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (index < totalSteps - 1) SizedBox(width: 1.w),
            ],
          ),
        );
      }),
    );
  }
}
