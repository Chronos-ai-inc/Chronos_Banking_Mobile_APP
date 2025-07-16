import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class BiometricIconWidget extends StatefulWidget {
  final String biometricType;

  const BiometricIconWidget({
    Key? key,
    required this.biometricType,
  }) : super(key: key);

  @override
  State<BiometricIconWidget> createState() => _BiometricIconWidgetState();
}

class _BiometricIconWidgetState extends State<BiometricIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getBiometricIcon() {
    if (kIsWeb) {
      return 'fingerprint';
    }

    if (!kIsWeb && Platform.isIOS) {
      return widget.biometricType == 'face' ? 'face' : 'fingerprint';
    }

    return 'fingerprint';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accentGold.withValues(alpha: 0.2),
            AppTheme.accentGold.withValues(alpha: 0.05),
          ],
          stops: const [0.3, 1.0],
        ),
        border: Border.all(
          color: AppTheme.accentGold.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Center(
                child: CustomIconWidget(
                  iconName: _getBiometricIcon(),
                  color: AppTheme.accentGold,
                  size: 15.w,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
