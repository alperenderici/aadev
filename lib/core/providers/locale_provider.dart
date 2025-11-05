import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

/// Locale notifier
@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    // Default to English
    return const Locale('en', 'US');
  }

  /// Set locale
  void setLocale(Locale locale) {
    state = locale;
  }

  /// Set English
  void setEnglish() {
    state = const Locale('en', 'US');
  }

  /// Set Turkish
  void setTurkish() {
    state = const Locale('tr', 'TR');
  }

  /// Toggle between English and Turkish
  void toggle() {
    state = state.languageCode == 'en'
        ? const Locale('tr', 'TR')
        : const Locale('en', 'US');
  }
}

