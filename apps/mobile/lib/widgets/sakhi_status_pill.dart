import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_typography.dart';

enum PillVariant { success, warning, info, error, neutral }

class SakhiStatusPill extends StatelessWidget {
  const SakhiStatusPill({
    super.key,
    required this.label,
    this.variant = PillVariant.neutral,
  });

  final String label;
  final PillVariant variant;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (variant) {
      PillVariant.success => (SakhiColors.successBg, SakhiColors.successFg),
      PillVariant.warning => (SakhiColors.warningBg, SakhiColors.warningFg),
      PillVariant.info    => (SakhiColors.infoBg,    SakhiColors.infoFg),
      PillVariant.error   => (SakhiColors.errorBg,   SakhiColors.errorFg),
      PillVariant.neutral => (SakhiColors.neutral100, SakhiColors.neutral600),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: SakhiText.caption.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          fontSize: 11,
          height: 1.3,
        ),
      ),
    );
  }
}
