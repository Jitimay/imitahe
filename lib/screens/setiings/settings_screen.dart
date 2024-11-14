import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildDarkModeToggle(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkModeToggle(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state.brightness == Brightness.dark;

    return ListTile(
      leading: Icon(LineIcons.lightbulb, color: isDarkMode ? Colors.orange : Colors.grey),
      title: const Text('Dark Mode', style: TextStyle(color: Colors.white)),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) => themeCubit.toggleTheme(),
        activeColor: Colors.orange,
      ),
    );
  }
}
