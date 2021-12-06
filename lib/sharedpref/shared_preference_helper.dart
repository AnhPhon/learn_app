import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // Login: ----------------------------------------------------------
  Future<bool> get getLogin async {
    return _sharedPreference.getBool(Preferences.isLogin) ?? false;
  }

  Future<bool> setLogin({required bool status}) async {
    return _sharedPreference.setBool(Preferences.isLogin, status);
  }

  // splash: ----------------------------------------------------------
  Future<bool> get getSplash async {
    return _sharedPreference.getBool(Preferences.isSplash) ?? false;
  }

  Future<bool> setSplash({required bool status}) async {
    return _sharedPreference.setBool(Preferences.isSplash, status);
  }

  // General Methods: Access token
  Future<String> get getJwtToken async {
    return _sharedPreference.getString(Preferences.jwtToken) ?? '';
  }

  Future<bool> setJwtToken(String authToken) async {
    return _sharedPreference.setString(Preferences.jwtToken, authToken);
  }

  // fcm token
  Future<String> get getFcmToken async {
    return _sharedPreference.getString(Preferences.fcmToken) ?? '';
  }

  Future<bool> setFcmToken(String fcmToken) async {
    return _sharedPreference.setString(Preferences.fcmToken, fcmToken);
  }

  // Language:---------------------------------------------------
  String get getLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage) ?? 'vi-VN';
  }

  Future<void> setLanguage(String language) {
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  // profile
  Future<String> get getProfile async {
    return _sharedPreference.getString(Preferences.profile) ?? '{}';
  }

  Future<void> setProfile(String remember) async {
    _sharedPreference.setString(Preferences.profile, remember);
  }
}
