import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/balance_display_widget.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/dashboard_tabs_widget.dart';
import './widgets/dashboard_top_bar_widget.dart';
import './widgets/transaction_summary_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            DashboardTopBarWidget(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Tabs
                    DashboardTabsWidget(
                      tabController: _tabController,
                      currentIndex: _currentTabIndex,
                    ),

                    SizedBox(height: 2.h),

                    // Tab Content
                    _buildTabContent(),

                    SizedBox(height: 2.h),

                    // Action Buttons
                    ActionButtonsWidget(),

                    SizedBox(height: 3.h),

                    // Transaction Summary
                    TransactionSummaryWidget(),

                    SizedBox(height: 10.h), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return _buildAccountsTab();
      case 1:
        return _buildCardsTab();
      case 2:
        return _buildLinkedAccountsTab();
      default:
        return _buildAccountsTab();
    }
  }

  Widget _buildAccountsTab() {
    return Column(
      children: [
        // Balance Display
        BalanceDisplayWidget(),

        SizedBox(height: 2.h),

        // Account Status Info
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppTheme.accentGold,
                size: 20.sp,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Your account is fully verified and ready to use',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCardsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.credit_card,
            color: AppTheme.accentGold,
            size: 48.sp,
          ),
          SizedBox(height: 2.h),
          Text(
            'No cards yet',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Order your first Chronos card to start spending',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedAccountsTab() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.link,
            color: AppTheme.accentGold,
            size: 48.sp,
          ),
          SizedBox(height: 2.h),
          Text(
            'No linked accounts',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Connect your bank accounts for easy transfers',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
