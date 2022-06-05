import 'package:flutter/material.dart';
import 'package:notr/managers/configuration_manager.dart';
import 'package:notr/views/pages/loading_page.dart';

class AppSetup extends StatefulWidget {
  const AppSetup({required this.configManager, super.key});

  final ConfigurationManager configManager;

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
    await widget.configManager.initialize();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: LoadingPage(),
      );
    }

    return const MaterialApp(
      key: Key('mainMaterialApp'),
      debugShowCheckedModeBanner: false,
      home: SizedBox(),
    );
  }
}
