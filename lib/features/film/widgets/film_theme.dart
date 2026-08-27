import 'package:flutter/material.dart';

/// Palette for the 35mm section.
///
/// The archive keeps its own darkroom colours rather than following the site
/// theme: scans are judged against a neutral dark ground, and a light surface
/// behind a negative fights the photograph.
class FilmTheme {
  FilmTheme._();

  static const Color background = Color(0xFF0B0B0C);
  static const Color surface = Color(0xFF141416);
  static const Color surfaceHigh = Color(0xFF1D1D20);
  static const Color border = Color(0xFF2A2A2E);

  /// Safelight amber, used sparingly for accents and active state.
  static const Color accent = Color(0xFFE0A458);

  static const Color textPrimary = Color(0xFFEDEDEF);
  static const Color textSecondary = Color(0xFF9A9AA2);
  static const Color textFaint = Color(0xFF6A6A72);

  static const String monoFamily = 'monospace';

  /// Uppercase monospace label used for metadata keys and counters.
  static const TextStyle label = TextStyle(
    fontFamily: monoFamily,
    fontSize: 11,
    height: 1.4,
    letterSpacing: 1.2,
    color: textFaint,
  );

  static const TextStyle value = TextStyle(
    fontSize: 14,
    height: 1.4,
    color: textPrimary,
  );

  static const TextStyle counter = TextStyle(
    fontFamily: monoFamily,
    fontSize: 12,
    letterSpacing: 1.0,
    color: textSecondary,
  );
}
