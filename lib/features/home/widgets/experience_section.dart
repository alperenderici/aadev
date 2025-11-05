import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/data/experiences_data.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/models/experience_model.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';
import 'package:aad/shared/widgets/animated_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Experience section widget
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ResponsiveSection(
      child: Column(
        children: [
          SectionTitle(title: l10n.experienceTitle),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildExperienceList(context),
        ],
      ),
    );
  }

  Widget _buildExperienceList(BuildContext context) {
    final experiences = ExperiencesData.experiences;
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      // Mobile: Single column
      return Column(
        children: experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final experience = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingXL),
            child: _ExperienceCard(experience: experience, index: index),
          );
        }).toList(),
      );
    }

    // Desktop: 2 columns
    return Wrap(
      spacing: AppConstants.spacingL,
      runSpacing: AppConstants.spacingL,
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        return SizedBox(
          width:
              (MediaQuery.of(context).size.width -
                  AppConstants.spacingXXXL * 2 -
                  AppConstants.spacingL) /
              2,
          child: _ExperienceCard(experience: experience, index: index),
        );
      }).toList(),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;
  final int index;

  const _ExperienceCard({required this.experience, required this.index});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return AnimatedCard(
          child: isMobile
              ? _buildMobileLayout(context, l10n, theme)
              : _buildDesktopLayout(context, l10n, theme),
        )
        .animate()
        .fadeIn(
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: 100 * index),
        )
        .slideY(
          begin: 0.2,
          end: 0,
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: 100 * index),
        );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (experience.screenshot != null || experience.companyLogo != null)
          _buildImage(context),
        if (experience.screenshot != null || experience.companyLogo != null)
          const SizedBox(height: AppConstants.spacingL),
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
        if (experience.screenshot != null ||
            experience.companyLogo != null) ...[
          SizedBox(width: 200, child: _buildImage(context)),
          const SizedBox(width: AppConstants.spacingXL),
        ],
        Expanded(child: _buildContent(context, l10n, theme)),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final imagePath = experience.screenshot ?? experience.companyLogo;
    if (imagePath == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusM),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 150,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: const Icon(Icons.image, size: 50),
          );
        },
      ),
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
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.translate(experience.titleKey),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (experience.isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingM,
                  vertical: AppConstants.spacingS,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: Text(
                  l10n.experienceCurrent,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        if (experience.companyName != null) ...[
          const SizedBox(height: AppConstants.spacingS),
          Text(
            experience.companyName!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        if (experience.duration.isNotEmpty) ...[
          const SizedBox(height: AppConstants.spacingS),
          Text(
            experience.duration,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
        const SizedBox(height: AppConstants.spacingM),
        Text(
          l10n.translate(experience.descriptionKey),
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.6),
        ),
        const SizedBox(height: AppConstants.spacingL),
        Text(
          l10n.experienceTechnologies,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(height: AppConstants.spacingS),
        Wrap(
          spacing: AppConstants.spacingS,
          runSpacing: AppConstants.spacingS,
          children: experience.technologies.map((tech) {
            return Chip(
              label: Text(tech),
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              labelStyle: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingS,
              ),
            );
          }).toList(),
        ),
        if (experience.liveUrl != null || experience.githubUrl != null) ...[
          const SizedBox(height: AppConstants.spacingL),
          Wrap(
            spacing: AppConstants.spacingM,
            runSpacing: AppConstants.spacingM,
            children: [
              if (experience.liveUrl != null)
                TextButton.icon(
                  onPressed: () => _launchUrl(experience.liveUrl!),
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: Text(l10n.experienceViewProject),
                ),
              if (experience.githubUrl != null)
                TextButton.icon(
                  onPressed: () => _launchUrl(experience.githubUrl!),
                  icon: const Icon(Icons.code, size: 18),
                  label: Text(l10n.experienceViewCode),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
