import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';

class CardPreviewWidget extends StatelessWidget {
  final String category;
  final String plan;
  final Color color;
  final bool isSelected;

  const CardPreviewWidget({
    Key? key,
    required this.category,
    required this.plan,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: isSelected ? 20 : 10,
            offset: Offset(0, isSelected ? 10 : 5),
          ),
        ],
      ),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(isSelected ? -0.1 : -0.05)
          ..rotateY(0.05),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color,
                color.withAlpha(204),
              ],
            ),
            borderRadius: BorderRadius.circular(4.w),
            border: Border.all(
              color: color.withAlpha(77),
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              // Card background pattern
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.w),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.white.withAlpha(26),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Card content
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'CHRONOS',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                            letterSpacing: 2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold,
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            plan.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '•••• •••• •••• 1234',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VALID THRU',
                              style: GoogleFonts.inter(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.textSecondary,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              '12/28',
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        _getCategoryIcon(category),
                      ],
                    ),
                  ],
                ),
              ),
              // Shine effect for selected card
              if (isSelected)
                Positioned(
                  top: -50,
                  left: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withAlpha(77),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCategoryIcon(String category) {
    IconData icon;
    switch (category) {
      case 'Virtual':
        icon = Icons.credit_card;
        break;
      case 'Physical':
        icon = Icons.credit_card_outlined;
        break;
      case 'Crypto':
        icon = Icons.currency_bitcoin;
        break;
      case 'TickPay':
        icon = Icons.payment;
        break;
      default:
        icon = Icons.credit_card;
    }

    return Container(
      width: 30.sp,
      height: 30.sp,
      decoration: BoxDecoration(
        color: AppTheme.textPrimary.withAlpha(26),
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Icon(
        icon,
        color: AppTheme.textPrimary,
        size: 16.sp,
      ),
    );
  }
}
