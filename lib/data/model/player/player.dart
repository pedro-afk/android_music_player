class Player {
  int duration;
  int currentTime;
  bool isPlaying;

  Player({
    required this.duration,
    required this.currentTime,
    required this.isPlaying,
  });

  factory Player.empty() {
    return Player(
      duration: 0,
      currentTime: 0,
      isPlaying: false,
    );
  }
}
