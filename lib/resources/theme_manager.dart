import 'package:flutter/material.dart';
import 'package:music_player/app/constant.dart';
import 'package:music_player/resources/size_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
    fontFamily: Constants.fontFamily,
    sliderTheme: const SliderThemeData(
      trackHeight: AppSize.s2,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: AppSize.s6),
    ),
  );
}
