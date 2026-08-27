import 'package:flutter/material.dart';
import 'package:aad/features/film/widgets/film_theme.dart';

/// A scan loaded from `web/film/`, fading in once it decodes.
///
/// Frames are static files served next to `index.html` rather than bundled
/// Flutter assets, so they load over the network and arrive one at a time —
/// the fade keeps a contact sheet from popping as it fills in.
class FilmImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  /// Shown while the bytes are still in flight.
  final Color placeholderColor;

  const FilmImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.placeholderColor = FilmTheme.surfaceHigh,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      filterQuality: FilterQuality.medium,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return Stack(
          fit: StackFit.expand,
          children: [
            _placeholder(),
            AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOut,
              child: child,
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) => ColoredBox(
        color: placeholderColor,
        child: const Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: FilmTheme.textFaint,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _placeholder() => ColoredBox(color: placeholderColor);
}
