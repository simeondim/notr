import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  ThemeData getThemeData() {
    const theme = _DarkColorTheme();
    final colorScheme = theme.getColorScheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: colorScheme.primary,
          onPrimary: colorScheme.background,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
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
  final onPrimary = const Color(0x00003259);
  final background = const Color(0xFF1B1B1B);

  @override
  final mode = ThemeMode.dark;

  @override
  ColorScheme getColorScheme() {
    return ColorScheme.dark(
      primary: primary,
      onPrimary: onPrimary,
      background: background,
    );
  }
}
