import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  bool get _isDarkMode => isDarkMode;

  void themeMode(bool _isDarkMode) {
    isDarkMode = _isDarkMode;
    print('inside provider $isDarkMode');
    notifyListeners();
  }
}
