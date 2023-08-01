import 'package:flutter/material.dart';
import 'package:music_player/resources/routes_manager.dart';
import 'package:music_player/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.mainRoute,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      title: 'Potato Music Player',
    );
  }
}
