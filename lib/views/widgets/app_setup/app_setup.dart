import 'package:flutter/material.dart';
import 'package:notr/managers/configuration_manager.dart';
import 'package:notr/views/pages/loading_page/loading_page.dart';
import 'package:notr/views/pages/user_home_page/user_home_page.dart';
import 'package:notr/views/pages/welcome_page/welcome_page.dart';
import 'package:notr/views/widgets/app_theme/app_theme.dart';
import 'package:notr/views/widgets/authentication_layer/authentication_layer.dart';

class AppSetup extends StatefulWidget {
  const AppSetup({
    this.configManager = const ConfigurationManager(),
    this.child,
    this.useLocalEmulators = false,
    super.key,
  });

  final ConfigurationManager configManager;
  final Widget? child;
  final bool useLocalEmulators;

  @override
  State<AppSetup> createState() => _AppSetupState();
}

class _AppSetupState extends State<AppSetup> {
  bool _isLoading = true;

  @override
  void initState() {
    _initializeApp();
    super.initState();
  }

  Future<void> _initializeApp() async {
    await widget.configManager.initialize(
      useLocalEmulators: widget.useLocalEmulators,
    );
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        key: Key('loadingIndicator'),
        home: LoadingPage(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: const AppTheme().getThemeData(),
      home: widget.child ??
          const AuthenticationLayer(
            unauthenticated: WelcomePage(key: Key('welcomePage')),
            authenticated: UserHomePage(key: Key('homePage')),
          ),
    );
  }
}
