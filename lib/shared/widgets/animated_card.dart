import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:aad/core/constants/app_constants.dart';

/// Animated card widget with hover effect
class AnimatedCard extends HookWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHovered = useState(false);

    return MouseRegion(
      onEnter: enableHoverEffect ? (_) => isHovered.value = true : null,
      onExit: enableHoverEffect ? (_) => isHovered.value = false : null,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppConstants.shortAnimation,
          transform: isHovered.value
              ? Matrix4.translationValues(0.0, -8.0, 0.0)
              : Matrix4.identity(),
          child: Card(
            elevation: isHovered.value
                ? (elevation ?? 2) + 4
                : (elevation ?? 2),
            color: backgroundColor ?? theme.cardTheme.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(AppConstants.spacingL),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
