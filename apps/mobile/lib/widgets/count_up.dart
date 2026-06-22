import 'package:flutter/material.dart';
import '../theme/sakhi_motion.dart';

class CountUpText extends StatefulWidget {
  const CountUpText({
    super.key,
    required this.end,
    required this.style,
    this.prefix = '',
    this.suffix = '',
    this.formatFn,
    this.delay = Duration.zero,
  });

  final double end;
  final TextStyle style;
  final String prefix;
  final String suffix;
  final String Function(double)? formatFn;
  final Duration delay;

  @override
  State<CountUpText> createState() => _CountUpTextState();
}

class _CountUpTextState extends State<CountUpText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: SakhiMotion.countUp);
    _anim = Tween(begin: 0.0, end: widget.end)
        .animate(CurvedAnimation(parent: _ctrl, curve: SakhiMotion.decelerate));
    Future.delayed(widget.delay, () {
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
    return AnimatedBuilder(
      animation: _anim,
      builder: (context2, _) {
        final val = _anim.value;
        final text = widget.formatFn != null
            ? widget.formatFn!(val)
            : val.round().toString();
        return Text(
          '${widget.prefix}$text${widget.suffix}',
          style: widget.style,
        );
      },
    );
  }
}
