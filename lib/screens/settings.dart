import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_workshop/screens/theme_notifier.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF1F3D1D),
      ),
      body: Container(
        child: Column(
          children: [
            Consumer<ThemeNotifier>(
              builder: (context, themeNotifier, _) {
                final _isDarkTheme =
                    themeNotifier.getTheme().brightness == Brightness.dark;

                void _toggleTheme(bool value) async {
                  await themeNotifier.setTheme(value);
                }

                return ListTile(
                  title: Text('Dark Theme'),
                  trailing: Switch(
                    value: _isDarkTheme,
                    onChanged: _toggleTheme,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
