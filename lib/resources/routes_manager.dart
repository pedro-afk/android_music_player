import 'package:flutter/material.dart';
import 'package:music_player/view/home/my_home_page.dart';
import 'package:music_player/view/song/song_page.dart';

class Routes {
  static const String mainRoute = '/';
  static const String showSongRoute = '/showSong';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case Routes.showSongRoute:
        return MaterialPageRoute(
          builder: (_) => const SongPage(),
          settings: routeSettings,
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Page not found'),
        ),
        body: const Text('Contact us \n potato.music@potato.com'),
      ),
    );
  }
}
