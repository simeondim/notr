import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notr/managers/configuration_manager.dart';
import 'package:notr/views/widgets/app_setup/app_setup.dart';

import '../../../firebase_mock/mock.dart';
import 'app_setup_test.mocks.dart';

@GenerateMocks([ConfigurationManager])
void main() {
  late MockConfigurationManager configManager;

  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  setUp(() {
    configManager = MockConfigurationManager();
  });

  testWidgets(
    'Should show loading page only while initializing app',
    (tester) async {
      when(configManager.initialize()).thenAnswer((_) async => true);

      await tester.pumpWidget(AppSetup(
        configManager: configManager,
      ));

      expect(find.byKey(const Key('loadingIndicator')), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('loadingIndicator')), findsNothing);
    },
  );
}
