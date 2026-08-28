import 'package:aad/features/film/models/film_roll.dart';

/// The 35mm archive, one entry per roll of film.
///
/// Every field except [FilmRoll.id], [FilmRoll.title], [FilmRoll.frameCount]
/// and [FilmRoll.orientations] is optional — the roll page renders only what is
/// filled in, so a roll you have not catalogued yet still displays cleanly.
/// Entries pre-filled below were inferred from the scan folder names; the blanks
/// are waiting on details only you know (camera body, shoot date, lab, notes).
///
/// To add a roll:
///   1. Drop the frames in `web/film/<id>/f/NNN.webp` (long edge 1800px) and
///      `web/film/<id>/t/NNN.webp` (long edge 640px), numbered from `001`.
///   2. Add a [FilmRoll] here with that `id`, the frame count, and one
///      orientation character per frame (`l` landscape, `p` portrait).
///   3. Give it the highest [FilmRoll.sortKey] to put it at the top, and set
///      [FilmRoll.coverIndex] to the frame you want on the cover, minus one.
///
/// `tool/build_film_archive.sh` does steps 1 and 2 for a folder of JPEG scans.
class FilmRollsData {
  FilmRollsData._();

  /// Rolls newest-first, as shown on `/35mm`.
  static const List<FilmRoll> rolls = [
    FilmRoll(
      id: 'ektar-2025',
      title: 'Kodak Ektar · 2025',
      filmStock: 'Kodak Ektar 100',
      shotOn: '2025',
      frameCount: 9,
      orientations: 'lllllllll',
      sortKey: 950,
      coverIndex: 7,
      // kaynak klasör: ektar-2025
    ),
    FilmRoll(
      id: 'rulo-01',
      title: 'İsimsiz Rulo 1',
      shotOn: '2025',
      developedAt: 'Fotoğraf Fabrikası',
      developedOn: '2025-06-04',
      notes: 'İki ayrı tarama tek klasörde birleşti.',
      frameCount: 59,
      orientations: 'ppllplpplllllllllllpppppllpllpllllpllllllllllllllpllllllllp',
      sortKey: 940,
      coverIndex: 25,
      // kaynak klasör: fotograffabrikasi_2-adet-tarama_2025-06-04_1649
    ),
    FilmRoll(
      id: 'rulo-02',
      title: 'İsimsiz Rulo 2',
      developedAt: '1885 Film Lab Studio',
      frameCount: 28,
      orientations: 'pplplplllppppllpllpllplllllp',
      sortKey: 930,
      coverIndex: 23,
      // kaynak klasör: 1885filmlabstudio
    ),
    FilmRoll(
      id: 'kodak-400-fotograf-fabrikasi',
      title: 'Kodak 400 · Fotoğraf Fabrikası',
      filmStock: 'Kodak 400',
      developedAt: 'Fotoğraf Fabrikası',
      frameCount: 34,
      orientations: 'lllllllllplllpllllllllplppllllllpp',
      sortKey: 920,
      coverIndex: 24,
      // kaynak klasör: kodak400 fotograf fabrikasi
    ),
    FilmRoll(
      id: 'kodak-400',
      title: 'Kodak 400',
      filmStock: 'Kodak 400',
      frameCount: 9,
      orientations: 'llllplplp',
      sortKey: 910,
      // kaynak klasör: Kodak 400
    ),
    FilmRoll(
      id: 'rulo-03',
      title: 'İsimsiz Rulo 3',
      shotOn: '2024',
      frameCount: 26,
      orientations: 'lllllllplllllllllllllpppll',
      sortKey: 900,
      coverIndex: 1,
      // kaynak klasör: 2024-05-10_0916
    ),
    FilmRoll(
      id: 'rulo-04',
      title: 'İsimsiz Rulo 4',
      shotOn: '2024',
      frameCount: 22,
      orientations: 'lllllllllllpplpllpllll',
      sortKey: 890,
      coverIndex: 15,
      // kaynak klasör: 2024-05-10_1521
    ),
    FilmRoll(
      id: 'kodak-ektar-2022',
      title: 'Kodak Ektar · 2022',
      filmStock: 'Kodak Ektar 100',
      shotOn: '2022',
      frameCount: 16,
      orientations: 'pppppllllllppppp',
      sortKey: 820,
      coverIndex: 10,
      // kaynak klasör: Kodak Ektar2022
    ),
    FilmRoll(
      id: 'fomapan-400',
      title: 'Fomapan 400',
      filmStock: 'Fomapan 400',
      frameCount: 25,
      orientations: 'llpllpppllllplplllplllllp',
      sortKey: 810,
      coverIndex: 12,
      // kaynak klasör: Fomopan400
    ),
    FilmRoll(
      id: 'ilford-fp4-bayat',
      title: 'Ilford FP4 · Bayat',
      filmStock: 'Ilford FP4',
      notes: 'Tarihi geçmiş film.',
      frameCount: 21,
      orientations: 'lpllppplllllplllpllll',
      sortKey: 800,
      coverIndex: 1,
      // kaynak klasör: bayat-ilford fp4
    ),
    FilmRoll(
      id: 'fuji-100-bayat',
      title: 'Fujifilm 100 · Bayat',
      filmStock: 'Fujifilm 100 ASA',
      notes: 'Tarihi geçmiş film.',
      frameCount: 23,
      orientations: 'llpllllppppllllpllpplpp',
      sortKey: 790,
      coverIndex: 11,
      // kaynak klasör: fuji 100 asa -bayat
    ),
    FilmRoll(
      id: 'ektar-2020',
      title: 'Kodak Ektar · 2020',
      filmStock: 'Kodak Ektar 100',
      shotOn: '2020',
      frameCount: 33,
      orientations: 'llllllllllllllllllllllpllllplllpp',
      sortKey: 780,
      coverIndex: 8,
      // kaynak klasör: Ektar2020
    ),
    FilmRoll(
      id: 'tunc-foto-portra-400',
      title: 'Kodak Portra 400 · Tunç Foto',
      filmStock: 'Kodak Portra 400',
      developedAt: 'Tunç Foto',
      frameCount: 35,
      orientations: 'lllplpplpplpllllplllpllllllllllpppp',
      sortKey: 770,
      coverIndex: 31,
      // kaynak klasör: tuncfoto-kodakportra400
    ),
    FilmRoll(
      id: 'tunc-pan-400',
      title: 'Pan 400 · Tunç Foto',
      filmStock: 'Pan 400',
      developedAt: 'Tunç Foto',
      frameCount: 31,
      orientations: 'pllllpplllllllplplllplpllllllll',
      sortKey: 760,
      coverIndex: 10,
      // kaynak klasör: tunç-pan400
    ),
    FilmRoll(
      id: 'portra',
      title: 'Kodak Portra',
      filmStock: 'Kodak Portra',
      frameCount: 32,
      orientations: 'lpplpppppplllplllplppplllllllpll',
      sortKey: 750,
      coverIndex: 26,
      // kaynak klasör: portra
    ),
    FilmRoll(
      id: 'pan-400',
      title: 'Pan 400',
      filmStock: 'Pan 400',
      frameCount: 20,
      orientations: 'lllppllllpllplplllll',
      sortKey: 740,
      coverIndex: 19,
      // kaynak klasör: pan400
    ),
    FilmRoll(
      id: 'rulo-05',
      title: 'İsimsiz Rulo 5',
      frameCount: 59,
      orientations: 'plllllllppplppllllplpppllplllppplplplllllllllllllllllllllll',
      sortKey: 730,
      coverIndex: 23,
      // kaynak klasör: Pro foto
    ),
    FilmRoll(
      id: 'rulo-06',
      title: 'İsimsiz Rulo 6',
      camera: 'Ayça\'nın makinesi',
      frameCount: 38,
      orientations: 'llppllllllllllllpllllllllllllllllllllp',
      sortKey: 720,
      coverIndex: 11,
      // kaynak klasör: Ayçamak.
    ),
    FilmRoll(
      id: 'rulo-07',
      title: 'İsimsiz Rulo 7',
      camera: 'Yiğit\'in makinesi',
      frameCount: 18,
      orientations: 'lllllllpppllpllpll',
      sortKey: 710,
      coverIndex: 16,
      // kaynak klasör: Yiğitin makina
    ),
    FilmRoll(
      id: 'rulo-08',
      title: 'İsimsiz Rulo 8',
      frameCount: 24,
      orientations: 'ppplllllllllpplllllplpll',
      sortKey: 700,
      coverIndex: 6,
      // kaynak klasör: Fıss
    ),
    FilmRoll(
      id: 'rulo-09',
      title: 'İsimsiz Rulo 9',
      frameCount: 23,
      orientations: 'lllplllllllllllllppllpl',
      sortKey: 690,
      coverIndex: 10,
      // kaynak klasör: AA
    ),
    FilmRoll(
      id: 'rulo-10',
      title: 'İsimsiz Rulo 10',
      frameCount: 19,
      orientations: 'lllllllllllllllllll',
      sortKey: 680,
      coverIndex: 11,
      // kaynak klasör: drive
    ),
    FilmRoll(
      id: 'rulo-11',
      title: 'İsimsiz Rulo 11',
      frameCount: 31,
      orientations: 'lpllllllplllllllllplllllllllllp',
      sortKey: 670,
      coverIndex: 11,
      // kaynak klasör: wetransfer-ecef6d
    ),
    FilmRoll(
      id: 'rulo-12',
      title: 'İsimsiz Rulo 12',
      frameCount: 7,
      orientations: 'lllllll',
      sortKey: 660,
      // kaynak klasör: 0910
    ),
    FilmRoll(
      id: 'rulo-13',
      title: 'İsimsiz Rulo 13',
      frameCount: 27,
      orientations: 'lllllllllllllllllllllllllll',
      sortKey: 150,
      coverIndex: 3,
      // kaynak klasör: 1
    ),
    FilmRoll(
      id: 'rulo-14',
      title: 'İsimsiz Rulo 14',
      frameCount: 22,
      orientations: 'lllpllllllllllllllllll',
      sortKey: 140,
      coverIndex: 9,
      // kaynak klasör: 2
    ),
    FilmRoll(
      id: 'rulo-15',
      title: 'İsimsiz Rulo 15',
      frameCount: 29,
      orientations: 'lllplllllppllllpppplplpllllll',
      sortKey: 130,
      coverIndex: 18,
      // kaynak klasör: 3
    ),
    FilmRoll(
      id: 'rulo-16',
      title: 'İsimsiz Rulo 16',
      frameCount: 24,
      orientations: 'lllllllllllpllllllllplll',
      sortKey: 120,
      coverIndex: 18,
      // kaynak klasör: 4
    ),
    FilmRoll(
      id: 'rulo-17',
      title: 'İsimsiz Rulo 17',
      frameCount: 4,
      orientations: 'llll',
      sortKey: 110,
      coverIndex: 3,
      // kaynak klasör: 5
    ),
    FilmRoll(
      id: 'rulo-18',
      title: 'İsimsiz Rulo 18',
      frameCount: 23,
      orientations: 'lllllllllllllllllllllll',
      sortKey: 100,
      coverIndex: 3,
      // kaynak klasör: asdasd
    ),
  ];

  /// Total number of frames across every roll.
  static int get totalFrames =>
      rolls.fold(0, (sum, roll) => sum + roll.frameCount);

  /// The roll with the given [id], or null if there is no such roll.
  static FilmRoll? byId(String id) {
    for (final roll in rolls) {
      if (roll.id == id) return roll;
    }
    return null;
  }
}
