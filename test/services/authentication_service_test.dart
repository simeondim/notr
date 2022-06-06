import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/unknown.dart';
import 'package:notr/repository/authentication_repository.dart';
import 'package:notr/services/authentication_service.dart';

import 'authentication_service_test.mocks.dart';

@GenerateMocks([AuthentiationRepository, UserCredential])
main() {
  late MockAuthentiationRepository authRepo;
  late AuthenticationService service;

  setUp(() {
    authRepo = MockAuthentiationRepository();
    service = AuthenticationService(repository: authRepo);
  });

  group(
    "signInWithEmailAndPassword",
    () {
      const credentials = EmailAndPasswordCredentials(
        email: "test@test.com",
        password: "testpass",
      );
      test("should return Unknown when repo throws not known error", () async {
        when(authRepo.signInWithEmailAndPassword(credentials)).thenAnswer(
          (_) => throw Object(),
        );

        final result = await service.signInWithEmailAndPassword(credentials);

        expect(result.value.runtimeType, Unknown);
      });
      test("should return UserCredential on success", () async {
        when(authRepo.signInWithEmailAndPassword(credentials)).thenAnswer(
          (_) async => MockUserCredential(),
        );

        final result = await service.signInWithEmailAndPassword(credentials);

        expect(result.value, isA<UserCredential>());
      });

      test(
          "should return InvalidEmail if repository throws FirebaseAuthException",
          () async {
        const invalidCredentials = EmailAndPasswordCredentials(
          email: "test@test.com",
          password: "testpass",
        );

        when(authRepo.signInWithEmailAndPassword(credentials)).thenAnswer(
          (_) async => throw FirebaseAuthException(code: 'invalid-email'),
        );

        final result =
            await service.signInWithEmailAndPassword(invalidCredentials);

        expect(result.value.runtimeType, InvalidEmail);
      });
    },
  );
}
