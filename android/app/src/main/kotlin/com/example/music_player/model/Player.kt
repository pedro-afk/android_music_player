package com.example.music_player.model
import android.content.Context
import android.media.MediaPlayer
import android.net.Uri
class Player(
    private var mediaPlayer: MediaPlayer,
    private val context: Context
) {
    fun playSong(path: String, msec: Int): Boolean {
        mediaPlayer = MediaPlayer.create(context, Uri.parse(path))
        mediaPlayer.seekTo(msec)
        mediaPlayer.start()
        return mediaPlayer.isPlaying
    }

    fun pauseSong(): Boolean {
        mediaPlayer.pause()
        return mediaPlayer.isPlaying
    }

    // TODO -> criar rotina para loop da música
    // fun setIsLooping() {}

    fun getCurrentTrackPosition(): Int {
        var currentPosition = mediaPlayer.currentPosition
        return if (mediaPlayer.isPlaying && currentPosition < mediaPlayer.duration) {
            currentPosition = mediaPlayer.currentPosition
            currentPosition
        } else {
            0
        }
    }
}