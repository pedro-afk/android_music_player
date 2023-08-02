import 'dart:async';
import 'dart:convert';
import 'package:music_player/data/channel/audio_channel.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/data/model/player/player.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomeViewModel {
  final AudioChannel _channel;

  MyHomeViewModel(this._channel);

  final List<Audio> _audios = [];
  final List<Audio> _tracksIn = [];

  final _audioController = StreamController<List<Audio>>();
  Stream<List<Audio>> get stream => _audioController.stream;

  final _trackPlayingController = StreamController<Audio>.broadcast();
  Stream<Audio> get streamTrackPlaying => _trackPlayingController.stream;

  final _playerController = StreamController<Player>.broadcast();
  Stream<Player> get streamPlayer => _playerController.stream;

  Audio currentAudio = Audio.empty();
  Timer? _timer;

  Future<void> audioFiles() async {
    final audiosChannel = await _channel.fetchAllAudios();
    for (final audio in audiosChannel) {
      String encodeAudio = jsonEncode(audio);
      _audios.add(Audio.fromMap(jsonDecode(encodeAudio)));
    }
    _audioController.sink.add(_audios);
  }

  Future<void> execute(Audio audio) async {
    for (Audio e in _audios) {
      if (e.id == audio.id) {
        e.isSelected = true;
      } else {
        e.isSelected = false;
      }
    }

    if (_tracksIn.isNotEmpty) {
      Audio lastAudio = _tracksIn.last;
      if (audio.id != lastAudio.id) {
        await _pauseSong(lastAudio);
        lastAudio.currentTime = 0;
        lastAudio.isPlaying = false;
        lastAudio.isSelected = false;

        audio.isPlaying = await _playSong(audio);
        _trackPlayingController.sink.add(audio);
        _tracksIn.add(audio);
        _audioController.sink.add(_audios);
        return;
      }
      _tracksIn.add(audio);
      _audioController.sink.add(_audios);
    }

    if (audio.isPlaying) {
      audio.isPlaying = await _pauseSong(audio);
      _trackPlayingController.sink.add(audio);
    } else {
      audio.isPlaying = await _playSong(audio);
      _trackPlayingController.sink.add(audio);
    }

    _tracksIn.add(audio);
    _audioController.sink.add(_audios);
  }

  Future<void> togglePlayAndPauseCurrentAudio() async {
    if (currentAudio.isPlaying) {
      await _pauseSong(currentAudio);
    } else {
      await _playSong(currentAudio);
    }
  }

  Future<bool> _playSong(Audio audio) async {
    var play = await _channel.play(audio.path, audio.currentTime);
    audio.isPlaying = play;
    startTimer(audio);
    _playerController.sink.add(audio);
    setCurrentAudio = audio;
    return play;
  }

  Future<bool> _pauseSong(Audio audio) async {
    stopTimer();
    var pause = await _channel.pause();
    audio.isPlaying = pause;
    _playerController.sink.add(audio);
    setCurrentAudio = audio;
    return pause;
  }

  Future<void> nextAudio() async {
    if (currentAudio == _audios.last) return;
    int indexCurrentTrack = _audios.indexOf(currentAudio);
    Audio nextAudio = _audios[indexCurrentTrack + 1];
    setCurrentAudio = nextAudio;
    await execute(nextAudio);
  }

  Future<void> previousAudio() async {
    if (currentAudio == _audios.first) return;
    int indexCurrentTrack = _audios.indexOf(currentAudio);
    Audio previousAudio = _audios[indexCurrentTrack - 1];
    setCurrentAudio = previousAudio;
    await execute(previousAudio);
  }

  Future<void> requestAccessDirectoryPermission() async {
    var reqMedia = await Permission.mediaLibrary.request();
    var reqExternal = await Permission.storage.request();
    if (reqMedia.isGranted && reqExternal.isGranted) {
      await audioFiles();
    }
  }

  void startTimer(Audio audio) {
    _playerController.sink.add(audio);
    _timer ??= Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        audio.currentTime = await _channel.getTrackTimerPosition();
        if (audio.currentTime == audio.duration) {
          audio.isPlaying = false;
        }
        _playerController.sink.add(audio);
      },
    );
  }

  Future<void> playOnNewAudioTimePosition() async {
    await _channel.pause();
    if (currentAudio.isPlaying) {
      await _channel.play(currentAudio.path, currentAudio.currentTime);
      startTimer(currentAudio);
    }
    _playerController.sink.add(currentAudio);
  }

  set setCurrentAudio(Audio value) => currentAudio = value;

  set setPositionAudioTime(int value) {
    stopTimer();
    currentAudio.currentTime = value;
    _playerController.sink.add(currentAudio);
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    stopTimer();
    _playerController.close();
    _audioController.close();
    _trackPlayingController.close();
    _tracksIn.clear();
  }
}
