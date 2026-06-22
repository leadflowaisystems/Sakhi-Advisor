import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'sakhi_colors.dart';
import 'sakhi_typography.dart';

ThemeData buildSakhiTheme() {
  final textTheme = buildSakhiTextTheme();

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: SakhiColors.brand,
      onPrimary: Colors.white,
      primaryContainer: SakhiColors.primary100,
      onPrimaryContainer: SakhiColors.primary800,
      secondary: SakhiColors.amber,
      onSecondary: Colors.white,
      secondaryContainer: SakhiColors.amber50,
      onSecondaryContainer: SakhiColors.neutral800,
      tertiary: SakhiColors.brandMid,
      onTertiary: Colors.white,
      error: SakhiColors.errorFg,
      onError: Colors.white,
      surface: SakhiColors.surface,
      onSurface: SakhiColors.neutral900,
      surfaceContainerHighest: SakhiColors.neutral100,
      onSurfaceVariant: SakhiColors.neutral600,
      outline: SakhiColors.neutral300,
      outlineVariant: SakhiColors.hairline,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: SakhiColors.neutral900,
      onInverseSurface: Colors.white,
      inversePrimary: SakhiColors.primary200,
    ),
    scaffoldBackgroundColor: SakhiColors.canvas,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: SakhiColors.canvas,
      foregroundColor: SakhiColors.neutral900,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      titleTextStyle: SakhiText.title,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SakhiColors.brand,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: SakhiText.button,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: SakhiColors.brand,
        minimumSize: const Size(0, 48),
        side: const BorderSide(color: SakhiColors.brand, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: SakhiText.button,
      ),
    ),
    cardTheme: CardThemeData(
      color: SakhiColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: SakhiColors.hairline, width: 1),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: SakhiColors.neutral100,
      thickness: 1,
      space: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: SakhiColors.surface,
      selectedItemColor: SakhiColors.brand,
      unselectedItemColor: SakhiColors.neutral400,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: SakhiText.caption.copyWith(
        fontWeight: FontWeight.w600,
        color: SakhiColors.brand,
      ),
      unselectedLabelStyle: SakhiText.caption,
    ),
    splashFactory: InkRipple.splashFactory,
    splashColor: SakhiColors.primary100.withValues(alpha: 0.5),
    highlightColor: Colors.transparent,
  );
}
