import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PrivacyInfoWidget extends StatelessWidget {
  const PrivacyInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'info_outline',
                color: AppTheme.accentGold,
                size: 5.w,
              ),
              SizedBox(width: 3.w),
              Text(
                'Privacy Information',
                style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                  color: AppTheme.accentGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildPrivacyPoint(
            'Device-Only Storage',
            'Your biometric data is stored securely on your device and never transmitted to our servers.',
          ),
          SizedBox(height: 1.5.h),
          _buildPrivacyPoint(
            'Hardware Encryption',
            'Biometric templates are encrypted using your device\'s secure hardware enclave.',
          ),
          SizedBox(height: 1.5.h),
          _buildPrivacyPoint(
            'Banking Compliance',
            'Our biometric authentication meets PCI DSS and banking industry security standards.',
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPoint(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1.5.w,
          height: 1.5.w,
          margin: EdgeInsets.only(top: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.accentGold,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w500,
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
      ],
    );
  }
}
