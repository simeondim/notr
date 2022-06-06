import 'package:notr/models/failures/empty_input.dart';
import 'package:notr/models/failures/failure.dart';
import 'package:notr/models/failures/invalid_email.dart';
import 'package:notr/models/failures/invalid_password.dart';
import 'package:notr/models/with_validation.dart';

class EmailAndPasswordCredentials implements WithValidation {
  const EmailAndPasswordCredentials({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  Failure? validate() {
    if (email.isEmpty) return const InvalidEmail(EmptyInput());

    if (password.isEmpty) return const InvalidPassword(EmptyInput());

    return null;
  }
}
