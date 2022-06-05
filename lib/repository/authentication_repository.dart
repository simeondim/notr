import 'package:firebase_auth/firebase_auth.dart';
import 'package:notr/models/email_and_password_credentials.dart';

class AuthentiationRepository {
  const AuthentiationRepository();

  Future<UserCredential> signInWithEmailAndPassword(
    EmailAndPasswordCredentials credentials,
  ) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: credentials.email,
      password: credentials.password,
    );
  }
}
