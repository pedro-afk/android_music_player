package com.example.music_player
import io.flutter.embedding.android.FlutterActivity
import android.media.MediaPlayer
import io.flutter.embedding.engine.FlutterEngine
import com.example.music_player.channel.PlayerChannel
import com.example.music_player.model.Media
import com.example.music_player.model.Player
import com.example.music_player.resources.Channels

class MainActivity : FlutterActivity() {
    private val channel = Channels.PLAYER_CHANNEL
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        val player = Player(MediaPlayer(), context)
        val media = Media(contentResolver, context)
        PlayerChannel(flutterEngine.dartExecutor.binaryMessenger, channel, media, player)
        super.configureFlutterEngine(flutterEngine)
    }
}
