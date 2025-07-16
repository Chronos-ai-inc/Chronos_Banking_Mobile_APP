import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';

class CardCategoryTabsWidget extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;

  const CardCategoryTabsWidget({
    Key? key,
    required this.tabController,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: TabBar(
        controller: tabController,
        tabs: categories.map((category) {
          return Tab(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Text(
                category,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
        indicator: BoxDecoration(
          color: AppTheme.accentGold,
          borderRadius: BorderRadius.circular(2.w),
        ),
        labelColor: AppTheme.primaryDark,
        unselectedLabelColor: AppTheme.textSecondary,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(0.5.w),
      ),
    );
  }
}
