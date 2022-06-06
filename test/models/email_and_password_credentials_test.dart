import 'package:flutter_test/flutter_test.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/with_sub_failure.dart';

import '../services/util/error_handler_test.dart';

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

          expect(failure, isA<InvalidEmail>());

          failure as WithSubFailure;

          expect(failure.subFailure, isA<EmptyInput>);
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

          expect(failure, isA<InvalidPassword>());

          failure as WithSubFailure;

          expect(failure.subFailure, isA<EmptyInput>());
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
