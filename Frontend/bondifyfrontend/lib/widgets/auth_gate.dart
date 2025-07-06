// lib/widgets/auth_gate.dart

import 'package:bondifyfrontend/providers/auth_provider.dart';
import 'package:bondifyfrontend/screens/home_screen.dart';
import 'package:bondifyfrontend/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios en el AuthProvider
    final authProvider = context.watch<AuthProvider>();

    // Si el 'firebaseUser' del provider NO es nulo, significa que alguien inició sesión.
    if (authProvider.firebaseUser != null) {
      // Entonces, mostramos la pantalla principal.
      return const HomeScreen();
    } else {
      // Si es nulo, nadie ha iniciado sesión.
      // Entonces, mostramos la pantalla de login.
      return const LoginScreen();
    }
  }
}