import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../theme/app_theme.dart';
import './widgets/apple_google_pay_widget.dart';
import './widgets/card_benefits_widget.dart';
import './widgets/card_carousel_widget.dart';
import './widgets/card_category_tabs_widget.dart';
import './widgets/existing_cards_widget.dart';

class CardsManagementScreen extends StatefulWidget {
  const CardsManagementScreen({Key? key}) : super(key: key);

  @override
  State<CardsManagementScreen> createState() => _CardsManagementScreenState();
}

class _CardsManagementScreenState extends State<CardsManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedColorIndex = 0;
  String _selectedPlan = 'Standard';

  final List<String> _cardCategories = [
    'Virtual',
    'Physical',
    'Crypto',
    'TickPay'
  ];

  final List<String> _cardPlans = ['Standard', 'Plus', 'Metal'];

  final List<Color> _cardColors = [
    const Color(0xFF9e814e), // Gold
    const Color(0xFF000000), // Black
    const Color(0xFF2d2d2d), // Dark Gray
    const Color(0xFF4caf50), // Green
    const Color(0xFF2196f3), // Blue
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _cardCategories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _refreshCards,
        color: AppTheme.accentGold,
        backgroundColor: AppTheme.surfaceDark,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  CardCategoryTabsWidget(
                    tabController: _tabController,
                    categories: _cardCategories,
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    height: 70.h,
                    child: TabBarView(
                      controller: _tabController,
                      children: _cardCategories.map((category) {
                        return _buildCardCategoryView(category);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  AppleGooglePayWidget(),
                  SizedBox(height: 3.h),
                  ExistingCardsWidget(),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.primaryDark,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            'My Cards',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: AppTheme.surfaceDark,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: AppTheme.textPrimary,
                size: 20.sp,
              ),
              onPressed: () {
                // Handle notifications
              },
            ),
          ),
          SizedBox(width: 3.w),
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: AppTheme.accentGold,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Center(
              child: Text(
                'J',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardCategoryView(String category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          CardCarouselWidget(
            category: category,
            plans: _cardPlans,
            colors: _cardColors,
            selectedColorIndex: _selectedColorIndex,
            selectedPlan: _selectedPlan,
            onColorChanged: (index) {
              setState(() {
                _selectedColorIndex = index;
              });
            },
            onPlanChanged: (plan) {
              setState(() {
                _selectedPlan = plan;
              });
            },
          ),
          SizedBox(height: 3.h),
          CardBenefitsWidget(
            category: category,
            selectedPlan: _selectedPlan,
          ),
          SizedBox(height: 3.h),
          _buildOrderButton(category),
        ],
      ),
    );
  }

  Widget _buildOrderButton(String category) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: ElevatedButton(
        onPressed: () {
          _handleOrderCard(category);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentGold,
          foregroundColor: AppTheme.primaryDark,
          padding: EdgeInsets.symmetric(vertical: 4.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.w),
          ),
          elevation: 2,
        ),
        child: Text(
          'Order ${category} Card',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _refreshCards() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Refresh card data
    });
  }

  void _handleOrderCard(String category) {
    // Handle card ordering logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text(
          'Order ${category} Card',
          style: GoogleFonts.inter(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Would you like to order a ${_selectedPlan} ${category} card?',
          style: GoogleFonts.inter(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Process order
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentGold,
              foregroundColor: AppTheme.primaryDark,
            ),
            child: Text(
              'Order',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
