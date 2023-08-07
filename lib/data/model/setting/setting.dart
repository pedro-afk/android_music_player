import 'package:json_annotation/json_annotation.dart';
import 'package:music_player/data/model/color_theme/color_theme.dart';
part 'setting.g.dart';

@JsonSerializable()
class Setting {
  ColorTheme colorTheme;
  Setting({required this.colorTheme});

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);
  Map<String, dynamic> toJson() => _$SettingToJson(this);
}
