import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:aad/shared/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

/// Contact section widget
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ResponsiveSection(
      child: Column(
        children: [
          SectionTitle(
            title: l10n.contactTitle,
            subtitle: l10n.contactSubtitle,
          ),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildContactButton(context, l10n, theme),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child:
            AppButton(
                  text: l10n.contactEmail,
                  onPressed: () => _sendEmail(),
                  icon: Icons.email,
                  width: double.infinity,
                )
                .animate()
                .fadeIn(duration: AppConstants.mediumAnimation)
                .scale(duration: AppConstants.mediumAnimation),
      ),
    );
  }

  Future<void> _sendEmail() async {
    // Track contact action
    AnalyticsService.logContactAction();

    final uri = Uri(
      scheme: 'mailto',
      path: AppConstants.email,
      query: 'subject=Contact from Portfolio Website',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
