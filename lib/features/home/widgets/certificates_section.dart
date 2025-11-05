import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:aad/core/constants/app_constants.dart';
import 'package:aad/core/models/certificate_model.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/utils/responsive.dart';
import 'package:aad/shared/widgets/section_title.dart';
import 'package:aad/shared/widgets/responsive_section.dart';

/// Certificates section widget
class CertificatesSection extends StatelessWidget {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return ResponsiveSection(
      backgroundColor: theme.colorScheme.surface,
      child: Column(
        children: [
          SectionTitle(title: l10n.certificatesTitle),
          const SizedBox(height: AppConstants.spacingXXL),
          _buildCertificatesGrid(context),
        ],
      ),
    );
  }

  Widget _buildCertificatesGrid(BuildContext context) {
    final crossAxisCount = Responsive.value(
      context: context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppConstants.spacingL,
        mainAxisSpacing: AppConstants.spacingL,
        childAspectRatio: 1.4,
      ),
      itemCount: Certificates.all.length,
      itemBuilder: (context, index) {
        return _CertificateCard(
          certificate: Certificates.all[index],
          index: index,
        );
      },
    );
  }
}

class _CertificateCard extends HookWidget {
  final CertificateModel certificate;
  final int index;

  const _CertificateCard({required this.certificate, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final isHovered = useState(false);

    return MouseRegion(
          onEnter: (_) => isHovered.value = true,
          onExit: (_) => isHovered.value = false,
          child: GestureDetector(
            onTap: () => _showCertificateDialog(context, certificate),
            child: AnimatedContainer(
              duration: AppConstants.shortAnimation,
              transform: isHovered.value
                  ? Matrix4.diagonal3Values(1.05, 1.05, 1.0)
                  : Matrix4.identity(),
              child: Card(
                elevation: isHovered.value ? 8 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusL),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      certificate.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          child: const Icon(Icons.image, size: 50),
                        );
                      },
                    ),
                    // Always show overlay with title
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: AppConstants.shortAnimation,
                        padding: EdgeInsets.all(
                          isHovered.value
                              ? AppConstants.spacingL
                              : AppConstants.spacingM,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.8),
                              Colors.black.withValues(alpha: 0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                        child: Text(
                          certificate.getTitle(locale.languageCode),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Hover effect - zoom icon
                    if (isHovered.value)
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(
                          child: Icon(
                            Icons.zoom_in,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
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
          delay: Duration(milliseconds: 100 * index),
        )
        .scale(
          duration: AppConstants.mediumAnimation,
          delay: Duration(milliseconds: 100 * index),
        );
  }

  void _showCertificateDialog(BuildContext context, CertificateModel cert) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            InteractiveViewer(
              child: Image.asset(cert.imagePath, fit: BoxFit.contain),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
