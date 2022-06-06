import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notr/firebase_options.dart';
import 'package:notr/models/fatal_error.dart';

/// Defines the way application is started and exited on error.
/// [startApp] must be called first in order to show the initial [Widget] and
/// configure error handling.
/// [initialize] must be called before any other services.
class ConfigurationManager {
  static ConfigurationManager? _instance;

  factory ConfigurationManager({
    FirebaseOptions? firebaseOptions,
    String? firebaseAppName,
  }) {
    return _instance ??= ConfigurationManager._(
      firebaseOptions:
          firebaseOptions ?? DefaultFirebaseOptions.currentPlatform,
      firebaseAppName: firebaseAppName,
    );
  }

  ConfigurationManager._({
    required this.firebaseOptions,
    this.firebaseAppName,
  });

  final String? firebaseAppName;
  final FirebaseOptions firebaseOptions;

  bool _isInitialized = false;

  void startApp(Widget widget) {
    WidgetsFlutterBinding.ensureInitialized();

    runZonedGuarded(
      () => runApp(widget),
      _handleError,
    );
  }

  void _handleError(Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrint('-------------------- ERROR LOG -----------------------');
      debugPrint('ERROR: $error');
      debugPrintStack(stackTrace: stack);
      debugPrint('----------------------- END --------------------------');
    }

    if (!_isInitialized) {
      debugPrint(
        "App is not initialized. Call ConfigurationManager.initialize().",
      );
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

  Future<void> initialize({
    bool enabledDataCollection = true,
  }) async {
    try {
      await Firebase.initializeApp(
        name: firebaseAppName,
        options: firebaseOptions,
      );

      // Disable data collection in debug mode or user disables it.
      if (kDebugMode || !enabledDataCollection) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      _isInitialized = true;
    } catch (error, stack) {
      throw FatalError(error, stack);
    }
  }
}
