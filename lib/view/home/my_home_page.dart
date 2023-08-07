import 'package:flutter/material.dart';
import 'package:music_player/app/di.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/resources/app_strings.dart';
import 'package:music_player/resources/routes_manager.dart';
import 'package:music_player/resources/size_manager.dart';
import 'package:music_player/view/home/my_home_page_viewmodel.dart';
import 'package:music_player/view/widgets/audio_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyHomeViewModel viewModel = instance<MyHomeViewModel>();

  @override
  void initState() {
    viewModel.requestAccessDirectoryPermission();
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarHomeTitleSearch),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.settingsRoute),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: StreamBuilder<List<Audio>>(
        initialData: const [],
        stream: viewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                AppStrings.messageAudiosNotFound,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: AppPadding.p16),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => AudioTile(
                audio: snapshot.data![index],
                onTap: () {
                  viewModel.execute(snapshot.data![index]);
                  viewModel.setCurrentAudio = snapshot.data![index];
                },
              ),
            ),
          );
        },
      ),
      bottomSheet: StreamBuilder<Audio>(
        initialData: Audio.empty(),
        stream: viewModel.streamTrackPlaying,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(height: AppSize.s0);
          }

          if ((snapshot.data?.title ?? '').isEmpty) {
            return Container(height: AppSize.s0);
          }

          return BottomSheet(
            elevation: AppSize.s30,
            onClosing: () {},
            enableDrag: false,
            builder: (context) {
              return ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(
                  snapshot.data!.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  snapshot.data!.artist,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: snapshot.data!.isPlaying
                    ? IconButton(
                        onPressed: () => viewModel.execute(snapshot.data!),
                        icon: const Icon(Icons.pause),
                      )
                    : IconButton(
                        onPressed: () => viewModel.execute(snapshot.data!),
                        icon: const Icon(
                          Icons.play_arrow,
                        ),
                      ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.showSongRoute);
                },
              );
            },
          );
        },
      ),
    );
  }
}
