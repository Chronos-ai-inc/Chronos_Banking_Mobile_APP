import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OnboardingSlideWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String iconName;

  const OnboardingSlideWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        child: Column(
          children: [
            // Top third - Animated illustration
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.darkTheme.colorScheme.surface,
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomImageWidget(
                            imageUrl: imageUrl,
                            width: 50.w,
                            height: 20.h,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 2.h,
                            right: 4.w,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: AppTheme.accentGold,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: CustomIconWidget(
                                iconName: iconName,
                                color: AppTheme.primaryDark,
                                size: 6.w,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 4.h),

            // Middle section - Feature headline
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    width: 20.w,
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.accentGold,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom third - Descriptive text
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
