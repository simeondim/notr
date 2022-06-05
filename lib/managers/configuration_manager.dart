import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notr/models/fatal_error.dart';
import 'package:notr/services/util/log_error.dart';

class ConfigurationManager {
  static ConfigurationManager? _instance;

  factory ConfigurationManager({
    required FirebaseOptions firebaseOptions,
    String? firebaseAppName,
  }) {
    return _instance ??= ConfigurationManager._(
      firebaseOptions: firebaseOptions,
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

  void configure(Widget widget) {
    WidgetsFlutterBinding.ensureInitialized();

    runZonedGuarded(
      () async {
        runApp(widget);
      },
      (error, stack) async {
        if (!_isInitialized && kDebugMode) {
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
