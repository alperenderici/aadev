import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/constants/asset_paths.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/providers/locale_provider.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:aad/shared/widgets/animated_card.dart';
import 'package:aad/shared/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// CV download section widget
class CVDownloadSection extends ConsumerWidget {
  const CVDownloadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = ref.watch(localeProvider);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          SectionTitle(title: l10n.cvTitle),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildDownloadCards(context, l10n, theme, locale),
        ],
      ),
    );
  }

  Widget _buildDownloadCards(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    Locale locale,
  ) {
    final isMobile = Responsive.isMobile(context);

    return isMobile
        ? Column(
            children: [
              _buildCVCard(context, l10n, theme, locale),
              const SizedBox(height: AppConstants.spacingL),
              _buildCoverLetterCard(context, l10n, theme, locale),
            ],
          )
        : Row(
            children: [
              Expanded(child: _buildCVCard(context, l10n, theme, locale)),
              const SizedBox(width: AppConstants.spacingXL),
              Expanded(
                child: _buildCoverLetterCard(context, l10n, theme, locale),
              ),
            ],
          );
  }

  Widget _buildCVCard(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    Locale locale,
  ) {
    // If Turkish, Turkish button is outlined; if English, English button is outlined
    final isTurkish = locale.languageCode == 'tr';
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
                      isOutlined:
                          isTurkish, // English outlined if Turkish is active
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () => _downloadFile(AssetPaths.cvTurkish),
                      icon: Icons.download,
                      isOutlined:
                          !isTurkish, // Turkish outlined if English is active
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
    Locale locale,
  ) {
    // If Turkish, Turkish button is outlined; if English, English button is outlined
    final isTurkish = locale.languageCode == 'tr';
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
                      onPressed: () => _requestCoverLetter('EN'),
                      icon: Icons.email,
                      isOutlined:
                          isTurkish, // English outlined if Turkish is active
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () => _requestCoverLetter('TR'),
                      icon: Icons.email,
                      isOutlined:
                          !isTurkish, // Turkish outlined if English is active
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

    // For web, open the PDF in a new tab
    // Assets are served from /assets/ path in production
    final url = Uri.parse('/$assetPath');

    try {
      // Use externalApplication mode to force opening in new tab
      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        // Fallback: try with webOnlyWindowName
        await launchUrl(url, webOnlyWindowName: '_blank');
      }
    } catch (e) {
      // Ignore errors - file will open in new tab if available
      debugPrint('Error opening CV: $e');
    }
  }

  Future<void> _requestCoverLetter(String language) async {
    // Track cover letter request event
    AnalyticsService.logCVDownload('CL_REQUEST_$language');

    // Open email client with pre-filled subject and body
    final subject = language == 'EN'
        ? 'Cover Letter Request - English'
        : 'Ön Yazı Talebi - Türkçe';

    final body = language == 'EN'
        ? 'Hello,\n\nI would like to request your cover letter in English.\n\nThank you!'
        : 'Merhaba,\n\nÖn yazınızı Türkçe olarak talep etmek istiyorum.\n\nTeşekkürler!';

    final emailUrl = Uri(
      scheme: 'mailto',
      path: 'alialperenderici@gmail.com',
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      await launchUrl(emailUrl);
    } catch (e) {
      // Ignore errors - email client will open if available
    }
  }
}
