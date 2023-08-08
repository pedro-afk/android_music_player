# Music Player App

![App Demo](https://github.com/pedro-afk/android_music_player/tree/dev/assets/readme/player.gif)

This is a simple audio player designed to play .mp3 files from your device, allowing you to browse, play, pause, skip between tracks, and adjust the playback position.

## Technologies Used

- Flutter (UI)
- Dart
- Platform Channels
- Android Media APIs
- Kotlin (Native Android components)

## Technical Description

The application utilizes native Android APIs, including `MediaPlayer` and `MediaStore`, to manage audio playback. I've implemented various functions that are invoked through `MethodCall`, which communicates with the Dart programming layer via the platform channel.

## Features

- Scans and lists all .mp3 files present on the device.
- Play and pause audio playback.
- Automatically proceeds to the next track after one finishes.
- Navigate between tracks with ease.
- Adjust the playback position of the audio.
- Dark mode for improved nighttime usage.
- Customizable themes to suit your preferences.

## Getting Started

To run the app locally, follow these steps:

1. Clone this repository.
2. Make sure you have Flutter and Dart installed.
3. Open the project in your preferred IDE.
4. Run the app on your desired Android emulator or device.

## Future Enhancements

- Add support for other audio formats.
- Implement a playlist feature.
- Incorporate user accounts for personalized settings.
- Enhance the user interface for a more engaging experience.

Your contributions and suggestions are welcome! Feel free to fork this repository and create pull requests to help improve this app.

## Screenshots

Here are a few screenshots of the app:

<table>
  <tr>
    <td><img alt="Home Light Mode" src="https://github.com/pedro-afk/android_music_player/blob/dev/assets/readme/home_light_mode.png"/></td>
    <td><img alt="Home Dark Mode" src="https://github.com/pedro-afk/android_music_player/blob/dev/assets/readme/home_night_mode.png"/></td>
  </tr>
  <tr>
    <td><img alt="Settings Light Mode" src="https://github.com/pedro-afk/android_music_player/tree/dev/assets/readme/settings_light_mode.png"/></td>
    <td><img alt="Settings Dark Mode" src="https://github.com/pedro-afk/android_music_player/tree/dev/assets/readme/settings_night_mode.png"/></td>
  </tr>  
  <tr>
    <td><img alt="Player Light Mode" src="https://github.com/pedro-afk/android_music_player/tree/dev/assets/readme/player_light_mode.png"/></td>
    <td><img alt="Player Dark Mode" src="https://github.com/pedro-afk/android_music_player/tree/dev/assets/readme/player_night_mode.png"/></td>
  </tr>
</table>