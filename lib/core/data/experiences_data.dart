import 'package:aad/core/models/experience_model.dart';
import 'package:aad/core/constants/asset_paths.dart';

/// Experience data
class ExperiencesData {
  ExperiencesData._();

  static final List<ExperienceModel> experiences = [
    // 1. Opex Operation Management System - Current
    ExperienceModel(
      id: 'opex',
      titleKey: 'exp_opex_title',
      descriptionKey: 'exp_opex_desc',
      companyName: 'Opex',
      screenshot: AssetPaths.opexScreenshot,
      technologies: ['Flutter', 'GetX', 'Riverpod', 'MS SQL', 'RESTful API'],
      startDate: DateTime(2026, 1),
      isCurrent: true,
    ),

    // 2. Train One - Current
    ExperienceModel(
      id: 'fitgo',
      titleKey: 'exp_fitgo_title',
      descriptionKey: 'exp_fitgo_desc',
      companyName: 'Train One',
      screenshot: AssetPaths.fitgoScreenshot,
      technologies: [
        'Flutter (Riverpod + Hooks)',
        'Supabase',
        'Firebase',
        'Figma',
        'Domain-Driven Design (DDD)',
      ],
      startDate: DateTime(2025, 6),
      isCurrent: true,
    ),

    // 3. Upwork - Current
    ExperienceModel(
      id: 'upwork',
      titleKey: 'exp_upwork_title',
      descriptionKey: 'exp_upwork_desc',
      companyName: 'Upwork',
      technologies: [
        'Flutter (Riverpod + Hooks)',
        'AR',
        'Figma',
        'Localization',
      ],
      startDate: DateTime(2025, 6),
      isCurrent: true,
    ),

    // 4. Akıllı Konum Teknolojileri - Kanguru
    ExperienceModel(
      id: 'kanguru',
      titleKey: 'exp_kanguru_title',
      descriptionKey: 'exp_kanguru_desc',
      companyName: 'Akıllı Konum Teknolojileri',
      companyLogo: AssetPaths.kanguruLogoScreenshot,
      technologies: [
        'Flutter (Riverpod + Hooks)',
        'Supabase',
        'Firebase',
        'Figma',
        'Repository Pattern',
      ],
      startDate: DateTime(2023, 6),
      endDate: DateTime(2025, 6),
      isCurrent: false,
    ),

    // 5. Akıllı Konum Teknolojileri - Akıllı Ekip
    ExperienceModel(
      id: 'akilli_ekip',
      titleKey: 'exp_akilli_ekip_title',
      descriptionKey: 'exp_akilli_ekip_desc',
      companyName: 'Akıllı Konum Teknolojileri',
      companyLogo: AssetPaths.akilliekipLogoScreenshot,
      technologies: [
        'Flutter (Riverpod + Hooks)',
        'Supabase',
        'Firebase',
        'Figma',
        'Repository Pattern',
      ],
      startDate: DateTime(2023, 6),
      endDate: DateTime(2025, 6),
      isCurrent: false,
    ),
    // 6. Boly - Flutter Dev.
    ExperienceModel(
      id: 'boly',
      titleKey: 'exp_boly_title',
      descriptionKey: 'exp_boly_desc',
      companyName: 'Boly',
      companyLogo: AssetPaths.bolyLogoScreenshot,
      technologies: ['Flutter (Mobx + bloc)'],
      startDate: DateTime(2022, 1),
      endDate: DateTime(2022, 12),
      isCurrent: false,
    ),

    // 6. Hygge - Web App
    ExperienceModel(
      id: 'hygge',
      titleKey: 'exp_hygge_title',
      descriptionKey: 'exp_hygge_desc',
      companyName: 'Hygge',
      screenshot: AssetPaths.hyggeScreenshot,
      technologies: ['React + Tailwind', 'Firebase'],
      startDate: DateTime(2022, 6),
      endDate: DateTime(2023, 1),
      isCurrent: false,
    ),

    // 7. Product Development Solution - BİKO Mühendislik
    ExperienceModel(
      id: 'biko',
      titleKey: 'exp_biko_title',
      descriptionKey: 'exp_biko_desc',
      companyName: 'BİKO Mühendislik',
      screenshot: AssetPaths.bikoScreenshot,
      technologies: [
        'Google Drive + API',
        'QR Generator',
        'React + Tailwind',
        'Firebase Authentication + Firestore DB',
      ],
      startDate: DateTime(2021, 3),
      endDate: DateTime(2021, 9),
      isCurrent: false,
    ),

    // 8. Personal Website - Alper Bekat
    ExperienceModel(
      id: 'alper_bekat',
      titleKey: 'exp_alper_bekat_title',
      descriptionKey: 'exp_alper_bekat_desc',
      companyName: 'Alper Bekat',
      screenshot: AssetPaths.alperBekatScreenshot,
      technologies: ['Bootstrap', 'HTML', 'CSS', 'JavaScript'],
      startDate: DateTime(2021, 6),
      endDate: DateTime(2021, 12),
      isCurrent: false,
    ),

    // 9. Restaurant Loyalty App - Gaga's Hot Fried Chicken
    ExperienceModel(
      id: 'gagas',
      titleKey: 'exp_gagas_title',
      descriptionKey: 'exp_gagas_desc',
      companyName: "Gaga's Hot Fried Chicken",
      screenshot: AssetPaths.gagasAppScreenshot,
      technologies: ['Flutter (MVVM + Riverpod)', 'Firebase'],
      startDate: DateTime(2021, 9),
      endDate: DateTime(2022, 6),
      isCurrent: false,
    ),

    // 10. Mrlt - Web App
    ExperienceModel(
      id: 'mrlt',
      titleKey: 'exp_mrlt_title',
      descriptionKey: 'exp_mrlt_desc',
      companyName: 'Arda Nural',
      screenshot: AssetPaths.personalSiteScreenshot,
      technologies: ['React + Tailwind'],
      startDate: DateTime(2021, 1),
      endDate: DateTime(2021, 6),
      isCurrent: false,
    ),

    // 11. Jr. Flutter Dev. - Mobilist
    ExperienceModel(
      id: 'mobilist',
      titleKey: 'exp_mobilist_title',
      descriptionKey: 'exp_mobilist_desc',
      companyName: 'Mobilist',
      screenshot: AssetPaths.mobilistScreenshot,
      technologies: [
        'Flutter (Riverpod, Freezed)',
        'Jira',
        'Confluence',
        'Figma',
      ],
      startDate: DateTime(2020, 6),
      endDate: DateTime(2021, 3),
      isCurrent: false,
    ),

    // 12. MVP Of An Application - Appy Ventures (Intern)
    ExperienceModel(
      id: 'appy_ventures',
      titleKey: 'exp_appy_title',
      descriptionKey: 'exp_appy_desc',
      companyName: 'Appy Ventures',
      screenshot: AssetPaths.appyVenturesScreenshot,
      technologies: ['Flutter', 'Figma'],
      startDate: DateTime(2020, 1),
      endDate: DateTime(2020, 6),
      isCurrent: false,
    ),
  ];
}
