import 'package:aad/core/models/experience_model.dart';
import 'package:aad/core/constants/asset_paths.dart';

/// Experience data
class ExperiencesData {
  ExperiencesData._();

  static final List<ExperienceModel> experiences = [
    // 1. Opex - Current
    ExperienceModel(
      id: 'opex',
      titleKey: 'exp_opex_title',
      descriptionKey: 'exp_opex_desc',
      companyName: 'Opex Operation Management System',
      screenshot: AssetPaths.opexScreenshot,
      technologies: ['Flutter', 'GetX', 'MS SQL', 'RESTful API'],
      startDate: DateTime(2026, 1),
      isCurrent: true,
    ),

    // 2. Analog Buddy - Current
    ExperienceModel(
      id: 'analog_buddy',
      titleKey: 'exp_analog_buddy_title',
      descriptionKey: 'exp_analog_buddy_desc',
      companyName: 'Analog Buddy',
      screenshot: AssetPaths.analogBuddyLogo,
      technologies: ['Flutter'],
      startDate: DateTime(2026, 3),
      isCurrent: false,
      liveUrl: 'https://analogbuddy.com/',
    ),

    // 3. Rembetika
    ExperienceModel(
      id: 'rembetika',
      titleKey: 'exp_rembetika_title',
      descriptionKey: 'exp_rembetika_desc',
      companyName: 'Rembetika',
      screenshot: AssetPaths.rembetikaLogo,
      technologies: [
        'Flutter',
        'Riverpod',
        'GoRouter',
        'RevenueCat',
        'Firebase',
        'FFT',
      ],
      startDate: DateTime(2026, 4),
      isCurrent: false,
      liveUrl: 'https://rembetikaapp.com/',
    ),

    // 4. Caproll - Stopped
    ExperienceModel(
      id: 'caproll',
      titleKey: 'exp_caproll_title',
      descriptionKey: 'exp_caproll_desc',
      companyName: 'Caproll',
      screenshot: AssetPaths.caprollLogo,
      technologies: [
        'Flutter',
        'Riverpod',
        'Supabase',
        'Firebase',
        'TypeScript',
        'Edge Functions',
      ],
      liveUrl: 'https://caproll.app/',
      startDate: DateTime(2026, 4),
      endDate: DateTime(2026, 5),
      isStopped: true,
      isCurrent: false,
    ),

    // 6. Train One - Current
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

    // 7. WellNow / Geo Spor - Current
    ExperienceModel(
      id: 'wellnow',
      titleKey: 'exp_wellnow_title',
      descriptionKey: 'exp_wellnow_desc',
      companyName: 'Geo Spor',
      screenshot: AssetPaths.wellnowScreenshot,
      additionalScreenshot: AssetPaths.partyWizardScreenshot,
      technologies: [
        'Flutter',
        'Riverpod',
        'Firebase',
        'Supabase',
        'TypeScript',
      ],
      liveUrl: 'https://geosportsgroup.com',
      isCurrent: true,
    ),

    // 8. Upwork
    ExperienceModel(
      id: 'upwork',
      titleKey: 'exp_upwork_title',
      descriptionKey: 'exp_upwork_desc',
      companyName: 'Upwork',
      screenshot: AssetPaths.upworkLogoScreenshot,
      technologies: [
        'Flutter (Riverpod + Hooks)',
        'AR',
        'Figma',
        'Localization',
      ],
      startDate: DateTime(2025, 6),
      endDate: DateTime(2025, 12, 31),
      isCurrent: false,
    ),

    // 9. Akıllı Konum Teknolojileri - Kanguru
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

    // 10. Akıllı Konum Teknolojileri - Akıllı Ekip
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

    // 11. Boly - Flutter Dev.
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

    // 12. Hygge - Web App
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

    // 13. Product Development Solution - BİKO Mühendislik
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

    // 14. Personal Website - Alper Bekat
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

    // 15. Restaurant Loyalty App - Gaga's Hot Fried Chicken
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

    // 16. Mrlt - Web App
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

    // 17. Jr. Flutter Dev. - Mobilist
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

    // 18. MVP Of An Application - Appy Ventures (Intern)
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
