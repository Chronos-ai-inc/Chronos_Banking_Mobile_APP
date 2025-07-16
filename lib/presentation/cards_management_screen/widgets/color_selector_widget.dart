import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../theme/app_theme.dart';

class ColorSelectorWidget extends StatelessWidget {
  final List<Color> colors;
  final int selectedIndex;
  final Function(int) onColorChanged;

  const ColorSelectorWidget({
    Key? key,
    required this.colors,
    required this.selectedIndex,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.asMap().entries.map((entry) {
        final index = entry.key;
        final color = entry.value;
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onColorChanged(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 1.w),
            width: isSelected ? 35.sp : 30.sp,
            height: isSelected ? 35.sp : 30.sp,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppTheme.accentGold : AppTheme.dividerColor,
                width: isSelected ? 3 : 1,
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: AppTheme.accentGold.withAlpha(77),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
              ],
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    color: color == AppTheme.accentGold
                        ? AppTheme.primaryDark
                        : AppTheme.textPrimary,
                    size: 16.sp,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
