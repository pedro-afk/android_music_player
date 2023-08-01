// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AudioDriftTable extends AudioDrift
    with TableInfo<$AudioDriftTable, AudioDriftData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AudioDriftTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumArtMeta =
      const VerificationMeta('albumArt');
  @override
  late final GeneratedColumn<String> albumArt = GeneratedColumn<String>(
      'album_art', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, duration, artist, path, albumArt];
  @override
  String get aliasedName => _alias ?? 'audio_drift';
  @override
  String get actualTableName => 'audio_drift';
  @override
  VerificationContext validateIntegrity(Insertable<AudioDriftData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('album_art')) {
      context.handle(_albumArtMeta,
          albumArt.isAcceptableOrUnknown(data['album_art']!, _albumArtMeta));
    } else if (isInserting) {
      context.missing(_albumArtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudioDriftData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AudioDriftData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      albumArt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_art'])!,
    );
  }

  @override
  $AudioDriftTable createAlias(String alias) {
    return $AudioDriftTable(attachedDatabase, alias);
  }
}

class AudioDriftData extends DataClass implements Insertable<AudioDriftData> {
  final int id;
  final String title;
  final int duration;
  final String artist;
  final String path;
  final String albumArt;
  const AudioDriftData(
      {required this.id,
      required this.title,
      required this.duration,
      required this.artist,
      required this.path,
      required this.albumArt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['duration'] = Variable<int>(duration);
    map['artist'] = Variable<String>(artist);
    map['path'] = Variable<String>(path);
    map['album_art'] = Variable<String>(albumArt);
    return map;
  }

  AudioDriftCompanion toCompanion(bool nullToAbsent) {
    return AudioDriftCompanion(
      id: Value(id),
      title: Value(title),
      duration: Value(duration),
      artist: Value(artist),
      path: Value(path),
      albumArt: Value(albumArt),
    );
  }

  factory AudioDriftData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AudioDriftData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      duration: serializer.fromJson<int>(json['duration']),
      artist: serializer.fromJson<String>(json['artist']),
      path: serializer.fromJson<String>(json['path']),
      albumArt: serializer.fromJson<String>(json['albumArt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'duration': serializer.toJson<int>(duration),
      'artist': serializer.toJson<String>(artist),
      'path': serializer.toJson<String>(path),
      'albumArt': serializer.toJson<String>(albumArt),
    };
  }

  AudioDriftData copyWith(
          {int? id,
          String? title,
          int? duration,
          String? artist,
          String? path,
          String? albumArt}) =>
      AudioDriftData(
        id: id ?? this.id,
        title: title ?? this.title,
        duration: duration ?? this.duration,
        artist: artist ?? this.artist,
        path: path ?? this.path,
        albumArt: albumArt ?? this.albumArt,
      );
  @override
  String toString() {
    return (StringBuffer('AudioDriftData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('duration: $duration, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('albumArt: $albumArt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, duration, artist, path, albumArt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AudioDriftData &&
          other.id == this.id &&
          other.title == this.title &&
          other.duration == this.duration &&
          other.artist == this.artist &&
          other.path == this.path &&
          other.albumArt == this.albumArt);
}

class AudioDriftCompanion extends UpdateCompanion<AudioDriftData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> duration;
  final Value<String> artist;
  final Value<String> path;
  final Value<String> albumArt;
  const AudioDriftCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.duration = const Value.absent(),
    this.artist = const Value.absent(),
    this.path = const Value.absent(),
    this.albumArt = const Value.absent(),
  });
  AudioDriftCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int duration,
    required String artist,
    required String path,
    required String albumArt,
  })  : title = Value(title),
        duration = Value(duration),
        artist = Value(artist),
        path = Value(path),
        albumArt = Value(albumArt);
  static Insertable<AudioDriftData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? duration,
    Expression<String>? artist,
    Expression<String>? path,
    Expression<String>? albumArt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (duration != null) 'duration': duration,
      if (artist != null) 'artist': artist,
      if (path != null) 'path': path,
      if (albumArt != null) 'album_art': albumArt,
    });
  }

  AudioDriftCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? duration,
      Value<String>? artist,
      Value<String>? path,
      Value<String>? albumArt}) {
    return AudioDriftCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      artist: artist ?? this.artist,
      path: path ?? this.path,
      albumArt: albumArt ?? this.albumArt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (albumArt.present) {
      map['album_art'] = Variable<String>(albumArt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AudioDriftCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('duration: $duration, ')
          ..write('artist: $artist, ')
          ..write('path: $path, ')
          ..write('albumArt: $albumArt')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $AudioDriftTable audioDrift = $AudioDriftTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [audioDrift];
}
