
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios en el provider para redibujar la UI cuando sea necesario
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bienvenido a Bondify',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Inicia sesión para gestionar tus bonos.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 48),

                  // --- Campo de Email ---
                  TextField(
                    controller: authProvider.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo Electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Campo de Contraseña ---
                  TextField(
                    controller: authProvider.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Mensaje de Error ---
                  // Se mostrará solo si hay un mensaje de error en el provider
                  if (authProvider.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Center(
                        child: Text(
                          authProvider.errorMessage!,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                  // --- Botón de Iniciar Sesión ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null // Deshabilita el botón si está cargando
                          : () async { // 1. La función ahora es asíncrona
                              
                              // 2. Llama al provider y espera el resultado (true o false)
                              final bool success = await context.read<AuthProvider>().signInWithEmailAndPassword();

                              // 3. Si el login fue exitoso Y el widget todavía está en pantalla...
                              if (success && context.mounted) {
                                // 4. ...navega a la 'homeScreen', reemplazando la pantalla actual.
                                Navigator.pushReplacementNamed(context, 'homeScreen');
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      child: authProvider.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Iniciar Sesión',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // --- Botón para ir a Registro ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('¿No tienes una cuenta?'),
                      TextButton(
                        onPressed: () {
                          // Aquí pondremos la navegación a la pantalla de registro
                          // Navigator.pushNamed(context, 'registerScreen');
                        },
                        child: const Text(
                          'Regístrate aquí',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
