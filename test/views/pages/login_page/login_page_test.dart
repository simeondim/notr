import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notr/views/pages/login_page/login_page.dart';

import '../../../firebase_mock/mock.dart';

main() {
  late MaterialApp widget;

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() {
    widget = const MaterialApp(home: LoginPage());
  });
  group("login page", () {
    testWidgets(
      "should have 2 text fields",
      (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byType(TextField), findsNWidgets(2));
      },
    );

    testWidgets(
      "should have login button",
      (tester) async {
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key("loginButton")), findsOneWidget);
      },
    );
  });
}
