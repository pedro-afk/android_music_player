import 'package:get_it/get_it.dart';
import 'package:music_player/data/channel/audio_channel.dart';
import 'package:music_player/data/database/database.dart';
import 'package:music_player/data/provider/database/audio_database_provider.dart';
import 'package:music_player/data/repository/audio_repository.dart';
import 'package:music_player/view/home/my_home_page_viewmodel.dart';

final instance = GetIt.instance;

void initAppModule() {
  final database = Database();
  instance.registerLazySingleton<AudioDatabaseProvider>(
      () => AudioDatabaseProvider(database));
  instance.registerLazySingleton<AudioRepository>(
      () => AudioRepository(instance()));
  instance.registerLazySingleton<AudioChannel>(() => AudioChannel());

  if (!GetIt.I.isRegistered<MyHomeViewModel>()) {
    instance.registerSingleton(MyHomeViewModel(instance(), instance()));
  }
}
