import 'package:flutter/material.dart';
import 'package:notr/managers/configuration_manager.dart';

class AppSetup extends StatefulWidget {
  const AppSetup({super.key});

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
    await ConfigurationManager().initialize();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBox(),
    );
  }
}
