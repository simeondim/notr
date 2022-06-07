import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/services/authentication_service.dart';
import 'package:notr/views/widgets/authentication_layer/authentication_layer.dart';

import 'authentication_layer_test.mocks.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {
  late Function(User?) onAuthChanged;
  @override
  void listenForAuthStateChanges(Function(User?) onChanged) {
    onAuthChanged = onChanged;
  }
}

@GenerateMocks([User])
main() {
  testWidgets(
    "show Authenticated Widget when user login successfully",
    (tester) async {
      final authService = MockAuthenticationService();
      final user = MockUser();
      final widget = MaterialApp(
        home: AuthenticationLayer(
          unauthenticated: const SizedBox(),
          authenticated: const SizedBox(),
          authService: authService,
        ),
      );

      await tester.pumpWidget(widget);

      expect(find.byKey(const Key('unauthenticatedWidget')), findsOneWidget);
      expect(find.byKey(const Key('authenticatedWidget')), findsNothing);

      authService.onAuthChanged(user);

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('unauthenticatedWidget')), findsNothing);
      expect(find.byKey(const Key('authenticatedWidget')), findsOneWidget);
    },
  );
}
