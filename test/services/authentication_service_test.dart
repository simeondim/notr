import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/failure.dart';
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
      test("should return failure when repo throws", () async {
        when(authRepo.signInWithEmailAndPassword(credentials)).thenAnswer(
          (_) => throw Object(),
        );

        final result = await service.signInWithEmailAndPassword(credentials);

        expect(result.returnedValue, isA<Failure>);
      });
      test("should return UserCredential on success", () async {
        when(authRepo.signInWithEmailAndPassword(credentials)).thenAnswer(
          (_) async => MockUserCredential(),
        );

        final result = await service.signInWithEmailAndPassword(credentials);

        expect(result.returnedValue, isA<UserCredential>);
      });
    },
  );
}
