import 'package:flutter/material.dart';
import 'package:music_player/themes/dark_mode.dart';
import 'package:music_player/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, light mode
  ThemeData _themeData = lightMode;

  // get theme
  ThemeData get themeData => _themeData;

  //
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update UI
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
