import 'package:flutter/material.dart';

/// Pantalla que se muestra mientras se determina el estado de autenticación del usuario.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
