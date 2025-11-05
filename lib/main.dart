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
    final locale = ref.watch(localeNotifierProvider);

    return MaterialApp(
      title: 'Ali Alperen Derici - Flutter Developer',
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
      },
    );
  }
}
