import 'package:firebase_analytics/firebase_analytics.dart';

/// Analytics service for tracking user interactions
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// Log page view
  static Future<void> logPageView(String pageName) async {
    await _analytics.logScreenView(
      screenName: pageName,
    );
  }

  /// Log button click
  static Future<void> logButtonClick(String buttonName) async {
    await _analytics.logEvent(
      name: 'button_click',
      parameters: {
        'button_name': buttonName,
      },
    );
  }

  /// Log navigation
  static Future<void> logNavigation(String destination) async {
    await _analytics.logEvent(
      name: 'navigation',
      parameters: {
        'destination': destination,
      },
    );
  }

  /// Log theme change
  static Future<void> logThemeChange(String theme) async {
    await _analytics.logEvent(
      name: 'theme_change',
      parameters: {
        'theme': theme,
      },
    );
  }

  /// Log language change
  static Future<void> logLanguageChange(String language) async {
    await _analytics.logEvent(
      name: 'language_change',
      parameters: {
        'language': language,
      },
    );
  }

  /// Log CV download
  static Future<void> logCVDownload(String type) async {
    await _analytics.logEvent(
      name: 'cv_download',
      parameters: {
        'type': type,
      },
    );
  }

  /// Log social link click
  static Future<void> logSocialLinkClick(String platform) async {
    await _analytics.logEvent(
      name: 'social_link_click',
      parameters: {
        'platform': platform,
      },
    );
  }

  /// Log project view
  static Future<void> logProjectView(String projectName) async {
    await _analytics.logEvent(
      name: 'project_view',
      parameters: {
        'project_name': projectName,
      },
    );
  }

  /// Log certificate view
  static Future<void> logCertificateView(int certificateIndex) async {
    await _analytics.logEvent(
      name: 'certificate_view',
      parameters: {
        'certificate_index': certificateIndex,
      },
    );
  }

  /// Log contact action
  static Future<void> logContactAction() async {
    await _analytics.logEvent(
      name: 'contact_action',
    );
  }

  /// Set user property
  static Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(
      name: name,
      value: value,
    );
  }
}

