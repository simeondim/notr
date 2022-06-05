import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:notr/models/fatal_error.dart';

void logError(Object error, StackTrace stack) {
  debugPrint('-------------------- ERROR LOG -----------------------');
  debugPrint('ERROR: $error');
  debugPrintStack(stackTrace: stack);
  debugPrint('----------------------- END --------------------------');

  if (!kDebugMode) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: error is FatalError,
    );
  }
}
