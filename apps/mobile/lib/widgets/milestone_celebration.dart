import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';

/// Fire with: MilestoneCelebration.show(context, message: '...')
class MilestoneCelebration {
  static void show(BuildContext context, {required String message}) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (_) => _CelebrationDialog(message: message),
    );
  }
}

class _CelebrationDialog extends StatefulWidget {
  const _CelebrationDialog({required this.message});
  final String message;

  @override
  State<_CelebrationDialog> createState() => _CelebrationDialogState();
}

class _CelebrationDialogState extends State<_CelebrationDialog>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _confetti;
  late final List<_Particle> _particles;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _confetti = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();

    _particles = List.generate(28, (_) => _Particle(_rng));

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) Navigator.of(context, rootNavigator: true).pop();
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _confetti,
        builder: (context2, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              ..._particles.map((p) => p.build(_confetti.value)),
              child!,
            ],
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: SakhiColors.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: SakhiColors.brand.withValues(alpha: 0.2),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                animation: _pulse,
                builder: (ctx, _) => Transform.scale(
                  scale: 1.0 + _pulse.value * 0.1,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: SakhiColors.successBg,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: SakhiColors.successFg.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: SakhiColors.successFg,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: SakhiColors.neutral900,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Particle {
  _Particle(Random rng)
      : angle = rng.nextDouble() * pi * 2,
        distance = 80 + rng.nextDouble() * 100,
        color = _colors[rng.nextInt(_colors.length)],
        size = 5 + rng.nextDouble() * 7,
        rotSpeed = (rng.nextDouble() - 0.5) * 6;

  static const _colors = [
    SakhiColors.amber,
    SakhiColors.brand,
    SakhiColors.brandMid,
    SakhiColors.successFg,
    Color(0xFFE91E8C),
  ];

  final double angle;
  final double distance;
  final Color color;
  final double size;
  final double rotSpeed;

  Widget build(double t) {
    final ease = Curves.easeOut.transform(t);
    final dx = cos(angle) * distance * ease;
    final dy = sin(angle) * distance * ease;
    final opacity = (1 - t).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(dx, dy),
      child: Transform.rotate(
        angle: rotSpeed * t,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: size,
            height: size * 0.5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
