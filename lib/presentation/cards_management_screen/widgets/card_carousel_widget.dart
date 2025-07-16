import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_theme.dart';
import './card_preview_widget.dart';
import './color_selector_widget.dart';

class CardCarouselWidget extends StatefulWidget {
  final String category;
  final List<String> plans;
  final List<Color> colors;
  final int selectedColorIndex;
  final String selectedPlan;
  final Function(int) onColorChanged;
  final Function(String) onPlanChanged;

  const CardCarouselWidget({
    Key? key,
    required this.category,
    required this.plans,
    required this.colors,
    required this.selectedColorIndex,
    required this.selectedPlan,
    required this.onColorChanged,
    required this.onPlanChanged,
  }) : super(key: key);

  @override
  State<CardCarouselWidget> createState() => _CardCarouselWidgetState();
}

class _CardCarouselWidgetState extends State<CardCarouselWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 25.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              widget.onPlanChanged(widget.plans[index]);
            },
            itemCount: widget.plans.length,
            itemBuilder: (context, index) {
              final plan = widget.plans[index];
              final isSelected = index == _currentIndex;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(
                  horizontal: 2.w,
                  vertical: isSelected ? 0 : 1.h,
                ),
                child: CardPreviewWidget(
                  category: widget.category,
                  plan: plan,
                  color: widget.colors[widget.selectedColorIndex],
                  isSelected: isSelected,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.plans.asMap().entries.map((entry) {
            final index = entry.key;
            final plan = entry.value;
            final isSelected = index == _currentIndex;

            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppTheme.accentGold : AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(2.w),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.accentGold
                        : AppTheme.dividerColor,
                  ),
                ),
                child: Text(
                  plan,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? AppTheme.primaryDark
                        : AppTheme.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 2.h),
        ColorSelectorWidget(
          colors: widget.colors,
          selectedIndex: widget.selectedColorIndex,
          onColorChanged: widget.onColorChanged,
        ),
      ],
    );
  }
}
