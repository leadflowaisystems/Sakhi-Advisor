import 'package:flutter/material.dart';
import '../../../theme/sakhi_colors.dart';
import '../../../theme/sakhi_elevation.dart';
import '../../../theme/sakhi_typography.dart';
import '../../../widgets/count_up.dart';
import '../../../widgets/stagger_entrance.dart';

class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.value,
    required this.label,
    required this.index,
  });

  final IconData icon;
  final Color iconBg;
  final int value;
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StaggerEntrance(
      index: index,
      baseDelay: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: SakhiColors.surface,
          borderRadius: BorderRadius.circular(SakhiElevation.r16),
          border: Border.all(color: SakhiColors.hairline, width: 1),
          boxShadow: SakhiElevation.tile,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon chip
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: _darken(iconBg)),
            ),
            const SizedBox(height: 12),
            // Big number
            CountUpText(
              end: value.toDouble(),
              style: SakhiText.metricLarge,
              delay: Duration(milliseconds: 500 + index * 60),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: SakhiText.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  static Color _darken(Color bg) {
    final hsl = HSLColor.fromColor(bg);
    return hsl.withLightness((hsl.lightness - 0.35).clamp(0.1, 1.0)).toColor();
  }
}
