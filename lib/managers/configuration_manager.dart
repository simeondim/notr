import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notr/firebase_options.dart';
import 'package:notr/managers/application_error_manager.dart';
import 'package:notr/models/fatal_error.dart';

/// Defines the way application is started and how error are managed.
/// [startApp] must be called first in order to show the initial [Widget] and
/// configure error handling.
/// [initialize] must be called before any other services.
class ConfigurationManager {
  const ConfigurationManager({
    this.firebaseOptions,
    this.firebaseAppName,
  });

  final String? firebaseAppName;
  final FirebaseOptions? firebaseOptions;
  final errorManager = const ApplicationErrorManager();

  void startApp(Widget widget) {
    WidgetsFlutterBinding.ensureInitialized();

    runZonedGuarded(
      () => runApp(widget),
      (error, stack) => errorManager.handleError(error, stack),
    );
  }

  Future<void> initialize({
    bool enabledDataCollection = true,
    bool useLocalEmulators = false,
  }) async {
    try {
      await Firebase.initializeApp(
        name: firebaseAppName,
        options: firebaseOptions ?? DefaultFirebaseOptions.currentPlatform,
      );

      if (useLocalEmulators) _setupLocalEmulator();

      // Disable data collection in debug mode or user disables it.
      if (kDebugMode || !enabledDataCollection) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }

      if (!useLocalEmulators) {
        FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      }
    } catch (error, stack) {
      errorManager.logErrorToConsle(error, stack);
      throw FatalError(error, stack);
    }
  }

  _setupLocalEmulator() {
    FirebaseAuth.instance.useAuthEmulator("192.168.0.101", 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('192.168.0.101', 8080);
  }
}
