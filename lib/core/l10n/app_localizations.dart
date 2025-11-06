import 'package:flutter/material.dart';

/// App localizations
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('tr', 'TR'),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Navigation
      'nav_home': 'Home',
      'nav_about': 'About',
      'nav_experience': 'Experience',
      'nav_certificates': 'Certificates',
      'nav_contact': 'Contact',

      // Hero Section
      'hero_greeting': 'Hi, I\'m',
      'hero_name': 'Ali Alperen Derici',
      'hero_title': 'Flutter Developer',
      'hero_subtitle':
          'Computer Engineering Graduate | Passionate about creating beautiful, performant mobile and web applications.',
      'hero_cta_contact': 'Get in Touch',
      'hero_cta_cv': 'Download CV',

      // About Section
      'about_title': 'About Me',
      'about_description':
          'I\'m a passionate Flutter developer with expertise in building cross-platform mobile and web applications. I love creating elegant solutions to complex problems and am always eager to learn new technologies.',
      'about_skills_title': 'Skills & Technologies',

      // Experience Section
      'experience_title': 'Experience & Projects',
      'experience_current': 'Current',
      'experience_view_project': 'View Project',
      'experience_view_code': 'View Code',
      'experience_technologies': 'Technologies',

      // Certificates Section
      'certificates_title': 'Certificates & Achievements',
      'certificates_view': 'View Certificate',

      // Social Links Section
      'social_title': 'Connect With Me',
      'social_subtitle': 'Find me on these platforms',

      // CV Download Section
      'cv_title': 'Download Documents',
      'cv_download': 'Download CV',
      'cv_cover_letter': 'Request Cover Letter',
      'cv_english': 'English',
      'cv_turkish': 'Turkish',

      // Contact Section
      'contact_title': 'Get In Touch',
      'contact_subtitle':
          'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision.',
      'contact_email': 'Email Me',
      'contact_form_name': 'Your Name',
      'contact_form_email': 'Your Email',
      'contact_form_message': 'Your Message',
      'contact_form_send': 'Send Message',
      'contact_success': 'Message sent successfully!',
      'contact_error': 'Failed to send message. Please try again.',

      // Footer
      'footer_copyright': '© 2025 Ali Alperen Derici. All rights reserved.',
      'footer_built_with': 'Built with Flutter & ❤️',

      // Theme
      'theme_light': 'Light Mode',
      'theme_dark': 'Dark Mode',
      'theme_system': 'System',

      // Language
      'language_english': 'English',
      'language_turkish': 'Türkçe',

      // Common
      'common_loading': 'Loading...',
      'common_error': 'An error occurred',
      'common_retry': 'Retry',
      'common_close': 'Close',
      'common_view_more': 'View More',
      'common_view_less': 'View Less',

      // Experiences
      'exp_upwork_title': 'Upwork',
      'exp_upwork_desc':
          'Developed several application MVPs. Such as Social Networking app, News & Politics, Lifestyle apps.',
      'exp_fitgo_title': 'Fitgo',
      'exp_fitgo_desc':
          'Developed a comprehensive fitness and wellness platform with features including workout tracking, nutrition planning, and social features.',
      'exp_kanguru_title': 'Kanguru',
      'exp_kanguru_desc': 'A child tracking mobile application for parents.',
      'exp_akilli_ekip_title': 'Akıllı Ekip',
      'exp_akilli_ekip_desc':
          'Developed the web platform for admins and managers.',
      'exp_boly_title': 'Flutter Dev. - Boly',
      'exp_boly_desc': 'A volunteer team project application.',
      'exp_hygge_title': 'Hygge - Web App',
      'exp_hygge_desc':
          'Web app for Hygge Skin Art. Includes admin panel and spin wheel feature.',
      'exp_biko_title': 'Product Development Solution',
      'exp_biko_desc': 'A product development solution for BİKO Mühendislik.',
      'exp_alper_bekat_title': 'Personal Website',
      'exp_alper_bekat_desc':
          'Personal information website for Alper Bekat with multi-language option.',
      'exp_gagas_title': 'Restaurant Loyalty App',
      'exp_gagas_desc':
          'Loyalty web application for Gaga\'s Hot Fried Chicken restaurant.',
      'exp_mrlt_title': 'Mrlt',
      'exp_mrlt_desc':
          'Web app for Arda Nural. Personal information, portfolio and gallery site.',
      'exp_mobilist_title': 'Jr. Flutter Dev. - Mobilist',
      'exp_mobilist_desc':
          'Full-time position at Mobilist. Mostly worked with Amber project. Also handled problem fixes on Turksat project.',
      'exp_appy_title': 'MVP Of An Application',
      'exp_appy_desc':
          'As an intern at Appy Ventures, developed minimum viable product with responsive design.',

      // Upwork Service
      'upwork_service_title': 'Freelance Services on Upwork',
      'upwork_service_desc':
          'I offer professional Flutter development services on Upwork. Specializing in building scalable, cross-platform app MVPs from Figma designs, ready to grow into production. Let\'s bring your app idea to life!',
      'upwork_service_cta': 'View My Service',

      // Events & Conferences
      'events_title': 'Events & Conferences',
      'events_subtitle': 'Community Engagement & Learning',
      'event_attendee': 'Attendee',
      'event_gdg_izmir_devfest': 'GDG Izmir DevFest',
      'event_wtm_izmir': 'Women Techmakers Izmir',
      'event_gdg_manisa_devfest': 'GDG Manisa DevFest',
      'event_dsc_galatasaray_flutter':
          'Google DSC Galatasaray Club Flutter Camp',
      'event_google_io_extended_izmir': 'Google I/O Extended Izmir',
      'event_fuckup_nights_izmir': 'Fuck Up Nights Izmir',
      'event_cloud_jam_a_thon': 'Cloud Jam a Thon',
      'event_hack_n_break': 'Hack\'N Break',
      'event_create_in_izmir': 'Create In Izmir Pitching Day',
    },
    'tr': {
      // Navigation
      'nav_home': 'Ana Sayfa',
      'nav_about': 'Hakkımda',
      'nav_experience': 'Deneyim',
      'nav_certificates': 'Sertifikalar',
      'nav_contact': 'İletişim',

      // Hero Section
      'hero_greeting': 'Merhaba, Ben',
      'hero_name': 'Ali Alperen Derici',
      'hero_title': 'Flutter Geliştirici',
      'hero_subtitle':
          'Bilgisayar Mühendisliği Mezunu | Güzel ve performanslı mobil ve web uygulamaları oluşturma konusunda tutkulu',
      'hero_cta_contact': 'İletişime Geç',
      'hero_cta_cv': 'CV İndir',

      // About Section
      'about_title': 'Hakkımda',
      'about_description':
          'Çapraz platform mobil ve web uygulamaları geliştirme konusunda uzman, tutkulu bir Flutter geliştiricisiyim. Karmaşık problemlere zarif çözümler üretmeyi seviyorum ve her zaman yeni teknolojiler öğrenmeye hevesliyim.',
      'about_skills_title': 'Yetenekler & Teknolojiler',

      // Experience Section
      'experience_title': 'Deneyim & Projeler',
      'experience_current': 'Güncel',
      'experience_view_project': 'Projeyi Görüntüle',
      'experience_view_code': 'Kodu Görüntüle',
      'experience_technologies': 'Teknolojiler',

      // Certificates Section
      'certificates_title': 'Sertifikalar & Başarılar',
      'certificates_view': 'Sertifikayı Görüntüle',

      // Social Links Section
      'social_title': 'Benimle İletişime Geçin',
      'social_subtitle': 'Beni bu platformlarda bulabilirsiniz',

      // CV Download Section
      'cv_title': 'Dokümanları İndir',
      'cv_download': 'CV İndir',
      'cv_cover_letter': 'Ön Yazı Talep Et',
      'cv_english': 'İngilizce',
      'cv_turkish': 'Türkçe',

      // Contact Section
      'contact_title': 'İletişime Geçin',
      'contact_subtitle':
          'Yeni projeler, yaratıcı fikirler veya vizyonunuzun bir parçası olma fırsatları hakkında konuşmaya her zaman açığım.',
      'contact_email': 'E-posta Gönder',
      'contact_form_name': 'Adınız',
      'contact_form_email': 'E-posta Adresiniz',
      'contact_form_message': 'Mesajınız',
      'contact_form_send': 'Mesaj Gönder',
      'contact_success': 'Mesaj başarıyla gönderildi!',
      'contact_error': 'Mesaj gönderilemedi. Lütfen tekrar deneyin.',

      // Footer
      'footer_copyright': '© 2025 Ali Alperen Derici. Tüm hakları saklıdır.',
      'footer_built_with': 'Flutter & ❤️ ile yapıldı',

      // Theme
      'theme_light': 'Açık Mod',
      'theme_dark': 'Koyu Mod',
      'theme_system': 'Sistem',

      // Language
      'language_english': 'English',
      'language_turkish': 'Türkçe',

      // Common
      'common_loading': 'Yükleniyor...',
      'common_error': 'Bir hata oluştu',
      'common_retry': 'Tekrar Dene',
      'common_close': 'Kapat',
      'common_view_more': 'Daha Fazla',
      'common_view_less': 'Daha Az',

      // Experiences
      'exp_upwork_title': 'Upwork',
      'exp_upwork_desc':
          'Birkaç uygulama MVP\'si geliştirdim. Sosyal Ağ uygulaması, Haber & Politika, Yaşam Tarzı uygulamaları gibi.',
      'exp_fitgo_title': 'Fitgo',
      'exp_fitgo_desc':
          'Antrenman takibi, beslenme planlaması ve sosyal özellikler içeren kapsamlı bir fitness ve wellness platformu geliştirdim.',
      'exp_kanguru_title': 'Kanguru',
      'exp_kanguru_desc': 'Ebeveynler için çocuk takip mobil uygulaması.',
      'exp_akilli_ekip_title': 'Akıllı Ekip',
      'exp_akilli_ekip_desc':
          'Yöneticiler ve adminler için web platformu geliştirdim.',
      'exp_boly_title': 'Flutter Dev. - Boly',
      'exp_boly_desc': 'Gönüllü ekip projesi uygulaması.',
      'exp_hygge_title': 'Hygge - Web Uygulaması',
      'exp_hygge_desc':
          'Hygge Skin Art için web uygulaması. Admin paneli ve çark çevirme özelliği içerir.',
      'exp_biko_title': 'Ürün Geliştirme Çözümü',
      'exp_biko_desc': 'BİKO Mühendislik için ürün geliştirme çözümü.',
      'exp_alper_bekat_title': 'Kişisel Web Sitesi',
      'exp_alper_bekat_desc':
          'Alper Bekat için çok dilli seçeneğe sahip kişisel bilgi web sitesi.',
      'exp_gagas_title': 'Restoran Sadakat Uygulaması',
      'exp_gagas_desc':
          'Gaga\'s Hot Fried Chicken restoranı için sadakat web uygulaması.',
      'exp_mrlt_title': 'Mrlt',
      'exp_mrlt_desc':
          'Arda Nural için web uygulaması. Kişisel bilgi, portföy ve galeri sitesi.',
      'exp_mobilist_title': 'Jr. Flutter Dev. - Mobilist',
      'exp_mobilist_desc':
          'Mobilist\'te tam zamanlı pozisyon. Çoğunlukla Amber projesi üzerinde çalıştım. Ayrıca Turksat projesinde sorun düzeltmeleri yaptım.',
      'exp_appy_title': 'Bir Uygulamanın MVP\'si',
      'exp_appy_desc':
          'Appy Ventures\'ta stajyer olarak, responsive tasarıma sahip minimum uygulanabilir ürün geliştirdim.',

      // Upwork Hizmeti
      'upwork_service_title': 'Upwork\'te Freelance Hizmetlerim',
      'upwork_service_desc':
          'Upwork\'te profesyonel Flutter geliştirme hizmetleri sunuyorum. Figma tasarımlarından üretime hazır, ölçeklenebilir cross-platform uygulama MVP\'leri oluşturma konusunda uzmanım. Uygulama fikrinizi hayata geçirelim!',
      'upwork_service_cta': 'Hizmetimi Görüntüle',

      // Etkinlikler & Konferanslar
      'events_title': 'Etkinlikler & Konferanslar',
      'events_subtitle': 'Topluluk Katılımı & Öğrenme',
      'event_attendee': 'Katılımcı',
      'event_gdg_izmir_devfest': 'GDG Izmir DevFest',
      'event_wtm_izmir': 'Women Techmakers Izmir',
      'event_gdg_manisa_devfest': 'GDG Manisa DevFest',
      'event_dsc_galatasaray_flutter':
          'Google DSC Galatasaray Kulübü Flutter Kampı',
      'event_google_io_extended_izmir': 'Google I/O Extended Izmir',
      'event_fuckup_nights_izmir': 'Fuck Up Nights Izmir',
      'event_cloud_jam_a_thon': 'Cloud Jam a Thon',
      'event_hack_n_break': 'Hack\'N Break',
      'event_create_in_izmir': 'Create In Izmir Pitching Day',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Convenience getters
  String get navHome => translate('nav_home');
  String get navAbout => translate('nav_about');
  String get navExperience => translate('nav_experience');
  String get navCertificates => translate('nav_certificates');
  String get navContact => translate('nav_contact');

  String get heroGreeting => translate('hero_greeting');
  String get heroName => translate('hero_name');
  String get heroTitle => translate('hero_title');
  String get heroSubtitle => translate('hero_subtitle');
  String get heroCtaContact => translate('hero_cta_contact');
  String get heroCtaCv => translate('hero_cta_cv');

  String get aboutTitle => translate('about_title');
  String get aboutDescription => translate('about_description');
  String get aboutSkillsTitle => translate('about_skills_title');

  String get experienceTitle => translate('experience_title');
  String get experienceCurrent => translate('experience_current');
  String get experienceViewProject => translate('experience_view_project');
  String get experienceViewCode => translate('experience_view_code');
  String get experienceTechnologies => translate('experience_technologies');

  String get certificatesTitle => translate('certificates_title');
  String get certificatesView => translate('certificates_view');

  String get socialTitle => translate('social_title');
  String get socialSubtitle => translate('social_subtitle');

  String get cvTitle => translate('cv_title');
  String get cvDownload => translate('cv_download');
  String get cvCoverLetter => translate('cv_cover_letter');
  String get cvEnglish => translate('cv_english');
  String get cvTurkish => translate('cv_turkish');

  String get contactTitle => translate('contact_title');
  String get contactSubtitle => translate('contact_subtitle');
  String get contactEmail => translate('contact_email');
  String get contactFormName => translate('contact_form_name');
  String get contactFormEmail => translate('contact_form_email');
  String get contactFormMessage => translate('contact_form_message');
  String get contactFormSend => translate('contact_form_send');
  String get contactSuccess => translate('contact_success');
  String get contactError => translate('contact_error');

  String get footerCopyright => translate('footer_copyright');
  String get footerBuiltWith => translate('footer_built_with');

  String get themeLight => translate('theme_light');
  String get themeDark => translate('theme_dark');
  String get themeSystem => translate('theme_system');

  String get languageEnglish => translate('language_english');
  String get languageTurkish => translate('language_turkish');

  String get commonLoading => translate('common_loading');
  String get commonError => translate('common_error');
  String get commonRetry => translate('common_retry');
  String get commonClose => translate('common_close');
  String get commonViewMore => translate('common_view_more');
  String get commonViewLess => translate('common_view_less');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
