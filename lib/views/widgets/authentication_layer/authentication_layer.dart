import 'package:flutter/material.dart';
import 'package:notr/services/authentication_service.dart';

class AuthenticationLayer extends StatefulWidget {
  const AuthenticationLayer({
    this.authService = const AuthenticationService(),
    super.key,
  });

  final AuthenticationService authService;

  @override
  State<AuthenticationLayer> createState() => _AuthenticationLayerState();
}

class _AuthenticationLayerState extends State<AuthenticationLayer> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
