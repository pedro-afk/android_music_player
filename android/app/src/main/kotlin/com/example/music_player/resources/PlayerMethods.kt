package com.example.music_player.resources

abstract class PlayerMethods {
    companion object {
        const val PLAY_SONG: String = "playSong"
        const val PAUSE_SONG: String = "pauseSong"
        const val READ_FILES_MEDIA_STORE = "readFilesWithMediaStore"
        const val GET_CURRENT_TRACK_POSITION = "getCurrentTrackPosition"
        const val CALL_EQUALIZER = "openEqualizer"
    }
}