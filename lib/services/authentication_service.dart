import 'package:notr/repository/authentication_repository.dart';

class AuthenticationService {
  const AuthenticationService({
    AuthentiationRepository repository = const AuthentiationRepository(),
  }) : _authRepo = repository;

  final AuthentiationRepository _authRepo;
}
