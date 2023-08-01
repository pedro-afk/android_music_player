String formatAudioDuration(int duration) {
  Duration durationMilli = Duration(milliseconds: duration);
  int minutes = durationMilli.inMinutes;
  int seconds = durationMilli.inSeconds.remainder(60);

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');
  return "$minutesStr:$secondsStr";
}
