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
  const HeroCard({super.key, required this.strings});

  final SakhiStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SakhiElevation.r20),
        boxShadow: SakhiElevation.hero,
        gradient: const LinearGradient(
          begin: Alignment(-0.6, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [
            Color(0xFF0D5C53), // lighter top-left spotlight
            SakhiColors.heroMid,
            SakhiColors.heroBase,
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SakhiElevation.r20),
        child: Stack(
          children: [
            // Subtle radial glow in top-left corner
            Positioned(
              top: -30,
              left: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.07),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Left: labels + big number ──────────────────────────
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Practice label row
                        Row(
                          children: [
                            Text(
                              strings.heroPracticeLabel,
                              style: SakhiText.caption.copyWith(
                                color: Colors.white.withValues(alpha: 0.6),
                                letterSpacing: 0.3,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              '  ·  ',
                              style: SakhiText.caption.copyWith(
                                color: Colors.white.withValues(alpha: 0.3),
                                height: 1.0,
                              ),
                            ),
                            Text(
                              strings.heroMonthLabel,
                              style: SakhiText.caption.copyWith(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Big AUM figure with count-up
                        CountUpText(
                          end: MockData.totalAum,
                          style: SakhiText.moneyDisplay.copyWith(fontSize: 30),
                          formatFn: (v) => InrFormatter.format(v, compact: false),
                          delay: const Duration(milliseconds: 150),
                        ),

                        const SizedBox(height: 4),

                        // Subtitle — short, no orphan wrap
                        Text(
                          strings.heroSubtitle,
                          style: SakhiText.caption.copyWith(
                            color: Colors.white.withValues(alpha: 0.55),
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ── Right: sparkline + trend chip ─────────────────────
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Sparkline(
                        data: MockData.sparklineData,
                        color: Colors.white.withValues(alpha: 0.9),
                        fillColor: Colors.white.withValues(alpha: 0.10),
                        strokeWidth: 1.8,
                        width: 72,
                        height: 32,
                      ),
                      const SizedBox(height: 8),
                      // Trend chip — inline with sparkline column
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A7A4A).withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFF6EE7B7).withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          strings.heroTrend,
                          style: SakhiText.caption.copyWith(
                            color: const Color(0xFF6EE7B7),
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 1.0,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
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
