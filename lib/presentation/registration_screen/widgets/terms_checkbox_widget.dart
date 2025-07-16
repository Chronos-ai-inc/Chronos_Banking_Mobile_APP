import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final bool isTermsAccepted;
  final bool isPrivacyAccepted;
  final VoidCallback onTermsChanged;
  final VoidCallback onPrivacyChanged;

  const TermsCheckboxWidget({
    super.key,
    required this.isTermsAccepted,
    required this.isPrivacyAccepted,
    required this.onTermsChanged,
    required this.onPrivacyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Terms of Service Checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 6.w,
              height: 6.w,
              child: Checkbox(
                value: isTermsAccepted,
                onChanged: (_) => onTermsChanged(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: GestureDetector(
                onTap: onTermsChanged,
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.darkTheme.textTheme.bodySmall,
                    children: [
                      const TextSpan(text: 'I agree to the '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.accentGold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                          text:
                              ' and acknowledge that I have read and understood the banking terms.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // Privacy Policy Checkbox
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 6.w,
              height: 6.w,
              child: Checkbox(
                value: isPrivacyAccepted,
                onChanged: (_) => onPrivacyChanged(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: GestureDetector(
                onTap: onPrivacyChanged,
                child: RichText(
                  text: TextSpan(
                    style: AppTheme.darkTheme.textTheme.bodySmall,
                    children: [
                      const TextSpan(text: 'I accept the '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.accentGold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                          text:
                              ' and consent to the collection and processing of my personal data for banking services.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
