/// A single roll of 35mm film: the negatives, plus how and when they were made.
///
/// Frames live under `web/film/<id>/` and are served as static files, not as
/// Flutter assets, so adding a roll never touches `pubspec.yaml`:
///
/// ```
/// web/film/<id>/t/001.webp   thumbnail, long edge 640px
/// web/film/<id>/f/001.webp   full size, long edge 1800px
/// ```
class FilmRoll {
  /// Slug used in the URL: `/35mm/<id>`. Must match the folder under `web/film/`.
  final String id;

  /// Display name of the roll.
  final String title;

  /// Film stock, e.g. `Kodak Portra 400`.
  final String? filmStock;

  /// Camera body (and lens, if worth noting), e.g. `Canon AE-1 · 50mm f/1.8`.
  final String? camera;

  /// When the roll was shot. Free text so `2024` and `Mayıs 2024` both work.
  final String? shotOn;

  /// Lab that developed the roll.
  final String? developedAt;

  /// When the roll was developed.
  final String? developedOn;

  /// Where the negatives were scanned, if not the same lab.
  final String? scannedAt;

  /// Anything else worth remembering about the roll.
  final String? notes;

  /// How many frames are on disk, numbered `001` upward.
  final int frameCount;

  /// One character per frame: `l` landscape, `p` portrait. Drives tile shape.
  final String orientations;

  /// Sort weight; higher shows first on the index page.
  final int sortKey;

  /// Frame shown as the roll's cover on `/35mm`, 0-based.
  ///
  /// Defaults per roll to its most detailed frame rather than frame 001, which
  /// on a hand-loaded roll is often the half-exposed first pull. Change it to
  /// any frame number minus one.
  final int coverIndex;

  const FilmRoll({
    required this.id,
    required this.title,
    required this.frameCount,
    required this.orientations,
    this.filmStock,
    this.camera,
    this.shotOn,
    this.developedAt,
    this.developedOn,
    this.scannedAt,
    this.notes,
    this.sortKey = 0,
    this.coverIndex = 0,
  });

  /// Thumbnail URL for frame [index] (0-based).
  String thumbUrl(int index) => 'film/$id/t/${_frameNumber(index)}.webp';

  /// Full-size URL for frame [index] (0-based).
  String fullUrl(int index) => 'film/$id/f/${_frameNumber(index)}.webp';

  /// Thumbnail of the roll's cover frame.
  String get coverUrl => thumbUrl(coverIndex);

  /// Aspect ratio of frame [index], derived from [orientations].
  double aspectRatio(int index) => isLandscape(index) ? 3 / 2 : 2 / 3;

  bool isLandscape(int index) =>
      index < orientations.length && orientations[index] == 'l';

  /// True when nothing but the frames themselves is known about this roll.
  bool get hasMetadata =>
      filmStock != null ||
      camera != null ||
      shotOn != null ||
      developedAt != null ||
      developedOn != null ||
      scannedAt != null ||
      notes != null;

  String _frameNumber(int index) =>
      (index + 1).toString().padLeft(3, '0');
}
