import 'package:firebase_auth/firebase_auth.dart';
import 'package:notr/models/either.dart';
import 'package:notr/models/email_and_password_credentials.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/unknown_failure.dart';
import 'package:notr/repository/authentication_repository.dart';

class AuthenticationService {
  const AuthenticationService({
    AuthentiationRepository repository = const AuthentiationRepository(),
  }) : _authRepo = repository;

  final AuthentiationRepository _authRepo;

  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
    EmailAndPasswordCredentials credentials,
  ) async {
    return Left(const UnknownFailure());
  }
}
