import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.smart_toy,
                label: 'AI',
                index: 1,
                isTextIcon: true,
              ),
              _buildNavItem(
                icon: Icons.send,
                label: 'Transfer',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.currency_bitcoin,
                label: 'Crypto',
                index: 3,
              ),
              _buildNavItem(
                icon: Icons.apartment,
                label: 'LifeX',
                index: 4,
                isSpecial: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool isTextIcon = false,
    bool isSpecial = false,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? (isSpecial ? AppTheme.accentGold : AppTheme.accentGold)
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isTextIcon && label == 'AI')
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppTheme.accentGold : Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(4.sp),
                ),
                child: Center(
                  child: Text(
                    'AI',
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            else
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
