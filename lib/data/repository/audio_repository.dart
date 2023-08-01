import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/data/provider/database/audio_database_provider.dart';

class AudioRepository {
  final AudioDatabaseProvider _provider;
  AudioRepository(this._provider);

  Future<void> saveAudio(Audio audio) async {
    await _provider.saveAudio(audio);
  }

  Future<List<Audio>> getAllAudios() async {
    return await _provider.getAllAudios();
  }
}
