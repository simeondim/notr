import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notr/services/authentication_service.dart';

class AuthenticationLayer extends StatefulWidget {
  const AuthenticationLayer({
    required this.unauthenticated,
    required this.authenticated,
    this.authService = const AuthenticationService(),
    super.key,
  });

  final AuthenticationService authService;
  final Widget authenticated;
  final Widget unauthenticated;

  @override
  State<AuthenticationLayer> createState() => _AuthenticationLayerState();
}

class _AuthenticationLayerState extends State<AuthenticationLayer> {
  User? user;

  @override
  void initState() {
    widget.authService.listenForAuthStateChanges(_onAuthChanged);
    super.initState();
  }

  void _onAuthChanged(User? newUser) => setState(() => user = newUser);

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return SizedBox(
        key: const Key('authenticatedWidget'),
        child: widget.authenticated,
      );
    }

    return SizedBox(
      key: const Key("unauthenticatedWidget"),
      child: widget.unauthenticated,
    );
  }
}
