import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_typography.dart';
import 'sakhi_button.dart';

class SakhiEmptyState extends StatelessWidget {
  const SakhiEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    this.onAction,
  });

  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration slot — brand-tinted glyph
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: SakhiColors.primary50,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.people_outline_rounded,
                size: 48,
                color: SakhiColors.brand,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: SakhiText.h2.copyWith(color: SakhiColors.neutral800),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: SakhiText.body.copyWith(color: SakhiColors.neutral500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SakhiButton(
            label: actionLabel,
            onTap: onAction,
          ),
        ],
      ),
    );
  }
}
