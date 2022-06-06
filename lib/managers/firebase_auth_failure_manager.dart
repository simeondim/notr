import 'package:flutter/material.dart';
import 'package:notr/models/failure_manager.dart';
import 'package:notr/models/failures/failure.dart';

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
    return null;
  }
}
