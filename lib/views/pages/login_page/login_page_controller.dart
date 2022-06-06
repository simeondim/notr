import 'package:notr/services/authentication_service.dart';
import 'package:notr/views/pages/login_page/login_page_state.dart';

class LoginPageController {
  const LoginPageController({
    AuthenticationService authService = const AuthenticationService(),
  }) : _authService = authService;

  final AuthenticationService _authService;

  Future<void> login(LoginPageState state) async {}
}
