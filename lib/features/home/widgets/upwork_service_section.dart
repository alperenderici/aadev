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
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.secondary.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.work, color: theme.colorScheme.primary, size: 32),
                const SizedBox(width: AppConstants.spacingM),
                Expanded(
                  child: Text(
                    l10n.translate('upwork_service_title'),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(duration: AppConstants.mediumAnimation)
                .slideX(begin: -0.2, end: 0),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              l10n.translate('upwork_service_desc'),
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: 18,
              ),
            )
                .animate()
                .fadeIn(
                  duration: AppConstants.mediumAnimation,
                  delay: 200.ms,
                )
                .slideY(begin: 0.2, end: 0),
            const SizedBox(height: AppConstants.spacingXL),
            InkWell(
              onTap: () async {
                final url = Uri.parse(AppConstants.upworkServiceUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingXL,
                  vertical: AppConstants.spacingL,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.translate('upwork_service_cta'),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingM),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(
                  duration: AppConstants.mediumAnimation,
                  delay: 400.ms,
                )
                .scale(
                  duration: AppConstants.mediumAnimation,
                  delay: 400.ms,
                ),
          ],
        ),
      ),
    );
  }
}

