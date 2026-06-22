import 'package:flutter/material.dart';

abstract final class SakhiMotion {
  // Durations
  static const Duration micro   = Duration(milliseconds: 100);
  static const Duration fast    = Duration(milliseconds: 200);
  static const Duration normal  = Duration(milliseconds: 300);
  static const Duration slow    = Duration(milliseconds: 450);
  static const Duration countUp = Duration(milliseconds: 600);
  static const Duration stagger = Duration(milliseconds: 40);
  static const Duration sparkline = Duration(milliseconds: 800);

  // Curves
  static const Curve standard  = Curves.easeInOut;
  static const Curve decelerate = Curves.easeOut;
  static const Curve accelerate = Curves.easeIn;
  static const Curve spring     = Curves.elasticOut;

  // Press scale
  static const double pressScale = 0.97;
}
