import 'package:flutter/material.dart';
import 'package:music_player/app/constant.dart';
import 'package:music_player/data/model/color_theme/color_theme.dart';
import 'package:music_player/resources/size_manager.dart';

ThemeData getApplicationTheme(ColorTheme theme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(theme.parseColor),
      brightness: theme.darkMode ? Brightness.dark : Brightness.light,
    ),
    fontFamily: Constants.fontFamily,
    sliderTheme: const SliderThemeData(
      trackHeight: AppSize.s2,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: AppSize.s6),
    ),
  );
}
