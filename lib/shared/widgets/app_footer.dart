import 'package:flutter/material.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';

/// App footer widget
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(
          context: context,
          mobile: AppConstants.spacingL,
          tablet: AppConstants.spacingXL,
          desktop: AppConstants.spacingXXXL,
        ),
        vertical: AppConstants.spacingXL,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.dividerTheme.color ?? Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            l10n.footerCopyright,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            l10n.footerBuiltWith,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

