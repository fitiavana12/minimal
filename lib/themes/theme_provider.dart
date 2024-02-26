import 'package:flutter/material.dart';
import 'package:minimal_music_player/themes/light_mode.dart';
import 'package:minimal_music_player/themes/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //initially, light mode
  ThemeData  _themeData = lightMode;

  //get theme
  ThemeData get themeData => _themeData;

  //is darkMode
  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    //Update Ui
    notifyListeners();
  }

  // toogle theme
  void toogleTheme(){
    if(_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }


}