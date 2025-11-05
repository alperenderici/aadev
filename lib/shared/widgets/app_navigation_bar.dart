import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/providers/theme_provider.dart';
import 'package:aad/core/providers/locale_provider.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// App navigation bar
class AppNavigationBar extends ConsumerStatefulWidget {
  final Function(String)? onNavigate;

  const AppNavigationBar({super.key, this.onNavigate});

  @override
  ConsumerState<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends ConsumerState<AppNavigationBar> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(
            context: context,
            mobile: AppConstants.spacingL,
            tablet: AppConstants.spacingXL,
            desktop: AppConstants.spacingXXXL,
          ),
        ),
        child: Row(
          children: [
            // Logo/Name - Navigate to Generative Art Page
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/generative-art');
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'd_art',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            const Spacer(),

            // Navigation items (desktop/tablet)
            if (!isMobile) ...[
              _NavItem(
                text: l10n.navHome,
                onTap: () => widget.onNavigate?.call('home'),
              ),
              _NavItem(
                text: l10n.navAbout,
                onTap: () => widget.onNavigate?.call('about'),
              ),
              _NavItem(
                text: l10n.navExperience,
                onTap: () => widget.onNavigate?.call('experience'),
              ),
              _NavItem(
                text: l10n.navCertificates,
                onTap: () => widget.onNavigate?.call('certificates'),
              ),
              _NavItem(
                text: l10n.navContact,
                onTap: () => widget.onNavigate?.call('contact'),
              ),
              const SizedBox(width: AppConstants.spacingL),
            ],

            // Theme toggle
            IconButton(
              icon: Icon(
                ref.watch(themeModeProvider) == ThemeModeEnum.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
              onPressed: () {
                final currentTheme = ref.read(themeModeProvider);
                ref.read(themeModeProvider.notifier).toggle();
                final newTheme = currentTheme == ThemeModeEnum.dark
                    ? 'light'
                    : 'dark';
                AnalyticsService.logThemeChange(newTheme);
              },
              tooltip: l10n.themeLight,
            ),

            // Language toggle
            IconButton(
              icon: const Icon(FontAwesomeIcons.language),
              onPressed: () {
                ref.read(localeNotifierProvider.notifier).toggle();
                final currentLocale = ref
                    .read(localeNotifierProvider)
                    .languageCode;
                final newLanguage = currentLocale == 'en' ? 'tr' : 'en';
                AnalyticsService.logLanguageChange(newLanguage);
              },
              tooltip: ref.watch(localeNotifierProvider).languageCode == 'en'
                  ? l10n.languageTurkish
                  : l10n.languageEnglish,
            ),

            // Mobile menu
            if (isMobile) ...[
              const SizedBox(width: AppConstants.spacingS),
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _showMobileMenu(context),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.navHome),
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate?.call('home');
              },
            ),
            ListTile(
              title: Text(l10n.navAbout),
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate?.call('about');
              },
            ),
            ListTile(
              title: Text(l10n.navExperience),
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate?.call('experience');
              },
            ),
            ListTile(
              title: Text(l10n.navCertificates),
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate?.call('certificates');
              },
            ),
            ListTile(
              title: Text(l10n.navContact),
              onTap: () {
                Navigator.pop(context);
                widget.onNavigate?.call('contact');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavItem({required this.text, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
                  color: _isHovered
                      ? theme.colorScheme.primary
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: AppConstants.shortAnimation,
                height: 2,
                width: _isHovered ? 40 : 0,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
