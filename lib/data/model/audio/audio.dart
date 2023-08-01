import 'package:json_annotation/json_annotation.dart';
part 'audio.g.dart';

@JsonSerializable()
class Audio {
  int id;
  String title;
  int duration;
  String artist;
  String path;
  String albumArt;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isPlaying = false;

  Audio({
    required this.id,
    required this.title,
    required this.duration,
    required this.artist,
    required this.path,
    required this.albumArt,
  });

  factory Audio.fromMap(Map<String, dynamic> data) => _$AudioFromJson(data);
  Map<String, dynamic> toMap() => _$AudioToJson(this);

  factory Audio.empty() {
    return Audio(
      id: 0,
      title: '',
      duration: 0,
      artist: '',
      path: '',
      albumArt: '',
    );
  }
}
