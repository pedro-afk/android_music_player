// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
      id: json['id'] as int,
      title: json['title'] as String,
      duration: json['duration'] as int,
      artist: json['artist'] as String,
      path: json['path'] as String,
      albumArt: json['albumArt'] as String,
    );

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'artist': instance.artist,
      'path': instance.path,
      'albumArt': instance.albumArt,
    };
