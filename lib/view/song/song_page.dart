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
            initialData: viewModel.audio,
            stream: viewModel.streamTrackPlaying,
            builder: (context, snapshot) {
              return AudioInfo(audio: snapshot.data!);
            },
          ),
          StreamBuilder<Player>(
            initialData: viewModel.player,
            stream: viewModel.streamPlayer,
            builder: (context, snapshot) {
              return PlayerView(
                player: snapshot.data!,
                onExecute: () => viewModel.execute(),
                onNext: () {},
                onPrevious: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
