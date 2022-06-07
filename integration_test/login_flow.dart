import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:notr/views/widgets/app_setup/app_setup.dart';

main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('should log in with corrent email and password', (tester) async {
    await tester.pumpWidget(const AppSetup(useLocalEmulators: true));
    await tester.pumpAndSettle();

    // Create account with email and password;
    final fakeEmail = 'email${DateTime.now().microsecondsSinceEpoch}@test.com';
    final fakePass = DateTime.now().microsecondsSinceEpoch.toString();

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: fakeEmail,
      password: fakePass,
    );

    await Future.delayed(const Duration(seconds: 2));

    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    // Go to login with email and password page.
    final loginWithEmailButton = find.byKey(const Key("loginPageButton"));
    await tester.tap(loginWithEmailButton);

    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    final emailField = find.byKey(const Key("emailTextField"));
    final passwordField = find.byKey(const Key("passwordTextField"));
    final loginButton = find.byKey(const Key("loginButton"));

    Future<void> tapLoginButton() async {
      await tester.ensureVisible(loginButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Scaffold));
      await tester.pumpAndSettle();
      await tester.tap(loginButton);
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    }

    await tester.enterText(emailField, '');
    await tester.enterText(passwordField, 'testpass');

    await tapLoginButton();

    await tester.enterText(emailField, 'wrong@email.com');
    await tester.enterText(passwordField, 'testpass');

    await tapLoginButton();

    await tester.enterText(emailField, fakeEmail);
    await tester.enterText(passwordField, fakePass);

    await tapLoginButton();

    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("homePage")), findsOneWidget);

    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("homePage")), findsNothing);
  });
}
