import 'package:flutter/material.dart';
import 'package:music_player/resources/app_strings.dart';
import 'package:music_player/resources/size_manager.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarTitleSettingsPage),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: AppPadding.p16),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.equalizer),
            ),
          ],
        ),
      ),
    );
  }
}
