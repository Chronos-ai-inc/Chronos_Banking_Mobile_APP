import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';

class CardBenefitsWidget extends StatelessWidget {
  final String category;
  final String selectedPlan;

  const CardBenefitsWidget({
    Key? key,
    required this.category,
    required this.selectedPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final benefits = _getBenefits(category, selectedPlan);
    final pricing = _getPricing(selectedPlan);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedPlan} ${category} Benefits',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Text(
                  pricing,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryDark,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...benefits.map((benefit) => _buildBenefitItem(benefit)),
          SizedBox(height: 2.h),
          _buildDeliveryInfo(category),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16.sp,
            height: 16.sp,
            decoration: BoxDecoration(
              color: AppTheme.accentGold,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: AppTheme.primaryDark,
              size: 12.sp,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              benefit,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(String category) {
    if (category == 'Virtual') return const SizedBox.shrink();

    final deliveryTime =
        category == 'Physical' ? '3-5 business days' : '7-10 business days';

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.local_shipping_outlined,
            color: AppTheme.accentGold,
            size: 16.sp,
          ),
          SizedBox(width: 3.w),
          Text(
            'Estimated delivery: ${deliveryTime}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getBenefits(String category, String plan) {
    switch (category) {
      case 'Virtual':
        return _getVirtualBenefits(plan);
      case 'Physical':
        return _getPhysicalBenefits(plan);
      case 'Crypto':
        return _getCryptoBenefits(plan);
      case 'TickPay':
        return _getTickPayBenefits(plan);
      default:
        return [];
    }
  }

  List<String> _getVirtualBenefits(String plan) {
    final baseBenefits = [
      'Instant card creation',
      'Online shopping worldwide',
      'Secure contactless payments',
    ];

    if (plan == 'Plus') {
      baseBenefits.addAll([
        '1.5% cashback on all purchases',
        'Priority customer support',
      ]);
    } else if (plan == 'Metal') {
      baseBenefits.addAll([
        '2% cashback on all purchases',
        'Concierge service',
        'Travel insurance',
      ]);
    }

    return baseBenefits;
  }

  List<String> _getPhysicalBenefits(String plan) {
    final baseBenefits = [
      'Worldwide acceptance',
      'ATM withdrawals',
      'Contactless payments',
    ];

    if (plan == 'Plus') {
      baseBenefits.addAll([
        '1% cashback on purchases',
        'Free international transfers',
      ]);
    } else if (plan == 'Metal') {
      baseBenefits.addAll([
        '1.5% cashback on purchases',
        'Airport lounge access',
        'Travel insurance',
      ]);
    }

    return baseBenefits;
  }

  List<String> _getCryptoBenefits(String plan) {
    final baseBenefits = [
      'Crypto rewards on purchases',
      'DeFi protocol integration',
      'Staking rewards',
    ];

    if (plan == 'Plus') {
      baseBenefits.addAll([
        '2% crypto cashback',
        'Advanced trading tools',
      ]);
    } else if (plan == 'Metal') {
      baseBenefits.addAll([
        '3% crypto cashback',
        'Priority crypto support',
        'Exclusive NFT drops',
      ]);
    }

    return baseBenefits;
  }

  List<String> _getTickPayBenefits(String plan) {
    final baseBenefits = [
      'Buy now, pay later',
      '0% interest on 3 months',
      'Flexible payment options',
    ];

    if (plan == 'Plus') {
      baseBenefits.addAll([
        'Extended payment terms',
        'Higher spending limits',
      ]);
    } else if (plan == 'Metal') {
      baseBenefits.addAll([
        'Premium payment plans',
        'Exclusive merchant offers',
        'Priority approval',
      ]);
    }

    return baseBenefits;
  }

  String _getPricing(String plan) {
    switch (plan) {
      case 'Standard':
        return 'Free';
      case 'Plus':
        return '£5/month';
      case 'Metal':
        return '£15/month';
      default:
        return 'Free';
    }
  }
}
