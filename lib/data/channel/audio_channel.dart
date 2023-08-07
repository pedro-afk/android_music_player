import 'package:flutter/services.dart';
import 'package:music_player/app/constant.dart';
import 'package:music_player/resources/channel_method.dart';

class AudioChannel {
  MethodChannel channel = const MethodChannel(Constants.channelName);

  Future play(String path, int msec) async {
    return await channel
        .invokeMethod(ChannelMethod.playSong, {"path": path, "msec": msec});
  }

  Future pause() async {
    return await channel.invokeMethod(ChannelMethod.pauseSong);
  }

  Future getTrackTimerPosition() async {
    return await channel.invokeMethod(ChannelMethod.getCurrentTrackPosition);
  }

  Future fetchAllAudios() async {
    return await channel.invokeMethod(ChannelMethod.readFilesMediaStore);
  }

  // TODO: Adicionar chamada ao equalizador
}
