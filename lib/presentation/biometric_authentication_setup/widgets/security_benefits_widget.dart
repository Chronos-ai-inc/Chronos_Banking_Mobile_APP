import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SecurityBenefitsWidget extends StatelessWidget {
  const SecurityBenefitsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> benefits = [
      {
        'icon': 'security',
        'title': 'Bank-Grade Security',
        'description':
            'Your biometric data is encrypted and stored securely on your device only',
      },
      {
        'icon': 'speed',
        'title': 'Lightning Fast Access',
        'description':
            'Access your account in under 2 seconds with just a touch or glance',
      },
      {
        'icon': 'shield',
        'title': 'Enhanced Protection',
        'description':
            'Biometric authentication is more secure than traditional passwords',
      },
    ];

    return Column(
      children: [
        Text(
          'Why Enable Biometric Login?',
          style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 3.h),
        ...benefits.map((benefit) => _buildBenefitItem(benefit)).toList(),
      ],
    );
  }

  Widget _buildBenefitItem(Map<String, dynamic> benefit) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: AppTheme.accentGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: benefit['icon'] as String,
                color: AppTheme.accentGold,
                size: 6.w,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  benefit['title'] as String,
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  benefit['description'] as String,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
