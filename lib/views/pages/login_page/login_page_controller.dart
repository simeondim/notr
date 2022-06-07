import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/empty_input.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/not_available.dart';
import 'package:notr/models/failures/not_valid.dart';
import 'package:notr/models/failures/unknown.dart';
import 'package:notr/services/authentication_service.dart';
import 'package:notr/views/pages/login_page/login_page_state.dart';

class LoginPageController {
  const LoginPageController({
    AuthenticationService authService = const AuthenticationService(),
  }) : _authService = authService;

  final AuthenticationService _authService;

  Future<void> login(LoginPageState state) async {
    final credentials = EmailAndPasswordCredentials(
      email: state.emailController.text,
      password: state.passwordController.text,
    );

    state.isLoading = true;
    final result = await _authService.signInWithEmailAndPassword(credentials);
    state.isLoading = false;

    // On success don't do anything. Authentication listener will update the
    // UI accordingly.
    result.either(
      (failure) => _handleLoginFailure(failure, state),
      (_) {},
    );
  }

  void _handleLoginFailure(Failure failure, LoginPageState state) {
    if (failure is InvalidEmail) {
      if (failure.subFailure is EmptyInput) {
        state.emailFieldErrorText = "Email cannot be empty.";
        return;
      }
      if (failure.subFailure is NotAvailable) {
        state.emailFieldErrorText = "This email cannot be used";
        return;
      }
      if (failure.subFailure is Unknown) {
        state.emailFieldErrorText = "Cannot find user with this email";
        return;
      }
    }

    if (failure is InvalidPassword && failure.subFailure is NotValid) {
      state.passwordFieldErrorText = "Try with different password";
      return;
    }

    if (failure is InvalidPassword && failure.subFailure is EmptyInput) {
      state.passwordFieldErrorText = "Password cannot be empty";
      return;
    }

    state.unknownErrorMessage =
        "Ups! Something went wrong! Please try again later!";
  }
}
