import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  final bool isVisible;

  const LoadingIndicatorWidget({
    Key? key,
    required this.isVisible,
  }) : super(key: key);

  @override
  State<LoadingIndicatorWidget> createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.isVisible) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      widget.isVisible
          ? _animationController.forward()
          : _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 6.w,
                height: 6.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.accentGold,
                  ),
                  backgroundColor: AppTheme.accentGold.withValues(alpha: 0.2),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Initializing secure banking...',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 11.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
