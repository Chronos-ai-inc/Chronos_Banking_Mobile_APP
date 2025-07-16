import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AuthenticationStatusWidget extends StatefulWidget {
  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String message;

  const AuthenticationStatusWidget({
    Key? key,
    this.isLoading = false,
    this.isSuccess = false,
    this.isError = false,
    required this.message,
  }) : super(key: key);

  @override
  State<AuthenticationStatusWidget> createState() =>
      _AuthenticationStatusWidgetState();
}

class _AuthenticationStatusWidgetState extends State<AuthenticationStatusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimation();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  void didUpdateWidget(AuthenticationStatusWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message != widget.message) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor() {
    if (widget.isSuccess) {
      return AppTheme.successGreen;
    } else if (widget.isError) {
      return AppTheme.errorRed;
    } else {
      return AppTheme.accentGold;
    }
  }

  IconData _getStatusIcon() {
    if (widget.isSuccess) {
      return Icons.check_circle;
    } else if (widget.isError) {
      return Icons.error;
    } else if (widget.isLoading) {
      return Icons.fingerprint;
    } else {
      return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Container(
              width: 80.w,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: _getStatusColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getStatusColor().withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Status Icon
                  widget.isLoading
                      ? SizedBox(
                          width: 6.w,
                          height: 6.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getStatusColor(),
                            ),
                          ),
                        )
                      : CustomIconWidget(
                          iconName: _getStatusIcon().codePoint.toString(),
                          size: 6.w,
                          color: _getStatusColor(),
                        ),

                  SizedBox(width: 3.w),

                  // Status Message
                  Expanded(
                    child: Text(
                      widget.message,
                      style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
