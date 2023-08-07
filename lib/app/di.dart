import 'package:get_it/get_it.dart';
import 'package:music_player/app/app_preferences.dart';
import 'package:music_player/data/channel/audio_channel.dart';
import 'package:music_player/view/home/my_home_page_viewmodel.dart';
import 'package:music_player/view/settings/settings_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  await preferencesModule();
  audioModule();
  homeModule();
  settingsModule();
}

Future<void> preferencesModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences));
}

void audioModule() {
  instance.registerLazySingleton<AudioChannel>(() => AudioChannel());
}

void homeModule() {
  if (!GetIt.I.isRegistered<MyHomeViewModel>()) {
    instance.registerSingleton(MyHomeViewModel(instance()));
  }
}

void settingsModule() {
  if (!GetIt.I.isRegistered<SettingsViewModel>()) {
    instance.registerSingleton(SettingsViewModel(instance()));
  }
}
