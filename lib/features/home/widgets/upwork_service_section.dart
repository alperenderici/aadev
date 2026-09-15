import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/animated_card.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:url_launcher/url_launcher.dart';

/// Upwork Service section widget
class UpworkServiceSection extends StatelessWidget {
  const UpworkServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child:
          AnimatedCard(
                enableHoverEffect: false,
                padding: const EdgeInsets.all(AppConstants.spacingL),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIconAndText(context, l10n, theme),
                          const SizedBox(height: AppConstants.spacingM),
                          _buildCta(context, l10n, theme),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: _buildIconAndText(context, l10n, theme),
                          ),
                          const SizedBox(width: AppConstants.spacingL),
                          _buildCta(context, l10n, theme),
                        ],
                      ),
              )
              .animate()
              .fadeIn(duration: AppConstants.mediumAnimation)
              .slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildIconAndText(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingS),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          child: Icon(
            Icons.work_outline,
            color: theme.colorScheme.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: AppConstants.spacingM),
        Expanded(
          child: Text(
            l10n.translate('upwork_service_title'),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCta(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return TextButton.icon(
      onPressed: () async {
        final url = Uri.parse(AppConstants.upworkServiceUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      icon: const Icon(Icons.open_in_new, size: 18),
      label: Text(l10n.translate('upwork_service_cta')),
    );
  }
}
