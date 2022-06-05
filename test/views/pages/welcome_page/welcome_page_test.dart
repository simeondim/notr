import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/views/pages/login_page/login_page.dart';
import 'package:notr/views/pages/welcome_page/welcome_page.dart';

import 'welcome_page_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigatorObserver>(returnNullOnMissingStub: true),
])
main() {
  late MockNavigatorObserver navObserver;

  setUp(() {
    navObserver = MockNavigatorObserver();
  });
  testWidgets(
    "should navigate to login page when login button is tapped",
    (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: const WelcomePage(),
        navigatorObservers: [navObserver],
      ));

      verify(navObserver.didPush(any, any));

      await tester.tap(find.byKey(const Key('loginPageButton')));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    },
  );
}
