import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TransactionSummaryWidget extends StatelessWidget {
  const TransactionSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle see all
                },
                child: Text(
                  'See all',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: AppTheme.accentGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Transaction Items
          _buildTransactionItem(
            icon: Icons.credit_card,
            title: 'Card delivery pending',
            subtitle: 'Your Chronos card is being prepared',
            time: '2 hours ago',
            color: AppTheme.accentGold,
          ),

          SizedBox(height: 2.h),

          _buildTransactionItem(
            icon: Icons.check_circle,
            title: 'Account verified',
            subtitle: 'Your identity verification is complete',
            time: '1 day ago',
            color: Colors.green,
          ),

          SizedBox(height: 2.h),

          _buildTransactionItem(
            icon: Icons.account_balance_wallet,
            title: 'Account opened',
            subtitle: 'Welcome to Chronos Banking',
            time: '2 days ago',
            color: Colors.blue,
          ),

          SizedBox(height: 3.h),

          // Customization Options
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(3.w),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tune,
                  color: AppTheme.accentGold,
                  size: 20.sp,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Customize your home screen',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Personalize your dashboard layout',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: color.withAlpha(26),
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
