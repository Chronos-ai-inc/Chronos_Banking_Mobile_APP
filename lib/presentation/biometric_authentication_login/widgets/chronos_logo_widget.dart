import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ChronosLogoWidget extends StatefulWidget {
  const ChronosLogoWidget({Key? key}) : super(key: key);

  @override
  State<ChronosLogoWidget> createState() => _ChronosLogoWidgetState();
}

class _ChronosLogoWidgetState extends State<ChronosLogoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
    ));
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 60.w,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Icon
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.accentGold,
                          AppTheme.accentGold.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentGold.withValues(alpha: 0.4),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: 'access_time',
                        size: 10.w,
                        color: AppTheme.primaryDark,
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Logo Text
                  Text(
                    'CHRONOS',
                    style:
                        AppTheme.darkTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.accentGold,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.0,
                    ),
                  ),

                  SizedBox(height: 0.5.h),

                  // Subtitle
                  Text(
                    'BANKING',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
