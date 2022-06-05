import 'package:flutter/foundation.dart';

void logError(Object error, StackTrace stack) {
  debugPrint('-------------------- ERROR LOG -----------------------');
  debugPrint('ERROR: $error');
  debugPrintStack(stackTrace: stack);
  debugPrint('----------------------- END --------------------------');
}
