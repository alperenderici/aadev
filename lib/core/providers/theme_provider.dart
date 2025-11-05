import 'package:flutter/material.dart' as material;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Theme mode notifier
@riverpod
class ThemeMode extends _$ThemeMode {
  @override
  ThemeModeEnum build() {
    // Default to system theme
    return ThemeModeEnum.system;
  }

  /// Toggle between light and dark theme
  void toggle() {
    state = state == ThemeModeEnum.light
        ? ThemeModeEnum.dark
        : ThemeModeEnum.light;
  }

  /// Set theme mode
  void setThemeMode(ThemeModeEnum mode) {
    state = mode;
  }

  /// Set light theme
  void setLight() {
    state = ThemeModeEnum.light;
  }

  /// Set dark theme
  void setDark() {
    state = ThemeModeEnum.dark;
  }

  /// Set system theme
  void setSystem() {
    state = ThemeModeEnum.system;
  }
}

/// Theme mode enum
enum ThemeModeEnum {
  light,
  dark,
  system;

  /// Convert to Flutter ThemeMode
  material.ThemeMode toFlutterThemeMode() {
    switch (this) {
      case ThemeModeEnum.light:
        return material.ThemeMode.light;
      case ThemeModeEnum.dark:
        return material.ThemeMode.dark;
      case ThemeModeEnum.system:
        return material.ThemeMode.system;
    }
  }
}
