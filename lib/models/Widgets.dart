import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

Widget buildSettin() {
  return SettingsList(
    sections: [
      SettingsSection(

        tiles: <SettingsTile>[
          SettingsTile.navigation(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            value: const Text('English'),
          ),
          SettingsTile.switchTile(
            onToggle: (value) {},
            initialValue: true,
            leading: const Icon(Icons.format_paint),
            title: const Text('Enable custom theme'),
          ),
        ],
      ),
    ],
  );
  }
