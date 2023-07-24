import 'package:flutter/material.dart';

class ValidationModel {
  String? value;
  String? error;
  ValidationModel(this.value, this.error);
}

class AuthData {
  final String? name;
  final String email;
  final String password;

  AuthData({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthFormProvider extends ChangeNotifier {
  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel get email => _email;
  ValidationModel get password => _password;
  ValidationModel get name => _name;

  void validateEmail(String? val) {
    if (val != null && val.isValidEmail) {
      _email = ValidationModel(val, null);
    } else {
      _email = ValidationModel(null, 'Please Enter a Valid Email');
    }
    notifyListeners();
  }

  void validatePassword(String? val) {
    if (val != null && val.isValidPassword) {
      _password = ValidationModel(val, null);
    } else {
      _password = ValidationModel(
          null, 'Must contain an uppercase, lowercase, numeric digit');
    }
    notifyListeners();
  }

  void validateName(String? val) {
    if (val != null && val.isValidName) {
      _name = ValidationModel(val, null);
    } else {
      _name = ValidationModel(null, 'Please enter a valid name');
    }
    notifyListeners();
  }

  bool get validate {
    return _email.value != null &&
        _password.value != null &&
        _name.value != null;
  }

  void showInvalidCredentialsSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Invalid credentials. Please try again.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    // ignore: unnecessary_null_comparison
    return this != null;
  }
}
