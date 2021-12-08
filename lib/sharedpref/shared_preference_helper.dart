import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // Login: ----------------------------------------------------------
  bool get getLogin {
    return _sharedPreference.getBool(Preferences.isLogin) ?? false;
  }

  void setLogin({required bool status}) {
    _sharedPreference.setBool(Preferences.isLogin, status);
  }

  // splash: ----------------------------------------------------------
  bool get getSplash {
    return _sharedPreference.getBool(Preferences.isSplash) ?? false;
  }

  void setSplash({required bool status}) {
    _sharedPreference.setBool(Preferences.isSplash, status);
  }

  // General Methods: Access token
  String get getJwtToken {
    return _sharedPreference.getString(Preferences.jwtToken) ?? '';
  }

  void setJwtToken(String authToken) {
    _sharedPreference.setString(Preferences.jwtToken, authToken);
  }

  // fcm token
  String get getFcmToken {
    return _sharedPreference.getString(Preferences.fcmToken) ?? '';
  }

  void setFcmToken(String fcmToken) {
    _sharedPreference.setString(Preferences.fcmToken, fcmToken);
  }

  // Language:---------------------------------------------------
  String get getLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage) ?? 'vi-VN';
  }

  void setLanguage(String language) {
    _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  // profile
  String get getProfile {
    return _sharedPreference.getString(Preferences.profile) ?? '{}';
  }

  void setProfile(String remember) {
    _sharedPreference.setString(Preferences.profile, remember);
  }
}
