import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get jwtToken async {
    return _sharedPreference.getString(Preferences.jwt_token);
  }

  Future<bool> saveJwtToken(String authToken) async {
    return _sharedPreference.setString(Preferences.jwt_token, authToken);
  }

  Future<bool> removeJwtToken() async {
    return _sharedPreference.remove(Preferences.jwt_token);
  }

  bool containsKey() {
    return _sharedPreference.containsKey(Preferences.jwt_token);
  }

  // General Methods: username
  Future<String?> get username async {
    return _sharedPreference.getString(Preferences.username);
  }

  Future<bool> saveUsername(String username) async {
    return _sharedPreference.setString(Preferences.username, username);
  }

  Future<bool> removeUsername() async {
    return _sharedPreference.remove(Preferences.username);
  } 

  // General Methods: Password
  Future<String?> get password async {
    return _sharedPreference.getString(Preferences.password);
  }

  Future<bool> savePassword(String password) async {
    return _sharedPreference.setString(Preferences.password, password);
  }

  Future<bool> removePassword() async {
    return _sharedPreference.remove(Preferences.password);
  } 


  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }
}
