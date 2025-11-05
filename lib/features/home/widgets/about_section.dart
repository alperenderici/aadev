import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/constants/asset_paths.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:aad/shared/widgets/animated_card.dart';
import 'package:url_launcher/url_launcher.dart';

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
        const SizedBox(height: AppConstants.spacingXL),
        Text(
              l10n.aboutSkillsTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 200.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppConstants.spacingL),
        _buildSkillsGrid(context)
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 300.ms)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppConstants.spacingXL),
        _buildUpworkService(context, l10n, theme)
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 400.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildUpworkService(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work, color: theme.colorScheme.primary, size: 28),
              const SizedBox(width: AppConstants.spacingM),
              Expanded(
                child: Text(
                  l10n.translate('upwork_service_title'),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            l10n.translate('upwork_service_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
          const SizedBox(height: AppConstants.spacingL),
          InkWell(
            onTap: () async {
              final url = Uri.parse(AppConstants.upworkServiceUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingL,
                vertical: AppConstants.spacingM,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.translate('upwork_service_cta'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingS),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context) {
    final theme = Theme.of(context);

    final skillCategories = [
      {
        'category': 'Languages & Frameworks',
        'skills': [
          'Dart/Flutter',
          'JavaScript/TypeScript',
          'React/Next.js',
          'Node.js',
          'Java/Kotlin',
          'Python',
          'C#',
        ],
      },
      {
        'category': 'Architecture & Patterns',
        'skills': [
          'Clean Architecture',
          'MVVM',
          'Repository Pattern',
          'Domain-Driven Design',
          'SOLID Principles',
          'Riverpod State Management',
        ],
      },
      {
        'category': 'DevOps & CI/CD',
        'skills': [
          'Git/GitHub',
          'GitHub Actions',
          'Codemagic',
          'Bitbucket Pipelines',
          'Fastlane',
          'Unit/Widget Testing',
          'Flutter DevTools',
        ],
      },
      {
        'category': 'Cloud & Backend',
        'skills': [
          'Firebase (Auth, Firestore, Functions)',
          'Supabase',
          'REST APIs',
          'WebSocket',
          'GraphQL',
          'Hive',
          'SQLite',
        ],
      },
      {
        'category': 'Platform Integration',
        'skills': [
          'Custom Android Plugins',
          'Native SDK Integration',
          'Payment SDKs',
          'Analytics (Meta, Adjust)',
          'RevenueCat',
          'Superwall',
          'Push Notifications',
        ],
      },
      {
        'category': 'AI-Enhanced Workflow',
        'skills': [
          'Augment Code',
          'GitHub Copilot',
          'Cursor IDE',
          'ChatGPT/OpenAI APIs',
          'Automated Test Generation',
        ],
      },
      {
        'category': 'Tools & Collaboration',
        'skills': [
          'VS Code',
          'Android Studio',
          'Xcode',
          'Figma',
          'Jira/Confluence',
          'Slack',
          'Postman',
          'Notion',
        ],
      },
      {
        'category': 'Methodologies',
        'skills': [
          'Agile/Scrum',
          'Test-Driven Development',
          'Code Review & Mentoring',
          'Feature-based Architecture',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillCategories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category['category'] as String,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingM),
              Wrap(
                spacing: AppConstants.spacingS,
                runSpacing: AppConstants.spacingS,
                children: (category['skills'] as List<String>).map((skill) {
                  return Chip(
                    label: Text(skill),
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    labelStyle: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingS,
                    ),
                  );
                }).toList(),
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
                    ).colorScheme.primary.withOpacity(0.1),
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
