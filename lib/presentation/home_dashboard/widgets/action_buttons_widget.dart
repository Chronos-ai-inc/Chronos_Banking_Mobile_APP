import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ActionButtonsWidget extends StatelessWidget {
  const ActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.add,
            label: 'Add Money',
            onTap: () {
              // Handle add money
            },
          ),
          _buildActionButton(
            icon: Icons.currency_pound,
            label: 'TickPay',
            onTap: () {
              // Handle TickPay
            },
            isSpecial: true,
          ),
          _buildActionButton(
            icon: Icons.swap_horiz,
            label: 'Exchange',
            onTap: () {
              // Handle exchange
            },
          ),
          _buildActionButton(
            icon: Icons.more_horiz,
            label: 'More',
            onTap: () {
              // Handle more options
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isSpecial = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 18.w,
        child: Column(
          children: [
            Container(
              width: 56.sp,
              height: 56.sp,
              decoration: BoxDecoration(
                color: isSpecial ? AppTheme.accentGold : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(4.w),
                border: Border.all(
                  color: isSpecial ? AppTheme.accentGold : Colors.grey.shade200,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSpecial
                        ? AppTheme.accentGold.withAlpha(51)
                        : Colors.grey.shade200,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: isSpecial ? Colors.white : Colors.grey.shade700,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.sp,
                color: isSpecial ? AppTheme.accentGold : Colors.grey.shade700,
                fontWeight: isSpecial ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
