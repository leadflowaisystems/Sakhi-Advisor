import 'package:flutter/material.dart';
import '../../../theme/sakhi_colors.dart';
import '../../../theme/sakhi_typography.dart';
import '../../../mock/mock_data.dart';
import '../../../utils/l10n.dart';
import '../../../widgets/stagger_entrance.dart';

IconData _iconFor(int code) {
  return switch (code) {
    0xe876 => Icons.check_circle,
    0xe8e8 => Icons.trending_up,
    0xe7fe => Icons.person_add,
    _      => Icons.circle_notifications,
  };
}

class ActivityRow extends StatelessWidget {
  const ActivityRow({
    super.key,
    required this.activity,
    required this.locale,
    required this.index,
    this.showDivider = true,
  });

  final MockActivity activity;
  final SakhiLocale locale;
  final int index;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final desc = locale == SakhiLocale.tamil
        ? activity.tamilDescription
        : activity.description;

    return StaggerEntrance(
      index: index,
      baseDelay: const Duration(milliseconds: 700),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Color(activity.iconColor).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _iconFor(activity.iconCode),
                    size: 18,
                    color: Color(activity.iconColor),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    desc,
                    style: SakhiText.body.copyWith(
                      color: SakhiColors.neutral800,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  activity.time,
                  style: SakhiText.caption,
                ),
              ],
            ),
          ),
          if (showDivider)
            const Divider(height: 0, indent: 48),
        ],
      ),
    );
  }
}
