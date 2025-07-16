import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DashboardTabsWidget extends StatelessWidget {
  final TabController tabController;
  final int currentIndex;

  const DashboardTabsWidget({
    Key? key,
    required this.tabController,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: AppTheme.accentGold,
          borderRadius: BorderRadius.circular(3.w),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text('Accounts'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text('Cards'),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text('Linked Accounts'),
            ),
          ),
        ],
      ),
    );
  }
}
