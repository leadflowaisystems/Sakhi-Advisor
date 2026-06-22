import 'package:flutter/material.dart';

abstract final class SakhiColors {
  // ── Primary teal ramp ─────────────────────────────────────────────────────
  static const primary50  = Color(0xFFE6F2F0);
  static const primary100 = Color(0xFFC0DDD9);
  static const primary200 = Color(0xFF96C7C1);
  static const primary300 = Color(0xFF6AB0A9);
  static const primary400 = Color(0xFF479E96);
  static const primary500 = Color(0xFF168072); // lighter brand tone
  static const primary600 = Color(0xFF0E6B5E);
  static const primary700 = Color(0xFF0C544C); // base brand
  static const primary800 = Color(0xFF093D38);
  static const primary900 = Color(0xFF062824);

  static const brand     = primary700; // #0C544C
  static const brandMid  = primary500; // #168072

  // ── Canvas & surfaces ─────────────────────────────────────────────────────
  static const canvas    = Color(0xFFFAF8F4); // warm off-white
  static const surface   = Color(0xFFFFFFFF); // raised card

  // ── Accent amber (sparingly — celebrations only) ──────────────────────────
  static const amber     = Color(0xFFD98324);
  static const amber50   = Color(0xFFFDF3E3);
  static const amber100  = Color(0xFFF9DFB0);
  static const amber200  = Color(0xFFF4C97D);

  // ── Warm gray neutral ramp (cream-biased) ─────────────────────────────────
  static const neutral50  = Color(0xFFF7F5F2);
  static const neutral100 = Color(0xFFEEEBE6);
  static const neutral200 = Color(0xFFE0DCD5);
  static const neutral300 = Color(0xFFCBC6BE);
  static const neutral400 = Color(0xFFAEA89F);
  static const neutral500 = Color(0xFF8C867C);
  static const neutral600 = Color(0xFF6B655C);
  static const neutral700 = Color(0xFF4E4940);
  static const neutral800 = Color(0xFF332E27);
  static const neutral900 = Color(0xFF1A1710);

  // ── Semantic pairs {bgTint, fg} ───────────────────────────────────────────
  static const successBg  = Color(0xFFE8F6EF);
  static const successFg  = Color(0xFF1A7A4A);
  static const warningBg  = Color(0xFFFFF3E0);
  static const warningFg  = Color(0xFFBF6A00);
  static const infoBg     = Color(0xFFE8F0FE);
  static const infoFg     = Color(0xFF1657C4);
  static const errorBg    = Color(0xFFFFEBEE);
  static const errorFg    = Color(0xFFC62828);

  // ── Hero card gradient stops ───────────────────────────────────────────────
  static const heroBase   = Color(0xFF0A4840);
  static const heroMid    = Color(0xFF0C544C);
  static const heroHighlight = Color(0xFF1A6B62);

  // ── Hairline border ────────────────────────────────────────────────────────
  static const hairline   = Color(0x14000000); // 8% black
}
