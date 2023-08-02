import 'package:flutter/material.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/resources/color_manager.dart';
import 'package:music_player/resources/font_manager.dart';
import 'package:music_player/resources/size_manager.dart';

class AudioTile extends StatelessWidget {
  final Audio audio;
  final void Function()? onTap;

  const AudioTile({
    Key? key,
    required this.audio,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        audio.title,
        style: TextStyle(
          fontSize: FontSize.s16,
          fontWeight: FontWeight.w600,
          color: audio.isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).textTheme.titleMedium?.color,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Row(
        children: [
          Icon(
            Icons.graphic_eq,
            color: audio.isSelected
                ? Theme.of(context).colorScheme.primary
                : ColorManager.lightGrey,
            size: AppSize.s22,
          ),
          Text(
            audio.artist,
            style: const TextStyle(
              color: ColorManager.lightGrey,
            ),
          ),
        ],
      ),
      trailing: Text(
        audio.formatAudioTime(),
        style: Theme.of(context).textTheme.labelMedium,
      ),
      onTap: onTap,
    );
  }
}
