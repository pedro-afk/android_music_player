package com.example.music_player.resources

abstract class ChannelMethod {
    companion object {
        const val PLAY_SONG: String = "playSong"
        const val PAUSE_SONG: String = "pauseSong"
        const val READ_FILES_MEDIA_STORE = "readFilesWithMediaStore"
        const val GET_CURRENT_TRACK_POSITION = "getCurrentTrackPosition"
    }
}