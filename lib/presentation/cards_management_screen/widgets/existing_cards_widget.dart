import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';

class ExistingCardsWidget extends StatelessWidget {
  const ExistingCardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final existingCards = _getExistingCards();

    if (existingCards.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Cards',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          ...existingCards.map((card) => _buildCardItem(card)),
        ],
      ),
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.sp,
                height: 25.sp,
                decoration: BoxDecoration(
                  color: card['color'],
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Center(
                  child: Text(
                    'CHRONOS',
                    style: GoogleFonts.inter(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${card['type']} ${card['plan']}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      '**** **** **** ${card['lastFour']}',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: card['isActive']
                      ? AppTheme.successGreen
                      : AppTheme.warningAmber,
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Text(
                  card['isActive'] ? 'Active' : 'Locked',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              _buildActionButton(
                icon: card['isActive']
                    ? Icons.lock_outline
                    : Icons.lock_open_outlined,
                label: card['isActive'] ? 'Lock' : 'Unlock',
                onPressed: () => _handleLockCard(card['id']),
              ),
              SizedBox(width: 2.w),
              _buildActionButton(
                icon: Icons.pin_outlined,
                label: 'Change PIN',
                onPressed: () => _handleChangePin(card['id']),
              ),
              SizedBox(width: 2.w),
              _buildActionButton(
                icon: Icons.ac_unit_outlined,
                label: 'Freeze',
                onPressed: () => _handleFreezeCard(card['id']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(color: AppTheme.dividerColor),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppTheme.accentGold,
                size: 16.sp,
              ),
              SizedBox(height: 0.5.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getExistingCards() {
    return [
      {
        'id': '1',
        'type': 'Virtual',
        'plan': 'Plus',
        'lastFour': '1234',
        'color': AppTheme.accentGold,
        'isActive': true,
      },
      {
        'id': '2',
        'type': 'Physical',
        'plan': 'Standard',
        'lastFour': '5678',
        'color': AppTheme.surfaceDark,
        'isActive': false,
      },
    ];
  }

  void _handleLockCard(String cardId) {
    // Handle lock/unlock card logic
  }

  void _handleChangePin(String cardId) {
    // Handle change PIN logic
  }

  void _handleFreezeCard(String cardId) {
    // Handle freeze card logic
  }
}
