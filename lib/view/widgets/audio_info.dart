import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:music_player/data/model/audio/audio.dart';
import 'package:music_player/resources/color_manager.dart';
import 'package:music_player/resources/size_manager.dart';

class AudioInfo extends StatelessWidget {
  final Audio audio;

  const AudioInfo({
    Key? key,
    required this.audio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: audio.albumArt.isEmpty
              ? Container(
                  height: AppSize.s268,
                  width: AppSize.s268,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    color: Colors.grey.withOpacity(ColorOpacity.o0_3),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        ColorManager.lightGrey,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.music_note_outlined,
                    size: AppSize.s90,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  child: Image.memory(
                    Uint8List.fromList(
                      base64Decode(
                        audio.albumArt.replaceAll(RegExp(r'\s+'), ''),
                      ),
                    ),
                    fit: BoxFit.cover,
                    height: AppSize.s268,
                    width: AppSize.s268,
                  ),
                ),
        ),
        const SizedBox(height: AppSize.s30),
        Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p16,
            right: AppPadding.p16,
            top: AppPadding.p16,
          ),
          child: Text(
            audio.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppPadding.p16),
          child: Text(
            audio.artist,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: ColorManager.lightGrey),
          ),
        ),
      ],
    );
  }
}
