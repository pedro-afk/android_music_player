package com.example.music_player.channel

import com.example.music_player.model.Media
import com.example.music_player.model.Player
import com.example.music_player.resources.PlayerMethods
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class PlayerChannel(
    messenger: BinaryMessenger,
    name: String,
    private val media: Media,
    private val player: Player,
) : MethodChannel(messenger, name) {

    init {
        setMethodCallHandler { call, res ->
            when (call.method) {
                PlayerMethods.PLAY_SONG -> {
                    val play = player.playSong(
                        call.argument<String>("path") as String,
                        call.argument<Int>("msec") as Int
                    )
                    res.success(play)
                }

                PlayerMethods.PAUSE_SONG -> {
                    val pause = player.pauseSong()
                    res.success(pause)
                }

                PlayerMethods.READ_FILES_MEDIA_STORE -> {
                    val audios = media.readAudioFilesWithMediaStore()
                    res.success(audios)
                }

                PlayerMethods.GET_CURRENT_TRACK_POSITION -> {
                    val position = player.getCurrentTrackPosition()
                    res.success(position)
                }

                else -> res.notImplemented()
            }
        }

    }

}