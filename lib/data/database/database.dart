import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:music_player/app/constant.dart';
import 'package:music_player/data/drift/audio_drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
part 'database.g.dart';

@DriftDatabase(tables: [AudioDrift])
class Database extends _$Database {
  Database()
      : super(
          LazyDatabase(() async {
            final dbFolder = await getApplicationDocumentsDirectory();
            final file = File(path.join(dbFolder.path, 'db.sqlite'));
            return NativeDatabase.createInBackground(file);
          }),
        );

  @override
  int get schemaVersion => Constants.schemaVersion;
}
