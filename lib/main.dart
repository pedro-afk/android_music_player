import 'package:flutter/material.dart';
import 'package:music_player/app/di.dart';
import 'package:music_player/app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}
