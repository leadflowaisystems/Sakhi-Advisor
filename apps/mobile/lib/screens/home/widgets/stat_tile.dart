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
    required this.tintColor,
    required this.value,
    required this.label,
    required this.index,
  });

  final IconData icon;
  final Color iconBg;
  final Color tintColor; // semantic fg — colors icon + metric number
  final int value;
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return StaggerEntrance(
      index: index,
      baseDelay: const Duration(milliseconds: 380),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: SakhiColors.surface,
          borderRadius: BorderRadius.circular(SakhiElevation.r16),
          border: Border.all(color: SakhiColors.hairline, width: 1),
          boxShadow: SakhiElevation.tile,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon chip — tinted
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 15, color: tintColor),
            ),
            const SizedBox(height: 8),
            // Metric number — inherits tint
            CountUpText(
              end: value.toDouble(),
              style: SakhiText.metricLarge.copyWith(
                fontSize: 22,
                color: tintColor,
              ),
              delay: Duration(milliseconds: 420 + index * 50),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: SakhiText.caption.copyWith(
                color: SakhiColors.neutral500,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
