import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const _DarkColorTheme().getColorScheme(),
    );
  }
}

abstract class _ColorScheme {
  ThemeMode get mode;
  ColorScheme getColorScheme();
}

class _DarkColorTheme implements _ColorScheme {
  const _DarkColorTheme();

  final primary = const Color(0xFF9BCAFF);
  final background = const Color(0xFF1B1B1B);

  @override
  final mode = ThemeMode.dark;

  @override
  ColorScheme getColorScheme() {
    return ColorScheme.dark(
      primary: primary,
      background: background,
    );
  }
}
