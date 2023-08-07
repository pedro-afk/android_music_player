import 'package:flutter/material.dart';
import 'package:music_player/app/di.dart';
import 'package:music_player/data/model/setting/setting.dart';
import 'package:music_player/resources/routes_manager.dart';
import 'package:music_player/resources/theme_manager.dart';
import 'package:music_player/view/settings/settings_viewmodel.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = instance<SettingsViewModel>();
    return StreamBuilder<Setting>(
      initialData: viewModel.setting,
      stream: viewModel.settingStream,
      builder: (context, snapshot) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.mainRoute,
          debugShowCheckedModeBanner: false,
          theme: getApplicationTheme(snapshot.data!.colorTheme),
        );
      },
    );
  }
}
