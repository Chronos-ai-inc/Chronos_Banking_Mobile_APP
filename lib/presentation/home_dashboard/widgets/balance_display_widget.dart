import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BalanceDisplayWidget extends StatelessWidget {
  const BalanceDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              // Currency Flag
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Center(
                  child: Text(
                    '🇬🇧',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '£0.00',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      'British Pound',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Balance visibility toggle
              GestureDetector(
                onTap: () {
                  // Handle balance visibility toggle
                },
                child: Container(
                  width: 32.sp,
                  height: 32.sp,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16.sp),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Icon(
                    Icons.visibility_outlined,
                    color: Colors.grey.shade600,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
