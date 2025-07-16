import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserAvatarWidget extends StatelessWidget {
  final String userName;
  final String? avatarUrl;

  const UserAvatarWidget({
    Key? key,
    required this.userName,
    this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // User Avatar
          Container(
            width: 25.w,
            height: 25.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.accentGold,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.accentGold.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: avatarUrl != null
                  ? CustomImageWidget(
                      imageUrl: avatarUrl!,
                      width: 25.w,
                      height: 25.w,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppTheme.accentGold.withValues(alpha: 0.2),
                      child: Center(
                        child: Text(
                          _getInitials(userName),
                          style: AppTheme.darkTheme.textTheme.headlineMedium
                              ?.copyWith(
                            color: AppTheme.accentGold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          SizedBox(height: 2.h),

          // Welcome Text
          Text(
            'Welcome back,',
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),

          SizedBox(height: 0.5.h),

          // User Name
          Text(
            userName,
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 1.h),

          // Subtitle
          Text(
            'Secure access with biometric authentication',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final List<String> nameParts = name.trim().split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    return 'U';
  }
}
