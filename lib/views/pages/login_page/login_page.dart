import 'package:flutter/material.dart';
import 'package:notr/views/pages/loading_page/loading_page.dart';
import 'package:notr/views/pages/login_page/login_page_controller.dart';
import 'package:notr/views/pages/login_page/login_page_state.dart';
import 'package:notr/views/widgets/width_constrained_box/width_constrained_box.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final _controller = const LoginPageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginPageState(),
      child: Builder(builder: (context) {
        final state = context.watch<LoginPageState>();

        if (state.isLoading) return const LoadingPage();

        if (state.unknownErrorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.unknownErrorMessage!)),
          );
        }

        return Scaffold(
          appBar: AppBar(),
          body: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: WidthConstrainedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 144),
                        child: TextField(
                          controller: state.emailController,
                          decoration: InputDecoration(
                            errorText: state.emailFieldErrorText,
                            labelText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          onChanged: (_) {
                            if (state.emailFieldErrorText != null) {
                              state.emailFieldErrorText = null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: TextField(
                          controller: state.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            errorText: state.passwordFieldErrorText,
                            labelText: "Password",
                            prefixIcon: const Icon(Icons.key_outlined),
                          ),
                          onChanged: (_) {
                            if (state.passwordFieldErrorText != null) {
                              state.passwordFieldErrorText = null;
                            }
                          },
                          onSubmitted: (_) => _controller.login(state),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 144),
                        child: ElevatedButton(
                          onPressed: () => _controller.login(state),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Text("LOGIN"),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
