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
  Stream<List<Audio>> get streamAudio => _audioController.stream;

  final _trackPlayingController = StreamController<Audio>.broadcast();
  Stream<Audio> get streamTrackPlaying => _trackPlayingController.stream;

  final _playerController = StreamController<Player>.broadcast();
  Stream<Player> get streamPlayer => _playerController.stream;

  Audio currentAudio = Audio.empty();
  int indexCurrentAudio = 0;
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
    _trackPlayingController.sink.add(audio);
    indexCurrentAudio = _audios.indexOf(audio);
    if (_tracksIn.isNotEmpty) {
      Audio lastAudio = _tracksIn.last;
      if (audio.id != lastAudio.id) {
        await _pauseSong(indexCurrentAudio);
        resetLastAudio(lastAudio);
        audio.isPlaying = await _playSong(indexCurrentAudio);
        _tracksIn.add(audio);
        _audioController.sink.add(_audios);
        return;
      }
      _tracksIn.add(audio);
      _audioController.sink.add(_audios);
    }
    await togglePlayAndPauseCurrentAudio();
    _tracksIn.add(audio);
    _audioController.sink.add(_audios);
  }

  void resetLastAudio(Audio lastAudio) {
    lastAudio.currentTime = 0;
    lastAudio.isPlaying = false;
    lastAudio.isSelected = false;
  }

  Future<void> togglePlayAndPauseCurrentAudio() async {
    if (currentAudio.isPlaying) {
      await _pauseSong(indexCurrentAudio);
    } else {
      await _playSong(indexCurrentAudio);
    }
  }

  Future<bool> _playSong(int index) async {
    var play = await _channel.play(
      _audios[index].path,
      _audios[index].currentTime,
    );
    _audios[index].isPlaying = play;
    startTimer(_audios[index]);
    setCurrentAudio = _audios[index];
    _playerController.sink.add(_audios[index]);
    _audioController.sink.add(_audios);
    return play;
  }

  Future<bool> _pauseSong(int index) async {
    stopTimer();
    var pause = await _channel.pause();
    _audios[index].isPlaying = pause;
    setCurrentAudio = _audios[index];
    _playerController.sink.add(_audios[index]);
    _audioController.sink.add(_audios);
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
    await Permission.storage.request();
    await Permission.mediaLibrary.request();

    var statusPermissionMedia = await Permission.mediaLibrary.status;
    var statusPermissionStorage = await Permission.storage.status;

    if (statusPermissionMedia.isGranted && statusPermissionStorage.isGranted) {
      await audioFiles();
      return;
    }

    if (statusPermissionMedia.isPermanentlyDenied ||
        statusPermissionStorage.isPermanentlyDenied) {
      openAppSettings();
    }
    _audioController.sink.add([]);
  }

  void startTimer(Audio audio) {
    _playerController.sink.add(audio);
    _timer ??= Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) async {
        audio.currentTime = await _channel.getTrackTimerPosition();
        if (audio.currentTime == 0 && audio.duration == currentAudio.duration) {
          if (audio == _audios.last) {
            await _pauseSong(indexCurrentAudio);
          } else {
            await nextAudio();
          }
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
