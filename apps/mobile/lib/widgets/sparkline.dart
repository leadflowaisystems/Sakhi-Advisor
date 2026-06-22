import 'package:flutter/material.dart';
import '../theme/sakhi_motion.dart';

class Sparkline extends StatefulWidget {
  const Sparkline({
    super.key,
    required this.data,
    this.color = Colors.white,
    this.fillColor,
    this.strokeWidth = 2.0,
    this.width = 80,
    this.height = 36,
  });

  final List<double> data;
  final Color color;
  final Color? fillColor;
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
    Future.delayed(const Duration(milliseconds: 300), () {
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
            fillColor: widget.fillColor ?? widget.color.withValues(alpha: 0.2),
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
    required this.fillColor,
    required this.strokeWidth,
  });

  final List<double> data;
  final double progress;
  final Color color;
  final Color fillColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final minVal = data.reduce((a, b) => a < b ? a : b);
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    final range = (maxVal - minVal).abs();
    final effectiveRange = range < 1 ? 1.0 : range;

    List<Offset> pts = [];
    for (int i = 0; i < data.length; i++) {
      final x = i / (data.length - 1) * size.width;
      final y = size.height - ((data[i] - minVal) / effectiveRange) * size.height * 0.8 - size.height * 0.1;
      pts.add(Offset(x, y));
    }

    // Clip to progress width
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));

    // Fill
    final fillPath = Path()..moveTo(pts.first.dx, size.height);
    for (final pt in pts) {
      fillPath.lineTo(pt.dx, pt.dy);
    }
    fillPath.lineTo(pts.last.dx, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, Paint()..color = fillColor);

    // Line
    final linePath = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 1; i < pts.length; i++) {
      final cp1 = Offset(
        (pts[i - 1].dx + pts[i].dx) / 2,
        pts[i - 1].dy,
      );
      final cp2 = Offset(
        (pts[i - 1].dx + pts[i].dx) / 2,
        pts[i].dy,
      );
      linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, pts[i].dx, pts[i].dy);
    }

    canvas.drawPath(
      linePath,
      Paint()
        ..color = color
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    // Dot at last point
    if (progress > 0.9) {
      canvas.drawCircle(
        pts.last,
        strokeWidth + 1,
        Paint()..color = color,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_SparklinePainter old) =>
      old.progress != progress || old.data != data;
}
