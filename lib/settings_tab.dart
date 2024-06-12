import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Account',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            if (themeProvider.user != null)
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: themeProvider.profilePhotoUrl != null
                      ? NetworkImage(themeProvider.profilePhotoUrl!)
                      : null,
                  child: themeProvider.profilePhotoUrl == null ? const Icon(Icons.person) : null,
                ),
                title: Text(themeProvider.user!.displayName ?? 'unknown'),
                subtitle: Text(themeProvider.user!.email ?? 'unknown@example.com'),
                trailing: TextButton(
                  onPressed: () async {
                    await themeProvider.signOut();
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              ListTile(
                title: const Text('Not logged in'),
                trailing: TextButton(
                  onPressed: () async {
                    await themeProvider.signInWithGitHub();
                  },
                  child: const Text('Login with GitHub'),
                ),
              ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Appearance',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('App theme'),
              trailing: TextButton(
                child: Text(
                  _getThemeModeString(_getThemeModeOption(themeProvider.themeMode)),
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onPressed: () => _showThemeDialog(context, themeProvider),
              ),
            ),
            SwitchListTile(
              title: const Text('Enable Material You'),
              value: themeProvider.materialYouEnabled,
              onChanged: (bool value) {
                themeProvider.setMaterialYouEnabled(value);
              },
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.brightness_auto),
                title: const Text('System'),
                onTap: () {
                  themeProvider.setThemeMode(ThemeMode.system);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_5),
                title: const Text('Light'),
                onTap: () {
                  themeProvider.setThemeMode(ThemeMode.light);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.brightness_2),
                title: const Text('Dark'),
                onTap: () {
                  themeProvider.setThemeMode(ThemeMode.dark);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ThemeModeOption _getThemeModeOption(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return ThemeModeOption.light;
      case ThemeMode.dark:
        return ThemeModeOption.dark;
      case ThemeMode.system:
      default:
        return ThemeModeOption.system;
    }
  }

  String _getThemeModeString(ThemeModeOption option) {
    switch (option) {
      case ThemeModeOption.system:
        return 'System';
      case ThemeModeOption.light:
        return 'Light';
      case ThemeModeOption.dark:
        return 'Dark';
    }
  }
}

enum ThemeModeOption {
  system,
  light,
  dark,
}
