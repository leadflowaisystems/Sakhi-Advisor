import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/sakhi_colors.dart';
import '../theme/sakhi_motion.dart';
import '../theme/sakhi_typography.dart';

enum SakhiButtonVariant { primary, secondary, destructive, ghost, inline }

class SakhiButton extends StatefulWidget {
  const SakhiButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = SakhiButtonVariant.primary,
    this.icon,
    this.small = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onTap;
  final SakhiButtonVariant variant;
  final IconData? icon;
  final bool small;
  final bool loading;

  @override
  State<SakhiButton> createState() => _SakhiButtonState();
}

class _SakhiButtonState extends State<SakhiButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: SakhiMotion.micro,
      lowerBound: 0,
      upperBound: 1,
    );
    _scale = Tween(begin: 1.0, end: SakhiMotion.pressScale)
        .animate(CurvedAnimation(parent: _ctrl, curve: SakhiMotion.standard));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    HapticFeedback.lightImpact();
    _ctrl.forward();
  }

  void _onTapUp(_) => _ctrl.reverse();
  void _onTapCancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) {
    final (bg, fg, border) = switch (widget.variant) {
      SakhiButtonVariant.primary     => (SakhiColors.brand, Colors.white, Colors.transparent),
      SakhiButtonVariant.secondary   => (Colors.transparent, SakhiColors.brand, SakhiColors.brand),
      SakhiButtonVariant.destructive => (SakhiColors.errorFg, Colors.white, Colors.transparent),
      SakhiButtonVariant.ghost       => (Colors.transparent, SakhiColors.brand, Colors.transparent),
      SakhiButtonVariant.inline      => (SakhiColors.primary50, SakhiColors.brand, Colors.transparent),
    };

    final h = widget.small ? 36.0 : 48.0;
    final px = widget.small ? 14.0 : 20.0;
    final textStyle = widget.small ? SakhiText.buttonSmall : SakhiText.button;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: h,
          padding: EdgeInsets.symmetric(horizontal: px),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: border != Colors.transparent
                ? Border.all(color: border, width: 1.5)
                : null,
          ),
          alignment: Alignment.center,
          child: widget.loading
              ? SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: fg,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 16, color: fg),
                      const SizedBox(width: 6),
                    ],
                    Text(widget.label, style: textStyle.copyWith(color: fg)),
                  ],
                ),
        ),
      ),
    );
  }
}
