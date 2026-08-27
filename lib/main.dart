import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aad/core/theme/app_theme.dart';
import 'package:aad/core/l10n/app_localizations.dart';
import 'package:aad/core/providers/theme_provider.dart';
import 'package:aad/core/providers/locale_provider.dart';
import 'package:aad/core/services/analytics_service.dart';
import 'package:aad/features/home/pages/home_page.dart';
import 'package:aad/features/generative_art/pages/generative_art_page.dart';
import 'package:aad/features/film/data/film_rolls_data.dart';
import 'package:aad/features/film/pages/film_gallery_page.dart';
import 'package:aad/features/film/pages/film_roll_page.dart';
import 'package:aad/firebase_options.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Remove the # from URLs on web
  setPathUrlStrategy();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: 'Ali Alperen Derici',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode.toFlutterThemeMode(),

      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Firebase Analytics
      navigatorObservers: [AnalyticsService.observer],

      // Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SelectionArea(child: HomePage()),
        '/generative-art': (context) => const GenerativeArtPage(),
        '/35mm': (context) => const FilmGalleryPage(),
      },

      // `/35mm/<roll-id>` is generated per roll so each contact sheet has its
      // own shareable address; an unknown id falls back to the archive index.
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? '';
    if (!name.startsWith('/35mm/')) return null;

    final rollId = name.substring('/35mm/'.length);
    final roll = FilmRollsData.byId(rollId);

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (context) => roll == null
          ? const FilmGalleryPage()
          : FilmRollPage(roll: roll),
    );
  }
}
