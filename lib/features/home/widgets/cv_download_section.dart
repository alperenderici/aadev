import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:aad/core/constants/app_constants.dart';
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
                      onPressed: () => _requestCV('EN'),
                      icon: Icons.email,
                      isOutlined:
                          !isTurkish, // English outlined if English is active
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () => _requestCV('TR'),
                      icon: Icons.email,
                      isOutlined:
                          isTurkish, // Turkish outlined if Turkish is active
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
                          !isTurkish, // English outlined if English is active
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingM),
                  Expanded(
                    child: AppButton(
                      text: l10n.cvTurkish,
                      onPressed: () => _requestCoverLetter('TR'),
                      icon: Icons.email,
                      isOutlined:
                          isTurkish, // Turkish outlined if Turkish is active
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

  Future<void> _requestCV(String language) async {
    AnalyticsService.logCVDownload('CV_REQUEST_$language');

    final subject = language == 'EN'
        ? 'CV Request - English'
        : 'CV Talebi - Türkçe';

    final body = language == 'EN'
        ? 'Hello,\n\nI would like to request your CV in English.\n\nThank you!'
        : 'Merhaba,\n\nCV\'nizi Türkçe olarak talep etmek istiyorum.\n\nTeşekkürler!';

    await _sendRequestEmail(subject, body);
  }

  Future<void> _requestCoverLetter(String language) async {
    AnalyticsService.logCVDownload('CL_REQUEST_$language');

    final subject = language == 'EN'
        ? 'Cover Letter Request - English'
        : 'Ön Yazı Talebi - Türkçe';

    final body = language == 'EN'
        ? 'Hello,\n\nI would like to request your cover letter in English.\n\nThank you!'
        : 'Merhaba,\n\nÖn yazınızı Türkçe olarak talep etmek istiyorum.\n\nTeşekkürler!';

    await _sendRequestEmail(subject, body);
  }

  Future<void> _sendRequestEmail(String subject, String body) async {
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
