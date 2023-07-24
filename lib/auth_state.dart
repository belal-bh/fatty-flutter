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
}
