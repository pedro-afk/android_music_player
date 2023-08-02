import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_player/resources/size_manager.dart';
import 'package:music_player/data/model/player/player.dart';

class PlayerView extends StatelessWidget {
  final Player player;
  final void Function()? onNext;
  final void Function()? onPrevious;
  final void Function()? onExecute;
  final void Function(double)? onChangeEnd;
  final void Function(double)? onChanged;
  final void Function(double)? onChangeStart;

  const PlayerView({
    super.key,
    required this.player,
    required this.onNext,
    required this.onPrevious,
    required this.onExecute,
    required this.onChangeEnd,
    required this.onChanged,
    required this.onChangeStart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSize.s16,
          child: Slider(
            value: player.currentTime.toDouble(),
            min: 0.0,
            max: player.duration.toDouble(),
            onChanged: onChanged,
            onChangeEnd: onChangeEnd,
            onChangeStart: onChangeStart,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(player.formatAudioTime(isCurrentTime: true),
                  style: Theme.of(context).textTheme.bodySmall),
              Text(player.formatAudioTime(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPrevious,
              iconSize: AppSize.s28,
              icon: const Icon(Icons.skip_previous_rounded),
            ),
            player.isPlaying
                ? IconButton(
                    onPressed: onExecute,
                    iconSize: AppSize.s72,
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.pause_circle_filled_rounded),
                  )
                : IconButton(
                    onPressed: onExecute,
                    iconSize: AppSize.s72,
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.play_circle_fill_rounded),
                  ),
            IconButton(
              onPressed: onNext,
              iconSize: AppSize.s28,
              icon: const Icon(Icons.skip_next_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
