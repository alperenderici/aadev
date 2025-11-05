import 'package:flutter/material.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Section title widget with animation
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final bool animate;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.center,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget content = Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : textAlign == TextAlign.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppConstants.spacingM),
          Text(
            subtitle!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
            textAlign: textAlign,
          ),
        ],
      ],
    );

    if (animate) {
      content = content
          .animate()
          .fadeIn(duration: AppConstants.mediumAnimation)
          .slideY(begin: 0.2, end: 0, duration: AppConstants.mediumAnimation);
    }

    return content;
  }
}

