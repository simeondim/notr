import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:notr/managers/configuration_manager.dart';
import 'package:notr/views/pages/loading_page/loading_page.dart';
import 'package:notr/views/widgets/app_setup/app_setup.dart';

import 'app_setup_test.mocks.dart';

@GenerateMocks([ConfigurationManager])
void main() {
  late MockConfigurationManager configManager;

  setUp(() {
    configManager = MockConfigurationManager();
  });

  testWidgets(
    'Should show loading page only while initializing app',
    (tester) async {
      await tester.pumpWidget(AppSetup(configManager: configManager));

      expect(find.byType(LoadingPage), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.byType(LoadingPage), findsNothing);
      expect(find.byKey(const Key('mainMaterialApp')), findsOneWidget);
    },
  );
}
