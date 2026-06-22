import 'package:flutter/material.dart';
import '../theme/sakhi_motion.dart';

/// Wraps a child in a staggered fade + slide-up entrance.
class StaggerEntrance extends StatefulWidget {
  const StaggerEntrance({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 200),
  });

  final Widget child;
  final int index;
  final Duration baseDelay;

  @override
  State<StaggerEntrance> createState() => _StaggerEntranceState();
}

class _StaggerEntranceState extends State<StaggerEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: SakhiMotion.slow);
    _fade = CurvedAnimation(parent: _ctrl, curve: SakhiMotion.decelerate);
    _slide = Tween(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: SakhiMotion.decelerate));

    final delay = widget.baseDelay +
        Duration(milliseconds: widget.index * SakhiMotion.stagger.inMilliseconds);
    Future.delayed(delay, () {
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
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
