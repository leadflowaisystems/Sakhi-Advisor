import 'package:flutter/material.dart';
import '../../../theme/sakhi_colors.dart';
import '../../../theme/sakhi_elevation.dart';
import '../../../theme/sakhi_typography.dart';
import '../../../widgets/sakhi_avatar.dart';
import '../../../widgets/sakhi_button.dart';
import '../../../widgets/sakhi_status_pill.dart';
import '../../../widgets/stagger_entrance.dart';
import '../../../mock/mock_data.dart';
import '../../../utils/l10n.dart';

class AttentionRow extends StatelessWidget {
  const AttentionRow({
    super.key,
    required this.client,
    required this.strings,
    required this.index,
    this.onAction,
  });

  final MockClient client;
  final SakhiStrings strings;
  final int index;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final (pillLabel, pillVariant) = switch (client.statusKey) {
      'kycPending' => (strings.kycPending, PillVariant.warning),
      'docBlurry'  => (strings.docBlurry,  PillVariant.error),
      'sipStarted' => (strings.sipStarted, PillVariant.success),
      'kycDone'    => (strings.kycDone,    PillVariant.success),
      _            => (client.statusKey,   PillVariant.neutral),
    };

    final actionLabel = client.actionKey == 'remind'
        ? strings.remind
        : strings.reupload;

    final displayName = switch (strings.locale) {
      SakhiLocale.hindi => client.hindiName,
      SakhiLocale.tamil => client.tamilName,
      _                 => client.name,
    };

    return StaggerEntrance(
      index: index,
      baseDelay: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: SakhiColors.surface,
          borderRadius: BorderRadius.circular(SakhiElevation.r16),
          border: Border.all(color: SakhiColors.hairline, width: 1),
          boxShadow: SakhiElevation.tile,
        ),
        child: Row(
          children: [
            SakhiAvatar(
              initials: client.initials,
              backgroundColor: Color(client.avatarColor),
              size: 44,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: SakhiText.bodyMedium.copyWith(
                      color: SakhiColors.neutral900,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  SakhiStatusPill(label: pillLabel, variant: pillVariant),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SakhiButton(
              label: actionLabel,
              variant: SakhiButtonVariant.inline,
              small: true,
              onTap: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
