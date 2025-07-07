// lib/screens/profile_screen.dart

import 'package:bondifyfrontend/widgets/bottom_navigation_bar_widget';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el proveedor de autenticación para acceder a los datos del usuario
    final authProvider = context.watch<AuthProvider>();
    // Obtenemos el email del usuario actual, o un texto por defecto si no está disponible
    final userEmail = authProvider.firebaseUser?.email ?? 'No disponible';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                'Sesión iniciada como:',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                userEmail,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar Sesión'),
                onPressed: () async {
                  // Llama al método signOut que creamos en el provider
                  await context.read<AuthProvider>().signOut();

                  // Navegamos de vuelta al login y eliminamos todas las pantallas anteriores del historial
                  // para que el usuario no pueda volver atrás.
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('loginScreen', (route) => false);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}