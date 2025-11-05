import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/constants/asset_paths.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:aad/shared/widgets/animated_card.dart';
import 'package:aad/shared/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// CV download section widget
class CVDownloadSection extends StatelessWidget {
  const CVDownloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          SectionTitle(title: l10n.cvTitle),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildDownloadCards(context, l10n, theme),
        ],
      ),
    );
  }

  Widget _buildDownloadCards(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    final isMobile = Responsive.isMobile(context);

    return isMobile
        ? Column(
            children: [
              _buildCVCard(context, l10n, theme),
              const SizedBox(height: AppConstants.spacingL),
              _buildCoverLetterCard(context, l10n, theme),
            ],
          )
        : Row(
            children: [
              Expanded(child: _buildCVCard(context, l10n, theme)),
              const SizedBox(width: AppConstants.spacingXL),
              Expanded(child: _buildCoverLetterCard(context, l10n, theme)),
            ],
          );
  }

  Widget _buildCVCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return AnimatedCard(
          child: Column(
            children: [
              Icon(
                Icons.description,
                size: 64,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: AppConstants.spacingL),
              Text(
                l10n.cvDownload,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingXL),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.cvEnglish,
                      onPressed: () => _downloadFile(AssetPaths.cvEnglish),
                      icon: Icons.download,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () => _downloadFile(AssetPaths.cvTurkish),
                      icon: Icons.download,
                      isOutlined: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: AppConstants.mediumAnimation)
        .slideX(begin: -0.2, end: 0);
  }

  Widget _buildCoverLetterCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return AnimatedCard(
          child: Column(
            children: [
              Icon(Icons.mail, size: 64, color: theme.colorScheme.secondary),
              const SizedBox(height: AppConstants.spacingL),
              Text(
                l10n.cvCoverLetter,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingXL),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: l10n.cvEnglish,
                      onPressed: () =>
                          _downloadFile(AssetPaths.coverLetterEnglish),
                      icon: Icons.download,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () =>
                          _downloadFile(AssetPaths.coverLetterTurkish),
                      icon: Icons.download,
                      isOutlined: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: AppConstants.mediumAnimation, delay: 200.ms)
        .slideX(begin: 0.2, end: 0);
  }

  Future<void> _downloadFile(String assetPath) async {
    // Track download event
    String type = '';
    if (assetPath.contains('CV')) {
      type = assetPath.contains('EN') ? 'CV_EN' : 'CV_TR';
    } else {
      type = assetPath.contains('EN') ? 'CL_EN' : 'CL_TR';
    }
    AnalyticsService.logCVDownload(type);

    // For web, we need to use the full URL path
    // In production, assets are served from the root
    final url = Uri.parse('/$assetPath');

    try {
      await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    } catch (e) {
      // If that fails, try without the leading slash
      try {
        await launchUrl(
          Uri.parse(assetPath),
          mode: LaunchMode.platformDefault,
          webOnlyWindowName: '_blank',
        );
      } catch (e) {
        // Ignore errors - file will open in new tab if available
      }
    }
  }
}
