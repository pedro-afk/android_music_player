import 'package:flutter/material.dart';
import 'package:music_player/resources/animation_manager.dart';
import 'package:music_player/view/home/my_home_page.dart';
import 'package:music_player/view/settings/settings_view.dart';
import 'package:music_player/view/song/song_page.dart';

class Routes {
  static const String mainRoute = '/';
  static const String showSongRoute = '/showSong';
  static const String settingsRoute = '/settings';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      case Routes.showSongRoute:
        return PageRouteBuilder(
          pageBuilder: (_, animation, secondaryAnimation) => const SongPage(),
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                AnimationManager().animationTransitionTween(),
              ),
              child: child,
            );
          },
          settings: routeSettings,
        );
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
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
