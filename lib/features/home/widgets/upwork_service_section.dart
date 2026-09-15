import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:url_launcher/url_launcher.dart';

/// Upwork Service section widget
class UpworkServiceSection extends StatelessWidget {
  const UpworkServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: theme.colorScheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: AppConstants.spacingS),
                    Expanded(
                      child: Text(
                        l10n.translate('upwork_service_title'),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: AppConstants.mediumAnimation)
                .slideX(begin: -0.2, end: 0),
            const SizedBox(height: AppConstants.spacingXS),
            Text(
                  l10n.translate('upwork_service_desc'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    height: 1.5,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                )
                .animate()
                .fadeIn(duration: AppConstants.mediumAnimation, delay: 200.ms)
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: AppConstants.spacingS),
            InkWell(
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              onTap: () async {
                final url = Uri.parse(AppConstants.upworkServiceUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.spacingXS,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.translate('upwork_service_cta'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingXS),
                    Icon(
                      Icons.arrow_forward,
                      color: theme.colorScheme.primary,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(
              duration: AppConstants.mediumAnimation,
              delay: 400.ms,
            ),
          ],
        ),
      ),
    );
  }
}
