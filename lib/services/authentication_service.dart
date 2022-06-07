import 'package:firebase_auth/firebase_auth.dart';
import 'package:notr/managers/application_error_manager.dart';
import 'package:notr/managers/firebase_auth_failure_manager.dart';
import 'package:notr/models/either.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/fatal_error.dart';
import 'package:notr/repository/authentication_repository.dart';
import 'package:notr/services/util/error_handler.dart';

class AuthenticationService {
  const AuthenticationService({
    AuthentiationRepository repository = const AuthentiationRepository(),
  }) : _authRepo = repository;

  final AuthentiationRepository _authRepo;

  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
    EmailAndPasswordCredentials credentials,
  ) async {
    return errorHandler(
      () async {
        final failure = credentials.validate();
        if (failure != null) throw failure;

        return await _authRepo.signInWithEmailAndPassword(credentials);
      },
      failureManagers: [
        FirebaseAuthFailureManager(),
      ],
    );
  }

  /// Register listener for authentication changes.
  /// On error throws [FatalError] and application must be closed.
  void listenForAuthStateChanges(Function(User?) onAuthStateChanged) {
    _authRepo.authStateChanges().listen(onAuthStateChanged).onError(
      (error, stack) {
        final err = FatalError(error, stack);
        ApplicationErrorManager().handleError(err, stack);
      },
    );
  }
}
