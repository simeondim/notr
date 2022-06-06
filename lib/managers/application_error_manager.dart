import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:notr/models/fatal_error.dart';

class ApplicationErrorManager {
  void handleError(Object error, StackTrace stack) {
    if (kDebugMode && !Platform.environment.containsKey('FLUTTER_TEST')) {
      debugPrint('-------------------- ERROR LOG -----------------------');
      debugPrint('ERROR: $error');
      debugPrintStack(stackTrace: stack);
      debugPrint('----------------------- END --------------------------');
    }

    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: error is FatalError,
      );
    }

    if (error is FatalError) _exitApp();
  }

// TODO: Wipe app data before exiting.
  void _exitApp() {
    // This method is like exit(0) - it basically closes the app.
    SystemNavigator.pop(animated: true);
  }
}
