import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier {
  bool _isObscure = true;
  bool get isObscure => _isObscure;
  setVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }
}
