import 'package:aad/core/models/experience_model.dart';
import 'package:aad/core/constants/asset_paths.dart';

/// Experience data
class ExperiencesData {
  ExperiencesData._();

  static final List<ExperienceModel> experiences = [
    ExperienceModel(
      id: 'fitgo',
      titleKey: 'exp_fitgo_title',
      descriptionKey: 'exp_fitgo_desc',
      companyName: 'Fitgo',
      screenshot: AssetPaths.fitgoPresentation,
      technologies: [
        'Flutter',
        'Firebase',
        'Riverpod',
        'Google Maps',
        'REST API',
      ],
      startDate: DateTime(2023, 1),
      endDate: DateTime(2024, 6),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'hygge',
      titleKey: 'exp_hygge_title',
      descriptionKey: 'exp_hygge_desc',
      companyName: 'Hygge',
      screenshot: AssetPaths.hyggeScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'Provider',
        'REST API',
      ],
      startDate: DateTime(2022, 6),
      endDate: DateTime(2023, 1),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'gagas',
      titleKey: 'exp_gagas_title',
      descriptionKey: 'exp_gagas_desc',
      companyName: 'Gagas',
      screenshot: AssetPaths.gagasAppScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'GetX',
        'Google Maps',
      ],
      startDate: DateTime(2021, 9),
      endDate: DateTime(2022, 6),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'biko',
      titleKey: 'exp_biko_title',
      descriptionKey: 'exp_biko_desc',
      companyName: 'Biko',
      screenshot: AssetPaths.bikoScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'Provider',
      ],
      startDate: DateTime(2021, 3),
      endDate: DateTime(2021, 9),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'boly',
      titleKey: 'exp_boly_title',
      descriptionKey: 'exp_boly_desc',
      companyName: 'Boly',
      companyLogo: AssetPaths.bolyLogoScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'BLoC',
      ],
      startDate: DateTime(2020, 10),
      endDate: DateTime(2021, 3),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'kanguru',
      titleKey: 'exp_kanguru_title',
      descriptionKey: 'exp_kanguru_desc',
      companyName: 'Kanguru',
      companyLogo: AssetPaths.kanguruLogoScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'Provider',
      ],
      startDate: DateTime(2020, 6),
      endDate: DateTime(2020, 10),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'appy_ventures',
      titleKey: 'exp_appy_title',
      descriptionKey: 'exp_appy_desc',
      companyName: 'Appy Ventures',
      screenshot: AssetPaths.appyVenturesScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
        'Provider',
      ],
      startDate: DateTime(2020, 1),
      endDate: DateTime(2020, 6),
      isCurrent: false,
    ),
    ExperienceModel(
      id: 'alper_bekat',
      titleKey: 'exp_alper_bekat_title',
      descriptionKey: 'exp_alper_bekat_desc',
      companyName: 'Alper Bekat',
      screenshot: AssetPaths.alperBekatScreenshot,
      technologies: [
        'Flutter',
        'Firebase',
      ],
      startDate: DateTime(2019, 9),
      endDate: DateTime(2020, 1),
      isCurrent: false,
    ),
  ];
}

