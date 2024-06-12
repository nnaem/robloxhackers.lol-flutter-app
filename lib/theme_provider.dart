import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _materialYouEnabled = false;
  User? _user;
  String? _profilePhotoUrl;

  ThemeMode get themeMode => _themeMode;
  bool get materialYouEnabled => _materialYouEnabled;
  User? get user => _user;
  String? get profilePhotoUrl => _profilePhotoUrl;

  final AuthService _authService = AuthService();

  ThemeProvider() {
    _loadPreferences();
    _authService.authStateChanges.listen((user) {
      _user = user;
      _profilePhotoUrl = _authService.getProfilePhotoUrl(user);
      notifyListeners();
    });
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString('themeMode') ?? 'system';
    _themeMode = _getThemeModeFromString(themeModeString);
    _materialYouEnabled = prefs.getBool('materialYouEnabled') ?? false;
    notifyListeners();
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', _themeMode.toString().split('.').last);
    prefs.setBool('materialYouEnabled', _materialYouEnabled);
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    _savePreferences();
    notifyListeners();
  }

  void setMaterialYouEnabled(bool enabled) {
    _materialYouEnabled = enabled;
    _savePreferences();
    notifyListeners();
  }

  Future<void> signInWithGitHub() async {
    User? user = await _authService.signInWithGitHub();
    _user = user;
    _profilePhotoUrl = _authService.getProfilePhotoUrl(user);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _profilePhotoUrl = null;
    notifyListeners();
  }

  ThemeMode _getThemeModeFromString(String themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
