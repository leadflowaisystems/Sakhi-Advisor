import 'package:flutter/material.dart';
import 'sakhi_colors.dart';

abstract final class SakhiElevation {
  // Radius scale
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;
  static const double r24 = 24;

  // Raised card shadow (multi-layer, warm-tinted)
  static List<BoxShadow> get card => [
    BoxShadow(
      color: const Color(0xFF0C544C).withValues(alpha: 0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  // Hero card (deeper)
  static List<BoxShadow> get hero => [
    BoxShadow(
      color: const Color(0xFF0C544C).withValues(alpha: 0.25),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  // Stat tile (lighter)
  static List<BoxShadow> get tile => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.03),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static BoxDecoration cardDecoration({
    double radius = r16,
    Color? color,
    bool withHairline = true,
  }) => BoxDecoration(
    color: color ?? SakhiColors.surface,
    borderRadius: BorderRadius.circular(radius),
    border: withHairline ? Border.all(color: SakhiColors.hairline, width: 1) : null,
    boxShadow: card,
  );
}
