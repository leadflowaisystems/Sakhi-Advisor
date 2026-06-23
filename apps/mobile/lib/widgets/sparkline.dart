import 'package:flutter/material.dart';
import '../theme/sakhi_motion.dart';

class Sparkline extends StatefulWidget {
  const Sparkline({
    super.key,
    required this.data,
    this.color = Colors.white,
    this.strokeWidth = 2.0,
    this.width = 80,
    this.height = 36,
  });

  final List<double> data;
  final Color color;
  final double strokeWidth;
  final double width;
  final double height;

  @override
  State<Sparkline> createState() => _SparklineState();
}

class _SparklineState extends State<Sparkline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: SakhiMotion.sparkline);
    _progress = CurvedAnimation(parent: _ctrl, curve: SakhiMotion.decelerate);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _progress,
        builder: (ctx, _) => CustomPaint(
          painter: _SparklinePainter(
            data: widget.data,
            progress: _progress.value,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({
    required this.data,
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final List<double> data;
  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;

    final minVal = data.reduce((a, b) => a < b ? a : b);
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal).abs();
    final effectiveRange = range < 0.1 ? 1.0 : range;
    const vPad = 0.12; // vertical padding fraction

    List<Offset> pts = [];
    for (int i = 0; i < data.length; i++) {
      final x = i / (data.length - 1) * size.width;
      final norm = (data[i] - minVal) / effectiveRange;
      final y = size.height - vPad * size.height - norm * size.height * (1 - 2 * vPad);
      pts.add(Offset(x, y));
    }

    // ── Build smooth cubic bezier path ────────────────────────────────────
    final linePath = _buildCurvePath(pts);

    // Clip draw to the revealed width (draw-in animation)
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));

    // ── Gradient area fill ─────────────────────────────────────────────────
    final fillPath = Path.from(linePath);
    fillPath.lineTo(pts.last.dx, size.height);
    fillPath.lineTo(pts.first.dx, size.height);
    fillPath.close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withValues(alpha: 0.30),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    // ── Smooth stroke ──────────────────────────────────────────────────────
    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..isAntiAlias = true,
    );

    canvas.restore();

    // ── End-point dot (fades in after line is drawn) ───────────────────────
    if (progress > 0.82) {
      final dotFade = ((progress - 0.82) / 0.18).clamp(0.0, 1.0);
      final endPt = pts.last;

      // Outer glow
      canvas.drawCircle(
        endPt,
        strokeWidth + 3.0,
        Paint()..color = color.withValues(alpha: 0.20 * dotFade),
      );
      // Halo ring
      canvas.drawCircle(
        endPt,
        strokeWidth + 1.5,
        Paint()..color = color.withValues(alpha: 0.40 * dotFade),
      );
      // Solid dot
      canvas.drawCircle(
        endPt,
        strokeWidth * 0.9,
        Paint()..color = color.withValues(alpha: dotFade),
      );
    }
  }

  // Catmull-Rom-like smooth cubic bezier through all points
  Path _buildCurvePath(List<Offset> pts) {
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      final prev = pts[i - 1];
      final curr = pts[i];
      // Tension 0.4 gives a smooth, not-too-wavy curve
      final cx1 = prev.dx + (curr.dx - prev.dx) * 0.45;
      final cy1 = prev.dy;
      final cx2 = curr.dx - (curr.dx - prev.dx) * 0.45;
      final cy2 = curr.dy;
      path.cubicTo(cx1, cy1, cx2, cy2, curr.dx, curr.dy);
    }
    return path;
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.progress != progress || old.data != data || old.color != color;
}
