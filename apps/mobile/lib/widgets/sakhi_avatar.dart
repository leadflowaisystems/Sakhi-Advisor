import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_typography.dart';

class SakhiAvatar extends StatelessWidget {
  const SakhiAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.backgroundColor,
    this.textColor = Colors.white,
  });

  final String initials;
  final double size;
  final Color? backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? SakhiColors.brand,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials.length > 2 ? initials.substring(0, 2) : initials,
        style: SakhiText.label.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.36,
          height: 1.0,
        ),
      ),
    );
  }
}
