import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TrustSignalsWidget extends StatelessWidget {
  const TrustSignalsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> trustSignals = [
      {
        'icon': 'verified_user',
        'label': 'FDIC Insured',
      },
      {
        'icon': 'lock',
        'label': '256-bit SSL',
      },
      {
        'icon': 'gavel',
        'label': 'SOC 2 Compliant',
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.dividerColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Your Security is Our Priority',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                trustSignals.map((signal) => _buildTrustBadge(signal)).toList(),
          ),
          SizedBox(height: 2.h),
          Text(
            'Biometric data never leaves your device and is encrypted using hardware-level security.',
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(Map<String, dynamic> signal) {
    return Column(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: AppTheme.successGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: signal['icon'] as String,
              color: AppTheme.successGreen,
              size: 5.w,
            ),
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          signal['label'] as String,
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 10.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
