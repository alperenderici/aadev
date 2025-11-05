import 'package:flutter/material.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/core/constants/app_constants.dart';

/// Responsive section wrapper
class ResponsiveSection extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool centerContent;

  const ResponsiveSection({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      horizontal: Responsive.value(
        context: context,
        mobile: AppConstants.spacingL,
        tablet: AppConstants.spacingXXL,
        desktop: AppConstants.spacingXXXL,
      ),
      vertical: Responsive.value(
        context: context,
        mobile: AppConstants.spacingXXL,
        tablet: AppConstants.spacingXXXL,
        desktop: AppConstants.spacingXXXL * 1.5,
      ),
    );

    Widget content = Container(
      width: double.infinity,
      color: backgroundColor,
      padding: padding ?? defaultPadding,
      child: child,
    );

    if (centerContent) {
      content = Container(
        width: double.infinity,
        color: backgroundColor,
        padding: padding ?? defaultPadding,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.maxContentWidth(context),
            ),
            child: child,
          ),
        ),
      );
    }

    return content;
  }
}

