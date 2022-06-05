import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notr/firebase_options.dart';
import 'package:notr/models/fatal_error.dart';
import 'package:notr/services/util/log_error.dart';

/// This is the entry point of the application.
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
      (error, stack) async {
        if (!_isInitialized) {
          debugPrint(
            "Application is not initialized. Call ConfigurationManager.initialize().",
          );
        }

        if (error is FatalError) _exitApp();

        logError(error, stack);
      },
    );
  }

  Future<void> initialize({
    bool allowDataCollection = true,
  }) async {
    try {
      await Firebase.initializeApp(
        name: firebaseAppName,
        options: firebaseOptions,
      );

      // Disable data collection in debug mode or user disables it.
      if (kDebugMode || !allowDataCollection) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      _isInitialized = true;
    } catch (error, stack) {
      throw FatalError(error, stack);
    }
  }

  Future<void> _exitApp() async {
    Future.delayed(
      const Duration(seconds: 2),

      // This method is like exit(0) - it basically closes the app.
      () => SystemNavigator.pop(animated: true),
    );
  }
}
