import 'package:flutter/material.dart';
import 'sakhi_colors.dart';

// Font family names — must match the CSS font-family names loaded in
// web/index.html via Google Fonts. Flutter HTML renderer uses browser CSS
// text rendering, so these resolve correctly at runtime.
const String _latin   = 'Plus Jakarta Sans';
const String _tamil   = 'Noto Sans Tamil';
const String _deva    = 'Noto Sans Devanagari';

abstract final class SakhiText {
  // ── Latin text styles ───────────────────────────────────────────────────
  static const TextStyle display = TextStyle(
    fontFamily: _latin,
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.15,
    letterSpacing: -0.8,
    color: SakhiColors.neutral900,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: _latin,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: SakhiColors.neutral900,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: _latin,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.3,
    color: SakhiColors.neutral900,
  );

  static const TextStyle title = TextStyle(
    fontFamily: _latin,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.1,
    color: SakhiColors.neutral900,
  );

  static const TextStyle body = TextStyle(
    fontFamily: _latin,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: SakhiColors.neutral800,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _latin,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    color: SakhiColors.neutral800,
  );

  static const TextStyle label = TextStyle(
    fontFamily: _latin,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
    color: SakhiColors.neutral600,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: _latin,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.2,
    color: SakhiColors.neutral500,
  );

  // Money / metric — tabular figures, tight tracking
  static const TextStyle moneyDisplay = TextStyle(
    fontFamily: _latin,
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: -1.0,
    color: Colors.white,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle moneyLarge = TextStyle(
    fontFamily: _latin,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.6,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle moneyMedium = TextStyle(
    fontFamily: _latin,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.3,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle metricLarge = TextStyle(
    fontFamily: _latin,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.4,
    color: SakhiColors.neutral900,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle button = TextStyle(
    fontFamily: _latin,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.1,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _latin,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 0.1,
  );

  // ── Tamil text styles (Noto Sans Tamil) ─────────────────────────────────
  static const TextStyle tamilTitle = TextStyle(
    fontFamily: _tamil,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.45,
    color: SakhiColors.neutral900,
  );

  static const TextStyle tamilBody = TextStyle(
    fontFamily: _tamil,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: SakhiColors.neutral800,
  );

  static const TextStyle tamilLabel = TextStyle(
    fontFamily: _tamil,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: SakhiColors.neutral600,
  );

  static const TextStyle tamilMoneyDisplay = TextStyle(
    fontFamily: _tamil,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: -0.5,
    color: Colors.white,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // ── Devanagari text styles (Noto Sans Devanagari) ────────────────────────
  static const TextStyle devaTitle = TextStyle(
    fontFamily: _deva,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: SakhiColors.neutral900,
  );

  static const TextStyle devaBody = TextStyle(
    fontFamily: _deva,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: SakhiColors.neutral800,
  );
}

// Build the full ThemeData TextTheme from our scale
TextTheme buildSakhiTextTheme() => const TextTheme(
  displayLarge:   SakhiText.display,
  displayMedium:  SakhiText.h1,
  displaySmall:   SakhiText.h2,
  headlineMedium: SakhiText.h2,
  headlineSmall:  SakhiText.title,
  titleLarge:     SakhiText.title,
  titleMedium:    SakhiText.bodyMedium,
  titleSmall:     SakhiText.label,
  bodyLarge:      SakhiText.body,
  bodyMedium:     SakhiText.body,
  bodySmall:      SakhiText.caption,
  labelLarge:     SakhiText.button,
  labelMedium:    SakhiText.label,
  labelSmall:     SakhiText.caption,
);
