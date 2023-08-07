import 'dart:async';
import 'package:music_player/app/app_preferences.dart';
import 'package:music_player/app/constant.dart';
import 'package:music_player/data/model/color_theme/color_theme.dart';
import 'package:music_player/data/model/setting/setting.dart';

class SettingsViewModel {
  final _settingsController = StreamController<Setting>.broadcast();
  Stream<Setting> get settingStream => _settingsController.stream;

  final AppPreferences _appPreferences;
  Setting? setting;

  SettingsViewModel(this._appPreferences) {
    init();
  }

  Future<void> init() async {
    final settingsPref =
        await _appPreferences.getMap(Constants.prefThemeSettings);

    if (settingsPref.isNotEmpty) {
      setting = Setting.fromJson(settingsPref);
    }

    if (setting == null) {
      setting = Setting(
        colorTheme: ColorTheme(colors[0].color, darkMode: false),
      );
      await setUpSettings();
      return;
    }

    setUpSettings();
  }

  Future<void> setUpSettings() async {
    _settingsController.sink.add(setting!);
    await saveSettingsPrefs();
  }

  Future<void> saveSettingsPrefs() async {
    await _appPreferences.saveMap(
        Constants.prefThemeSettings, setting?.toJson() ?? {});
  }

  void bind() {}

  void toggleSwitchDarkMode(bool value) {
    setting?.colorTheme.darkMode = value;
    setUpSettings();
  }

  void setColorTheme(ColorTheme value) {
    setting?.colorTheme.color = value.color;
    setUpSettings();
  }

  List<ColorTheme> colors = [
    ColorTheme("0xFF5722FF"),
    ColorTheme("0xFFFF5722"),
    ColorTheme("0xFF00BCD4"),
    ColorTheme("0xFF3F51B5"),
    ColorTheme("0xFF009688"),
    ColorTheme("0xFF2196F3"),
    ColorTheme("0xFF795548"),
    ColorTheme("0xFFFFEA00"),
  ];
}
