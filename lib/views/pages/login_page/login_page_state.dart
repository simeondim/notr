import 'package:flutter/material.dart';

class LoginPageState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String? _emailFieldErrorText;
  String? get emailFieldErrorText => _emailFieldErrorText;
  set emailFieldErrorText(String? emailFieldErrorText) {
    _emailFieldErrorText = emailFieldErrorText;
    notifyListeners();
  }

  String? _passwordFieldErrorText;
  String? get passwordFieldErrorText => _passwordFieldErrorText;
  set passwordFieldErrorText(String? passwordFieldErrorText) {
    _passwordFieldErrorText = passwordFieldErrorText;
    notifyListeners();
  }

  String? _unknownErrorMessage;
  String? get unknownErrorMessage => _unknownErrorMessage;
  set unknownErrorMessage(String? unknownErrorMessage) {
    _unknownErrorMessage = unknownErrorMessage;
    notifyListeners();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
