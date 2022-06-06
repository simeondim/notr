import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notr/managers/firebase_auth_failure_manager.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/not_available.dart';
import 'package:notr/models/failures/not_valid.dart';
import 'package:notr/models/failures/unknown_failure.dart';
import 'package:notr/models/failures/with_sub_failure.dart';

void main() {
  final failureManager = FirebaseAuthFailureManager();

  test(
    "Should return InvalidEmail with NotValid subfailure on 'invalid-email' code",
    () {
      final exception = FirebaseAuthException(code: 'invalid-email');
      final failure = failureManager.getFailure(exception);

      expect(failure.runtimeType, InvalidEmail);

      failure as WithSubFailure;

      expect(failure.subFailure.runtimeType, NotValid);
    },
  );

  test(
    "Should return InvalidEmail with NotAvailable subfailure on 'user-disabled' code",
    () {
      final exception = FirebaseAuthException(code: 'user-disabled');
      final failure = failureManager.getFailure(exception);

      expect(failure.runtimeType, InvalidEmail);

      failure as WithSubFailure;

      expect(failure.subFailure.runtimeType, NotAvailable);
    },
  );

  test(
    "Should return InvalidEmail with UnknownFailure subfailure on 'user-not-found' code",
    () {
      final exception = FirebaseAuthException(code: 'user-not-found');
      final failure = failureManager.getFailure(exception);

      expect(failure.runtimeType, InvalidEmail);

      failure as WithSubFailure;

      expect(failure.subFailure.runtimeType, UnknownFailure);
    },
  );

  test(
    "Should return InvalidPassword with NotValid subfailure on 'wrong-password' code",
    () {
      final exception = FirebaseAuthException(code: 'wrong-password');
      final failure = failureManager.getFailure(exception);

      expect(failure.runtimeType, InvalidPassword);

      failure as WithSubFailure;

      expect(failure.subFailure.runtimeType, NotValid);
    },
  );
}
