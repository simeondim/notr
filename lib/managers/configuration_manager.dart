import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notr/models/fatal_error.dart';

class ConfigurationManager {
  ConfigurationManager({
    required this.firebaseOptions,
    this.firebaseAppName,
  });

  final String? firebaseAppName;
  final FirebaseOptions firebaseOptions;

  void configure(Widget widget) {
    WidgetsFlutterBinding.ensureInitialized();

    runZonedGuarded(
      () async {
        await initialize();

        runApp(widget);
      },
      (error, stack) async {
        if (error is FatalError) _exitApp();
      },
    );
  }

  Future<bool> initialize() async {
    try {
      await Firebase.initializeApp(
        name: firebaseAppName,
        options: firebaseOptions,
      );

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      return true;
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
