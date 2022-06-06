import 'package:flutter_test/flutter_test.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/empty_input.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/with_sub_failure.dart';

main() {
  group(
    "validate",
    () {
      test(
        "returns InvalidEmail with EmptyInput if the email is empty",
        () {
          const credentials = EmailAndPasswordCredentials(
            email: '',
            password: 'testpass',
          );

          final failure = credentials.validate();

          expect(failure.runtimeType, isNot(Failure));
          expect(failure.runtimeType, InvalidEmail);

          failure as WithSubFailure;

          expect(failure.subFailure.runtimeType, isNot(InvalidEmail));
          expect(failure.subFailure.runtimeType, EmptyInput);
        },
      );

      test(
        "returns InvalidPassword with EmptyInput if the password is empty",
        () {
          const credentials = EmailAndPasswordCredentials(
            email: 'test@test.com',
            password: '',
          );

          final failure = credentials.validate();

          expect(failure.runtimeType, isNot(Failure));
          expect(failure.runtimeType, InvalidPassword);

          failure as WithSubFailure;

          expect(failure.subFailure.runtimeType, isNot(InvalidPassword));
          expect(failure.subFailure.runtimeType, EmptyInput);
        },
      );

      test(
        "returns null if email and password are formatted correctly",
        () {
          const credentials = EmailAndPasswordCredentials(
            email: 'test@test.com',
            password: 'testpass',
          );

          final failure = credentials.validate();

          expect(failure, isNull);
        },
      );
    },
  );
}
