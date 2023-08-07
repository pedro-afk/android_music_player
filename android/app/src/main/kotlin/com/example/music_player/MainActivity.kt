package com.example.music_player
import io.flutter.embedding.android.FlutterActivity
import android.database.Cursor
import android.media.MediaPlayer
import android.net.Uri
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.media.MediaMetadataRetriever
import android.util.Base64
import com.example.music_player.resources.ChannelMethod
import com.example.music_player.resources.Channels

// TODO: refatorar essa estrutura

class MainActivity : FlutterActivity() {
    private val channel = Channels.PLAYER_CHANNEL
    private lateinit var mediaPlayer: MediaPlayer

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, res ->
            when (call.method) {
                ChannelMethod.PLAY_SONG -> {
                    val play = playSong(
                        call.argument<String>("path") as String,
                        call.argument<Int>("msec") as Int
                    )
                    res.success(play)
                }
                ChannelMethod.PAUSE_SONG -> {
                    val pause = pauseSong()
                    res.success(pause)
                }
                ChannelMethod.READ_FILES_MEDIA_STORE -> {
                    val audios = readAudioFilesWithMediaStore()
                    res.success(audios)
                }
                ChannelMethod.GET_CURRENT_TRACK_POSITION -> {
                    val position = getCurrentTrackPosition()
                    res.success(position)
                }
                else -> res.notImplemented()
            }
        }
        super.configureFlutterEngine(flutterEngine)
    }

    private fun playSong(path: String, msec: Int): Boolean {
        mediaPlayer = MediaPlayer.create(context, Uri.parse(path))
        mediaPlayer.seekTo(msec)
        mediaPlayer.start()
        return mediaPlayer.isPlaying
    }

    private fun pauseSong(): Boolean {
        mediaPlayer.pause()
        return mediaPlayer.isPlaying
    }

    // TODO -> criar rotina para loop da música
    // fun setIsLooping() {}

    private fun getCurrentTrackPosition(): Int {
        var currentPosition = mediaPlayer.currentPosition
        return if (mediaPlayer.isPlaying && currentPosition < mediaPlayer.duration) {
            currentPosition = mediaPlayer.currentPosition
            currentPosition
        } else {
            0
        }
    }

    private fun readAudioFilesWithMediaStore(): MutableList<Map<String, Any>> {
        val audios = mutableListOf<Map<String, Any>>()
        val projection = arrayOf(
            MediaStore.Audio.Media._ID,
            MediaStore.Audio.Media.TITLE,
            MediaStore.Audio.Media.DURATION,
            MediaStore.Audio.Media.ARTIST,
            MediaStore.Audio.Media.DATA,
        )
        val selection = "${MediaStore.Audio.Media.DATA} LIKE '%.mp3%'"
        val cursor: Cursor = contentResolver.query(
            MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
            projection,
            selection,
            null,
            null
        ) ?: return mutableListOf()

        while (cursor.moveToNext()) {
            val id = cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media._ID))
            val name = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.TITLE))
            val duration =
                cursor.getLong(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DURATION))
            val artist =
                cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.ARTIST))
            val path = cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA))

            audios.add(
                mapOf(
                    "id" to id,
                    "title" to name,
                    "duration" to duration,
                    "artist" to artist,
                    "path" to path,
                    "albumArt" to (getAlbumArt(Uri.parse(path)) ?: "")
                )
            )
        }

        cursor.close()
        return audios
    }

    private fun getAlbumArt(songUri: Uri): String? {
        val retriever = MediaMetadataRetriever()
        var albumArt: ByteArray? = null

        try {
            retriever.setDataSource(context, songUri)
            albumArt = retriever.embeddedPicture
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            retriever.release()
        }

        return if (albumArt != null) {
            Base64.encodeToString(albumArt, 0)
        } else {
            null
        }
    }
}
