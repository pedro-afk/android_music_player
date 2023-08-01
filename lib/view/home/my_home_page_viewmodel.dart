import 'dart:async';
import 'dart:convert';
import 'package:music_player/data/channel/audio_channel.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/data/model/player/player.dart';
import 'package:music_player/data/repository/audio_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomeViewModel {
  final AudioRepository _repository;
  final AudioChannel _channel;

  MyHomeViewModel(this._repository, this._channel);

  final List<Audio> _audios = [];
  final List<Audio> _tracksIn = [];

  final _audioController = StreamController<List<Audio>>();
  Stream<List<Audio>> get stream => _audioController.stream;

  final _trackPlayingController = StreamController<Audio>.broadcast();
  Stream<Audio> get streamTrackPlaying => _trackPlayingController.stream;

  final _playerController = StreamController<Player>.broadcast();
  Stream<Player> get streamPlayer => _playerController.stream;

  Timer? _timer;

  Audio audio = Audio.empty();
  Player player = Player.empty();

  Future<void> audioFiles() async {
    final audiosChannel = await _channel.fetchAllAudios();
    for (final audio in audiosChannel) {
      String encodeAudio = jsonEncode(audio);
      _audios.add(Audio.fromMap(jsonDecode(encodeAudio)));
    }
    _audioController.sink.add(_audios);
  }

  Future<void> execute() async {}

  Future<void> _playSong(Audio audio) async {
    var play = await _channel.play(audio.path, audio.duration);
    player.isPlaying = play;
    _playerController.sink.add(player);
    startTimer();
  }

  Future<void> _pauseSong(int index) async {
    stopTimer();
    var pause = await _channel.pause();
  }

  Future<void> nextTrack() async {
    int indexCurrentTrack = _audios.indexOf(audio);
    if (_audios[indexCurrentTrack] == _audios.last) return;
  }

  Future<void> previousTrack() async {
    int indexCurrentTrack = _audios.indexOf(audio);
    if (_audios[indexCurrentTrack] == _audios.first) return;
  }

  Future<void> requestAccessDirectoryPermission() async {
    var reqMedia = await Permission.mediaLibrary.request();
    var reqExternal = await Permission.storage.request();
    if (reqMedia.isGranted && reqExternal.isGranted) {
      await audioFiles();
    }
  }

  void startTimer() {
    _timer ??= Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        player.currentTime = await _channel.getTrackTimerPosition();
        _playerController.sink.add(player);
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void setAudio(Audio value) {
    audio = value;
    _definePlayer(
      Player(
        duration: value.duration,
        currentTime: 0,
        isPlaying: value.isPlaying,
      ),
    );
  }

  void _definePlayer(Player value) => player = value;

  void dispose() {
    stopTimer();
    _playerController.close();
    _audioController.close();
    _trackPlayingController.close();
    _tracksIn.clear();
  }
}
