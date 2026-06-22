import 'package:flutter/material.dart';
import '../../../theme/sakhi_colors.dart';
import '../../../theme/sakhi_elevation.dart';
import '../../../theme/sakhi_typography.dart';
import '../../../utils/inr_formatter.dart';
import '../../../utils/l10n.dart';
import '../../../widgets/count_up.dart';
import '../../../widgets/sparkline.dart';
import '../../../mock/mock_data.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.strings,
  });

  final SakhiStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SakhiElevation.r20),
        boxShadow: SakhiElevation.hero,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SakhiColors.heroBase,
            SakhiColors.heroMid,
            SakhiColors.heroHighlight,
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SakhiElevation.r20),
        child: Stack(
          children: [
            // Subtle inner highlight glow
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings.heroPracticeLabel,
                              style: SakhiText.label.copyWith(
                                color: Colors.white.withValues(alpha: 0.65),
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              strings.heroMonthLabel,
                              style: SakhiText.bodyMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Sparkline
                      Sparkline(
                        data: MockData.sparklineData,
                        color: Colors.white.withValues(alpha: 0.9),
                        fillColor: Colors.white.withValues(alpha: 0.12),
                        strokeWidth: 2,
                        width: 80,
                        height: 36,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Big money figure
                  CountUpText(
                    end: MockData.totalAum,
                    style: SakhiText.moneyDisplay,
                    formatFn: (v) => InrFormatter.format(v, compact: false),
                    delay: const Duration(milliseconds: 200),
                  ),

                  const SizedBox(height: 6),

                  // Subtitle — wrap-safe
                  Text(
                    strings.heroSubtitle,
                    style: SakhiText.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 14),

                  // Trend chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: SakhiColors.successFg.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: SakhiColors.successFg.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      strings.heroTrend,
                      style: SakhiText.caption.copyWith(
                        color: const Color(0xFF6EE7B7),
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
