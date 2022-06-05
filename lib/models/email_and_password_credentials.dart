import 'package:notr/models/failures/failure.dart';
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
    // TODO: implement validate
    throw UnimplementedError();
  }
}
