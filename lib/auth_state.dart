import 'package:fatty_flutter/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AuthState extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _loggedIn = false;

  AuthState(this.prefs) {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool(loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
    debugPrint("LoggedIn: ${loggedIn.toString()}");
  }

  Future<void> saveAuthData(AuthData authData) async {
    if (authData.name != null) {
      await prefs.setString('name', authData.name!);
    }
    await prefs.setString('email', authData.email);
    await prefs.setString('password', authData.password);

    debugPrint(
        "pref email: ${prefs.getString('email')} email: ${authData.email}");
    debugPrint(
        "pref password: ${prefs.getString('password')} password: ${authData.password}");

    notifyListeners();
  }

  Future<bool> isValidCredential(String email, String password) async {
    debugPrint("pref email: ${prefs.getString('email')} email: $email");
    debugPrint(
        "pref password: ${prefs.getString('password')} password: $password");

    if (prefs.getString('email') != null &&
        prefs.getString('password') != null) {
      if (prefs.getString('email') == email &&
          prefs.getString('password') == password) {
        return true;
      }
    }
    return false;
  }
}
