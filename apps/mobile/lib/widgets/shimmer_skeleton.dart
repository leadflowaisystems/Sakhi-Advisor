import 'package:flutter/material.dart';
import '../theme/sakhi_colors.dart';

class ShimmerSkeleton extends StatefulWidget {
  const ShimmerSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.radius = 8,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<ShimmerSkeleton> createState() => _ShimmerSkeletonState();
}

class _ShimmerSkeletonState extends State<ShimmerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _shimmer = Tween(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (ctx, _) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              SakhiColors.neutral100,
              SakhiColors.neutral50,
              SakhiColors.neutral100,
            ],
            stops: [
              (_shimmer.value - 1).clamp(0.0, 1.0),
              _shimmer.value.clamp(0.0, 1.0),
              (_shimmer.value + 1).clamp(0.0, 1.0),
            ],
          ),
        ),
      ),
    );
  }
}

// Convenience wrapper for a shimmer block row
class SkeletonRow extends StatelessWidget {
  const SkeletonRow({super.key, this.widthFactor = 0.7});
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width * widthFactor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerSkeleton(width: w, height: 16),
        const SizedBox(height: 8),
        ShimmerSkeleton(width: w * 0.6, height: 12),
      ],
    );
  }
}
