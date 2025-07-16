import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class AppleGooglePayWidget extends StatelessWidget {
  const AppleGooglePayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Digital Wallet',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Add your cards to digital wallets for secure payments',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              if (_shouldShowApplePay())
                Expanded(
                  child: _buildPayButton(
                    label: 'Add to Apple Pay',
                    icon: Icons.apple,
                    onPressed: _handleApplePaySetup,
                  ),
                ),
              if (_shouldShowApplePay() && _shouldShowGooglePay())
                SizedBox(width: 2.w),
              if (_shouldShowGooglePay())
                Expanded(
                  child: _buildPayButton(
                    label: 'Add to Google Pay',
                    icon: Icons.payment,
                    onPressed: _handleGooglePaySetup,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.primaryDark,
          borderRadius: BorderRadius.circular(2.w),
          border: Border.all(color: AppTheme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppTheme.accentGold,
              size: 16.sp,
            ),
            SizedBox(width: 2.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowApplePay() {
    if (kIsWeb) return false;
    return Platform.isIOS;
  }

  bool _shouldShowGooglePay() {
    if (kIsWeb) return true;
    return Platform.isAndroid;
  }

  void _handleApplePaySetup() {
    // Handle Apple Pay setup
  }

  void _handleGooglePaySetup() {
    // Handle Google Pay setup
  }
}
