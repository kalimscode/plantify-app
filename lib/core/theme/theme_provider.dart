import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/providers.dart';
import '../storage/local_storage.dart';

final themeProvider =
StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final storage = ref.read(localStorageProvider);
  return ThemeNotifier(storage);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final LocalStorage storage;

  ThemeNotifier(this.storage) : super(ThemeMode.light) {
    _loadTheme();
  }

  static const _themeKey = "isDarkMode";

  Future<void> _loadTheme() async {
    final isDark = await storage.getBool(_themeKey) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    await storage.setBool(_themeKey, isDark);
  }
}