import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notr/models/failure_manager.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/failures/not_available.dart';
import 'package:notr/models/failures/not_valid.dart';
import 'package:notr/models/failures/unknown_failure.dart';

class FirebaseAuthFailureManager implements FailureManager {
  @override
  Failure? getFailure(Object error) {
    final emailAndPassFailure = getSignInWithEmailAndPasswordFailure(error);
    if (emailAndPassFailure != null) return emailAndPassFailure;

    return null;
  }

  /// Implements possible errors from [FirebaseAuth.instance.signInWithEmailAndPassword]
  @visibleForTesting
  Failure? getSignInWithEmailAndPasswordFailure(Object error) {
    if (error is! FirebaseAuthException) return null;

    if (error.code == 'invalid-email') {
      return const InvalidEmail(NotValid());
    }

    if (error.code == 'user-disabled') {
      return const InvalidEmail(NotAvailable());
    }

    if (error.code == 'user-not-found') {
      return const InvalidEmail(UnknownFailure());
    }

    if (error.code == 'wrong-password') {
      return const InvalidPassword(NotValid());
    }

    return null;
  }
}
