import 'package:get_it/get_it.dart';
import 'package:music_player/data/channel/audio_channel.dart';
import 'package:music_player/view/home/my_home_page_viewmodel.dart';

final instance = GetIt.instance;

void initAppModule() {
  instance.registerLazySingleton<AudioChannel>(() => AudioChannel());

  if (!GetIt.I.isRegistered<MyHomeViewModel>()) {
    instance.registerSingleton(MyHomeViewModel(instance()));
  }
}
