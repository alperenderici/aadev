import 'package:flutter/material.dart';
import 'package:aad/core/constants/app_constants.dart';

/// Animated card widget with hover effect
class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? backgroundColor;
  final bool enableHoverEffect;

  const AnimatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.elevation,
    this.backgroundColor,
    this.enableHoverEffect = true,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: widget.enableHoverEffect ? (_) => _setHovered(true) : null,
      onExit: widget.enableHoverEffect ? (_) => _setHovered(false) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.shortAnimation,
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -8.0, 0.0)
              : Matrix4.identity(),
          child: Card(
            elevation: _isHovered
                ? (widget.elevation ?? 2) + 4
                : (widget.elevation ?? 2),
            color: widget.backgroundColor ?? theme.cardTheme.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Padding(
              padding:
                  widget.padding ?? const EdgeInsets.all(AppConstants.spacingL),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  void _setHovered(bool value) {
    if (mounted) {
      setState(() {
        _isHovered = value;
      });
    }
  }
}
