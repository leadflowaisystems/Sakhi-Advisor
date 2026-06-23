import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_typography.dart';

class SakhiSectionHeader extends StatelessWidget {
  const SakhiSectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onActionTap,
  });

  final String title;
  final String? action;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: SakhiText.title.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: SakhiColors.neutral700,
              letterSpacing: 0,
            ),
          ),
        ),
        if (action != null)
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              action!,
              style: SakhiText.label.copyWith(
                color: SakhiColors.brand,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
