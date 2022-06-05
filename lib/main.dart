import 'package:notr/firebase_options.dart';
import 'package:notr/managers/configuration_manager.dart';
import 'package:notr/views/widgets/app_setup/app_setup.dart';

void main() {
  final configManager = ConfigurationManager(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );

  configManager.startApp(AppSetup(configManager: configManager));
}
