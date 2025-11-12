import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/models/social_link_model.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:url_launcher/url_launcher.dart';

/// Social links section widget
class SocialLinksSection extends StatelessWidget {
  const SocialLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ResponsiveSection(
      child: Column(
        children: [
          SectionTitle(title: l10n.socialTitle, subtitle: l10n.socialSubtitle),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildSocialLinks(context),
        ],
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      // Mobile: Wrap layout
      return Wrap(
        spacing: AppConstants.spacingL,
        runSpacing: AppConstants.spacingL,
        alignment: WrapAlignment.center,
        children: SocialLinks.all.asMap().entries.map((entry) {
          final index = entry.key;
          final link = entry.value;
          return _SocialLinkButton(link: link, index: index);
        }).toList(),
      );
    }

    // Desktop: 6+6 Grid Layout (2 rows, 6 columns each)
    final links = SocialLinks.all;
    final firstRow = links.take(6).toList();
    final secondRow = links.skip(6).take(6).toList();

    return Column(
      children: [
        // First row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: firstRow.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
              ),
              child: _SocialLinkButton(link: link, index: index),
            );
          }).toList(),
        ),
        const SizedBox(height: AppConstants.spacingL),
        // Second row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: secondRow.asMap().entries.map((entry) {
            final index = entry.key + 6; // Continue index from first row
            final link = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
              ),
              child: _SocialLinkButton(link: link, index: index),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SocialLinkButton extends HookWidget {
  final SocialLinkModel link;
  final int index;

  const _SocialLinkButton({required this.link, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = link.color ?? theme.colorScheme.primary;
    final isHovered = useState(false);

    return MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: GestureDetector(
            onTap: () => _launchUrl(link.url, link.name),
            child: AnimatedContainer(
              duration: AppConstants.shortAnimation,
              transform: isHovered.value
                  ? Matrix4.translationValues(0.0, -8.0, 0.0)
                  : Matrix4.identity(),
              child: Container(
                width: Responsive.value(
                  context: context,
                  mobile: 80,
                  tablet: 100,
                  desktop: 120,
                ),
                height: Responsive.value(
                  context: context,
                  mobile: 80,
                  tablet: 100,
                  desktop: 120,
                ),
                decoration: BoxDecoration(
                  color: isHovered.value
                      ? color.withValues(alpha: 0.1)
                      : theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                  border: Border.all(
                    color: isHovered.value ? color : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: isHovered.value
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      link.icon,
                      size: Responsive.value(
                        context: context,
                        mobile: 32,
                        tablet: 40,
                        desktop: 48,
                      ),
                      color: isHovered.value ? color : theme.iconTheme.color,
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    Text(
                      link.name,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isHovered.value ? color : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: 50 * index),
        )
        .scale(
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: 50 * index),
        );
  }

  Future<void> _launchUrl(String url, String linkName) async {
    // Track social link click
    AnalyticsService.logSocialLinkClick(linkName);

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
