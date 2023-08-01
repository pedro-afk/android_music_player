import 'package:drift/drift.dart';

class AudioDrift extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  IntColumn get duration => integer()();
  TextColumn get artist => text()();
  TextColumn get path => text()();
  TextColumn get albumArt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
