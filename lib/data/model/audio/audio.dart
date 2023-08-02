import 'package:json_annotation/json_annotation.dart';
import 'package:music_player/data/model/player/player.dart';
part 'audio.g.dart';

@JsonSerializable()
class Audio extends Player {
  int id;
  String title;
  String artist;
  String path;
  String albumArt;
  @JsonKey(includeToJson: false, includeFromJson: false)
  bool isSelected;

  Audio({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.albumArt,
    this.isSelected = false,
    super.currentTime = 0,
    super.duration = 0,
    super.isPlaying = false,
  });

  factory Audio.fromMap(Map<String, dynamic> data) => _$AudioFromJson(data);
  Map<String, dynamic> toMap() => _$AudioToJson(this);

  factory Audio.empty() {
    return Audio(
      id: 0,
      title: '',
      artist: '',
      path: '',
      albumArt: '',
    );
  }
}
