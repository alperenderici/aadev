import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/constants/asset_paths.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';

/// About section widget
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          SectionTitle(title: l10n.aboutTitle),
          const SizedBox(height: AppConstants.spacingXXL),
          isMobile
              ? _buildMobileLayout(context, l10n, theme)
              : _buildDesktopLayout(context, l10n, theme),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      children: [
        _buildImages(context),
        const SizedBox(height: AppConstants.spacingXL),
        _buildContent(context, l10n, theme),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildContent(context, l10n, theme)),
        const SizedBox(width: AppConstants.spacingXXL),
        Expanded(flex: 1, child: _buildImages(context)),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              l10n.aboutDescription,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: 18,
              ),
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppConstants.spacingXXL),
        _buildHighlights(context, theme)
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 200.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildHighlights(BuildContext context, ThemeData theme) {
    final highlights = [
      {
        'icon': Icons.rocket_launch,
        'title': 'Entrepreneurial Mindset',
        'description':
            'Co-founded Fitgo health-tech startup, leading product development from concept to production.',
      },
      {
        'icon': Icons.code,
        'title': 'Full-Stack Development',
        'description':
            'Expert in Flutter, React, Node.js. Building scalable cross-platform apps with clean architecture.',
      },
      {
        'icon': Icons.lightbulb,
        'title': 'Problem Solver',
        'description':
            'Solving complex technical challenges and delivering innovative solutions with real business value.',
      },
      {
        'icon': Icons.people,
        'title': 'Project Leadership',
        'description':
            'Leading development teams, managing projects from ideation to deployment, mentoring developers.',
      },
      {
        'icon': Icons.hub,
        'title': 'Startup Ecosystem',
        'description':
            'Active in tech community through GDG events, hackathons. Embracing AI-enhanced workflows.',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Impact-Driven',
        'description':
            'Building products that matter. From health-tech to e-commerce, improving user experiences.',
      },
    ];

    return Wrap(
      spacing: AppConstants.spacingL,
      runSpacing: AppConstants.spacingL,
      children: highlights.map((highlight) {
        return Container(
          width: Responsive.isMobile(context)
              ? double.infinity
              : (MediaQuery.of(context).size.width -
                        AppConstants.spacingXXXL * 2 -
                        AppConstants.spacingL) /
                    2,
          padding: const EdgeInsets.all(AppConstants.spacingM),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppConstants.radiusL),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.spacingS),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Icon(
                  highlight['icon'] as IconData,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      highlight['title'] as String,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingXS),
                    Text(
                      highlight['description'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildImages(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
              child: Image.asset(
                AssetPaths.fitgoProfessional,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    child: const Icon(Icons.image, size: 100),
                  );
                },
              ),
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation)
            .scale(duration: AppConstants.mediumAnimation),
      ],
    );
  }
}
