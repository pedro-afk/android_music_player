import 'package:flutter/material.dart';
import 'package:music_player/app/di.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/data/model/player/player.dart';
import 'package:music_player/view/home/my_home_page_viewmodel.dart';
import 'package:music_player/view/widgets/audio_info.dart';
import 'package:music_player/view/widgets/player.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final MyHomeViewModel viewModel = instance<MyHomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<Audio>(
            initialData: viewModel.currentAudio,
            stream: viewModel.streamTrackPlaying,
            builder: (context, snapshot) {
              return AudioInfo(audio: snapshot.data!);
            },
          ),
          StreamBuilder<Player>(
            initialData: viewModel.currentAudio,
            stream: viewModel.streamPlayer,
            builder: (context, snapshot) {
              return PlayerView(
                player: snapshot.data!,
                onExecute: () => viewModel.togglePlayAndPauseCurrentAudio(),
                onNext: () => viewModel.nextAudio(),
                onPrevious: () => viewModel.previousAudio(),
                onChanged: (value) =>
                    viewModel.setPositionAudioTime = value.toInt(),
                onChangeEnd: (value) => viewModel.playOnNewAudioTimePosition(),
                onChangeStart: (value) => viewModel.stopTimer(),
              );
            },
          ),
        ],
      ),
    );
  }
}
