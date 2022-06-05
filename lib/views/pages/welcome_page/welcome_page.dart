import 'package:flutter/material.dart';
import 'package:notr/views/pages/login_page/login_page.dart';
import 'package:notr/views/widgets/width_constrained_box/width_constrained_box.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 76),
              child: Text(
                "Notr",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Text(
                "Listen Audiobooks & Take Notes",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 76, left: 16, right: 16),
              child: WidthConstrainedBox(
                child: OutlinedButton(
                  key: const Key("loginPageButton"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("LOGIN WITH EMAIL"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
