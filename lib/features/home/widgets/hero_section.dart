import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/constants/asset_paths.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/app_button.dart';

/// Hero section widget
class HeroSection extends StatelessWidget {
  final VoidCallback? onContactPressed;
  final VoidCallback? onCVPressed;

  const HeroSection({super.key, this.onContactPressed, this.onCVPressed});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Responsive.value(
          context: context,
          mobile: 500,
          tablet: 600,
          desktop: 700,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context: context,
            mobile: AppConstants.spacingL,
            tablet: AppConstants.spacingXXL,
            desktop: AppConstants.spacingXXXL,
          ),
          vertical: AppConstants.spacingXXXL,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.maxContentWidth(context),
            ),
            child: isMobile
                ? _buildMobileLayout(context, l10n, theme)
                : _buildDesktopLayout(context, l10n, theme),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context, 150),
        const SizedBox(height: AppConstants.spacingXL),
        _buildTextContent(
          context,
          l10n,
          theme,
          TextAlign.center,
          isMobile: true,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildTextContent(context, l10n, theme, TextAlign.left),
        ),
        const SizedBox(width: AppConstants.spacingXXXL),
        Expanded(
          flex: 2,
          child: Center(child: _buildProfileImage(context, 300)),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, double size) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              AssetPaths.profilePhoto,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ),
        )
        .animate()
        .fadeIn(duration: AppConstants.mediumAnimation)
        .scale(duration: AppConstants.longAnimation, curve: Curves.easeOutBack);
  }

  Widget _buildTextContent(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    TextAlign textAlign, {
    bool isMobile = false,
  }) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
              l10n.heroGreeting,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 100.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: AppConstants.spacingS),
        Text(
              l10n.heroName,
              style: Responsive.value(
                context: context,
                mobile: theme.textTheme.displaySmall,
                tablet: theme.textTheme.displayMedium,
                desktop: theme.textTheme.displayLarge,
              )?.copyWith(fontWeight: FontWeight.bold),
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 200.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: AppConstants.spacingM),
        Text(
              l10n.heroTitle,
              style:
                  Responsive.value(
                    context: context,
                    mobile: theme.textTheme.headlineSmall,
                    tablet: theme.textTheme.headlineMedium,
                    desktop: theme.textTheme.headlineLarge,
                  )?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 300.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: AppConstants.spacingL),
        Text(
              l10n.heroSubtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.textTheme.bodySmall?.color,
              ),
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 400.ms)
            .slideX(begin: -0.2, end: 0),
        const SizedBox(height: AppConstants.spacingXXL),
        _buildButtons(context, l10n, textAlign == TextAlign.center)
            .animate()
            .fadeIn(duration: AppConstants.mediumAnimation, delay: 500.ms)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildButtons(
    BuildContext context,
    AppLocalizations l10n,
    bool isColumn,
  ) {
    final contactButton = AppButton(
      text: l10n.heroCtaContact,
      onPressed: onContactPressed,
      icon: Icons.email,
    );

    final cvButton = AppButton(
      text: l10n.heroCtaCv,
      onPressed: onCVPressed,
      isOutlined: true,
      icon: Icons.download,
    );

    return isColumn
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              contactButton,
              const SizedBox(height: AppConstants.spacingM),
              cvButton,
            ],
          )
        : Row(
            children: [
              contactButton,
              const SizedBox(width: AppConstants.spacingM),
              cvButton,
            ],
          );
  }
}
