import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/models/either.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/empty_input.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/services/authentication_service.dart';
import 'package:notr/views/pages/login_page/login_page_controller.dart';
import 'package:notr/views/pages/login_page/login_page_state.dart';

import 'login_page_controller_test.mocks.dart';

@GenerateMocks([AuthenticationService, UserCredential])
main() {
  late MockAuthenticationService authRepo;
  late LoginPageState state;
  late LoginPageController controller;

  setUp(() {
    authRepo = MockAuthenticationService();
    state = LoginPageState();
    controller = LoginPageController(authService: authRepo);
  });

  group(
    "login",
    () {
      const credentials = EmailAndPasswordCredentials(
        email: 'test@test.com',
        password: 'testpass',
      );

      test("should change isLoading state to true", () {
        controller.login(state);

        expect(state.isLoading, isTrue);
      });

      test(
          'should change emailFieldErrorText to string if service returns InvalidEmail',
          () async {
        final signInWithPass = authRepo.signInWithEmailAndPassword(credentials);
        final value = Left<Failure, UserCredential>(
          const InvalidEmail(EmptyInput()),
        );

        when(signInWithPass).thenAnswer((_) async => value);

        await controller.login(state);

        expect(state.emailFieldErrorText, isNotNull);
        expect(state.emailFieldErrorText, isA<String>());
      });

      test(
          'should change passwordTextField to string if service returns InvalidPassword',
          () async {
        final signInWithPass = authRepo.signInWithEmailAndPassword(credentials);
        final value = Left<Failure, UserCredential>(
          const InvalidPassword(EmptyInput()),
        );

        when(signInWithPass).thenAnswer((_) async => value);

        await controller.login(state);

        expect(state.passwordFieldErrorText, isNotNull);
        expect(state.passwordFieldErrorText, isA<String>());
      });
    },
  );
}
