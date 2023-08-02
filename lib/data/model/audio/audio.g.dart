// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
      id: json['id'] as int,
      title: json['title'] as String,
      artist: json['artist'] as String,
      path: json['path'] as String,
      albumArt: json['albumArt'] as String,
      currentTime: json['currentTime'] as int? ?? 0,
      duration: json['duration'] as int? ?? 0,
      isPlaying: json['isPlaying'] as bool? ?? false,
    );

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
      'duration': instance.duration,
      'currentTime': instance.currentTime,
      'isPlaying': instance.isPlaying,
      'id': instance.id,
      'title': instance.title,
      'artist': instance.artist,
      'path': instance.path,
      'albumArt': instance.albumArt,
    };
