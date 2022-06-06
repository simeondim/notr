import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notr/views/pages/login_page/login_page.dart';

main() {
  late MaterialApp widget;

  setUp(() {
    widget = const MaterialApp(home: LoginPage());
  });

  testWidgets(
    "should have 2 text fields",
    (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(2));
    },
  );

  testWidgets(
    "should login button",
    (tester) async {
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("loginButton")), findsOneWidget);
    },
  );
}
