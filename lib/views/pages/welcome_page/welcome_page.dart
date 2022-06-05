import 'package:flutter/material.dart';
import 'package:notr/views/pages/login_page/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OutlinedButton(
        key: const Key("loginPageButton"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        child: const Text("LOGIN WITH EMAIL"),
      ),
    );
  }
}
