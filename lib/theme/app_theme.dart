import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the mobile banking application.
class AppTheme {
  AppTheme._();

  // Banking app color palette - Secure Gold Accent theme
  static const Color primaryDark = Color(0xFF000000); // Deep black foundation
  static const Color secondaryDark =
      Color(0xFF1a1a1a); // Subtle elevation background
  static const Color accentGold =
      Color(0xFF9e814e); // Gold highlight for interactive elements
  static const Color surfaceDark =
      Color(0xFF2d2d2d); // Card backgrounds and input fields
  static const Color successGreen =
      Color(0xFF4caf50); // Transaction confirmations
  static const Color warningAmber =
      Color(0xFFff9800); // Account alerts and pending transactions
  static const Color errorRed =
      Color(0xFFf44336); // Authentication failures and critical alerts
  static const Color textPrimary =
      Color(0xFFffffff); // High contrast white for primary content
  static const Color textSecondary =
      Color(0xFFb3b3b3); // Muted gray for supporting information
  static const Color dividerColor =
      Color(0xFF404040); // Subtle separation lines

  // Additional colors for comprehensive theming
  static const Color cardDark = Color(0xFF2d2d2d);
  static const Color dialogDark = Color(0xFF2d2d2d);
  static const Color shadowDark =
      Color(0x33000000); // 20% opacity black shadows
  static const Color backgroundDark = Color(0xFF000000);

  // Light theme colors (minimal usage for this banking app)
  static const Color primaryLight = Color(0xFF9e814e);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textSecondaryLight = Color(0xFF666666);

  /// Dark theme (primary theme for banking app)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: accentGold,
      onPrimary: primaryDark,
      primaryContainer: accentGold,
      onPrimaryContainer: primaryDark,
      secondary: secondaryDark,
      onSecondary: textPrimary,
      secondaryContainer: surfaceDark,
      onSecondaryContainer: textPrimary,
      tertiary: accentGold,
      onTertiary: primaryDark,
      tertiaryContainer: surfaceDark,
      onTertiaryContainer: textPrimary,
      error: errorRed,
      onError: textPrimary,
      surface: surfaceDark,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: dividerColor,
      outlineVariant: dividerColor,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: textPrimaryLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: primaryDark,
    cardColor: cardDark,
    dividerColor: dividerColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: textPrimary,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    ),
    cardTheme: CardTheme(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: secondaryDark,
      selectedItemColor: accentGold,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentGold,
      foregroundColor: primaryDark,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: primaryDark,
        backgroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: accentGold, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentGold,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: accentGold, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorRed,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold.withValues(alpha: 0.3);
        }
        return dividerColor;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(primaryDark),
      side: const BorderSide(color: dividerColor, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return accentGold;
        }
        return dividerColor;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: accentGold,
      linearTrackColor: dividerColor,
      circularTrackColor: dividerColor,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: accentGold,
      thumbColor: accentGold,
      overlayColor: accentGold.withValues(alpha: 0.2),
      inactiveTrackColor: dividerColor,
      valueIndicatorColor: accentGold,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: primaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: accentGold,
      unselectedLabelColor: textSecondary,
      indicatorColor: accentGold,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: surfaceDark,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: shadowDark,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentGold,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6.0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: surfaceDark,
      modalBackgroundColor: surfaceDark,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: surfaceDark,
      collapsedBackgroundColor: surfaceDark,
      textColor: textPrimary,
      collapsedTextColor: textPrimary,
      iconColor: accentGold,
      collapsedIconColor: textSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  );

  /// Light theme (minimal implementation for fallback)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: backgroundLight,
      primaryContainer: primaryLight,
      onPrimaryContainer: backgroundLight,
      secondary: surfaceLight,
      onSecondary: textPrimaryLight,
      secondaryContainer: surfaceLight,
      onSecondaryContainer: textPrimaryLight,
      tertiary: primaryLight,
      onTertiary: backgroundLight,
      tertiaryContainer: surfaceLight,
      onTertiaryContainer: textPrimaryLight,
      error: errorRed,
      onError: backgroundLight,
      surface: surfaceLight,
      onSurface: textPrimaryLight,
      onSurfaceVariant: textSecondaryLight,
      outline: textSecondaryLight,
      outlineVariant: textSecondaryLight,
      shadow: Colors.black26,
      scrim: Colors.black26,
      inverseSurface: surfaceDark,
      onInverseSurface: textPrimary,
      inversePrimary: accentGold,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: surfaceLight,
    dividerColor: textSecondaryLight,
    textTheme: _buildTextTheme(isLight: true),
    dialogTheme: DialogThemeData(backgroundColor: backgroundLight),
  );

  /// Helper method to build text theme based on brightness
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color primaryTextColor = isLight ? textPrimaryLight : textPrimary;
    final Color secondaryTextColor =
        isLight ? textSecondaryLight : textSecondary;

    return TextTheme(
      // Display styles - Inter Medium/SemiBold for headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),

      // Headline styles - Inter Medium/SemiBold for headings
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
      ),

      // Title styles - Inter Medium for titles
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
      ),

      // Body styles - Inter Regular/Medium for body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.4,
      ),

      // Label styles - Inter Regular/Light for captions
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: primaryTextColor,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w300,
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Custom text styles for financial data using JetBrains Mono
  static TextStyle dataTextStyle({
    required bool isLight,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: isLight ? textPrimaryLight : textPrimary,
      letterSpacing: 0,
    );
  }

  /// Custom text style for account numbers and amounts
  static TextStyle moneyTextStyle({
    required bool isLight,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: isLight ? textPrimaryLight : textPrimary,
      letterSpacing: 0,
    );
  }

  /// Custom box shadow for cards with subtle elevation
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: shadowDark,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  /// Custom box shadow for floating elements
  static List<BoxShadow> floatingShadow = [
    BoxShadow(
      color: shadowDark,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
}
