import 'package:json_annotation/json_annotation.dart';
part 'color_theme.g.dart';

@JsonSerializable()
class ColorTheme {
  String color;
  bool darkMode;

  int get parseColor => int.parse(color);
  ColorTheme(this.color, {this.darkMode = false});

  factory ColorTheme.fromJson(Map<String, dynamic> json) =>
      _$ColorThemeFromJson(json);

  Map<String, dynamic> toJson() => _$ColorThemeToJson(this);
}
