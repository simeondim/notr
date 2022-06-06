import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/models/either.dart';
import 'package:notr/models/failures/empty_input.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/not_valid.dart';
import 'package:notr/models/failures/unknown.dart';
import 'package:notr/services/authentication_service.dart';
import 'package:notr/views/pages/login_page/login_page_controller.dart';
import 'package:notr/views/pages/login_page/login_page_state.dart';

import 'login_page_controller_test.mocks.dart';

@GenerateMocks([AuthenticationService])
main() {
  late MockAuthenticationService authService;
  late LoginPageState state;
  late LoginPageController controller;

  setUp(() {
    authService = MockAuthenticationService();
    state = LoginPageState();
    controller = LoginPageController(authService: authService);
  });

  group(
    "login",
    () {
      test("should change isLoading state to true", () {
        final returnValue = Left<Failure, UserCredential>(
          const InvalidEmail(EmptyInput()),
        );

        when(authService.signInWithEmailAndPassword(any))
            .thenAnswer((_) async => returnValue);

        expect(state.isLoading, isFalse);

        controller.login(state);

        expect(state.isLoading, isTrue);
      });

      test(
          'should change emailFieldErrorText to string if service returns InvalidEmail',
          () async {
        final returnValue = Left<Failure, UserCredential>(
          const InvalidEmail(EmptyInput()),
        );

        when(authService.signInWithEmailAndPassword(any))
            .thenAnswer((_) async => returnValue);

        expect(state.emailFieldErrorText, isNot(String));

        await controller.login(state);

        expect(state.emailFieldErrorText, isA<String>());
      });

      test(
          'should change passwordTextField to string if service returns InvalidPassword',
          () async {
        final returnValue = Left<Failure, UserCredential>(
          const InvalidPassword(NotValid()),
        );

        when(authService.signInWithEmailAndPassword(any))
            .thenAnswer((_) async => returnValue);

        expect(state.passwordFieldErrorText, isNot(String));

        await controller.login(state);

        expect(state.passwordFieldErrorText, isA<String>());
      });

      test(
          'should change unknownErrorMessage if service returns Unknown failure',
          () async {
        final returnValue = Left<Failure, UserCredential>(const Unknown());

        when(authService.signInWithEmailAndPassword(any))
            .thenAnswer((_) async => returnValue);

        expect(state.unknownErrorMessage, isNot(String));

        await controller.login(state);

        expect(state.unknownErrorMessage, isA<String>());
      });
    },
  );
}
