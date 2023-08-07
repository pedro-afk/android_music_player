import 'package:flutter/material.dart';
import 'package:music_player/app/di.dart';
import 'package:music_player/data/model/setting/setting.dart';
import 'package:music_player/resources/app_strings.dart';
import 'package:music_player/view/settings/settings_viewmodel.dart';
import 'package:music_player/view/widgets/set_color_theme.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final SettingsViewModel viewModel = instance<SettingsViewModel>();

  @override
  void initState() {
    viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarTitleSettingsPage),
      ),
      body: StreamBuilder<Setting>(
          initialData: viewModel.setting,
          stream: viewModel.settingStream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text(AppStrings.titleListTileDarkMode),
                  trailing: Switch(
                    value: snapshot.data!.colorTheme.darkMode,
                    onChanged: viewModel.toggleSwitchDarkMode,
                  ),
                ),
                SetColorTheme(
                  colors: viewModel.colors,
                  colorSelected: snapshot.data!.colorTheme,
                  onSelect: viewModel.setColorTheme,
                ),
              ],
            );
          }),
    );
  }
}
