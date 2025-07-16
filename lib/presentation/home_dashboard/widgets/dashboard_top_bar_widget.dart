import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DashboardTopBarWidget extends StatelessWidget {
  const DashboardTopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Section
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // Handle profile tap
                },
                child: Container(
                  width: 40.sp,
                  height: 40.sp,
                  decoration: BoxDecoration(
                    color: AppTheme.accentGold.withAlpha(26),
                    borderRadius: BorderRadius.circular(20.sp),
                    border: Border.all(
                      color: AppTheme.accentGold.withAlpha(77),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppTheme.accentGold,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good morning',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'John Doe',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Chronos Logo
          Text(
            'Chronos',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              color: AppTheme.accentGold,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),

          // Notification Bell
          GestureDetector(
            onTap: () {
              // Handle notification tap
            },
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.grey.shade700,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
