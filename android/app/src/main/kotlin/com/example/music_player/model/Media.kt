package com.example.music_player.model

import android.content.ContentResolver
import android.content.Context
import android.database.Cursor
import android.media.MediaMetadataRetriever
import android.net.Uri
import android.provider.MediaStore
import android.util.Base64

class Media(
    private val contentResolver: ContentResolver,
    private val context: Context
) {
    fun readAudioFilesWithMediaStore(): MutableList<Map<String, Any>> {
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