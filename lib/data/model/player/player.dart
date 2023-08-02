class Player {
  int duration;
  int currentTime;
  bool isPlaying;

  Player({
    this.duration = 0,
    this.currentTime = 0,
    this.isPlaying = false,
  });

  String formatAudioTime({bool isCurrentTime = false}) {
    Duration durationMilli = Duration(
      milliseconds: isCurrentTime ? currentTime : duration,
    );
    int minutes = durationMilli.inMinutes;
    int seconds = durationMilli.inSeconds.remainder(60);

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr";
  }
}
