import 'package:drift/drift.dart';
import 'package:music_player/data/database/database.dart';
import 'package:music_player/data/model/audio/audio.dart';

class AudioDatabaseProvider {
  final Database _database;

  AudioDatabaseProvider(this._database);

  Future<void> saveAudio(Audio audio) async {
    _database.into(_database.audioDrift).insertOnConflictUpdate(
          AudioDriftCompanion.insert(
            id: Value(audio.id),
            title: audio.title,
            duration: audio.duration,
            artist: audio.artist,
            path: audio.path,
            albumArt: audio.albumArt,
          ),
        );
  }

  Future<List<Audio>> getAllAudios() async {
    final audios = await _database.select(_database.audioDrift).get();
    return audios
        .map((e) => Audio(
            id: e.id,
            title: e.title,
            duration: e.duration,
            artist: e.artist,
            path: e.path,
            albumArt: e.albumArt))
        .toList();
  }
}
