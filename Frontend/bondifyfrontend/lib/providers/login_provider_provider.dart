import 'package:flutter/material.dart';


class LoginProvider extends ChangeNotifier {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading; // Getter público para acceder al estado de carga

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // ¡La magia de Provider! Notifica a los widgets que el estado cambió.
  }

  // 2. LA LÓGICA DE NEGOCIO VIVE AQUÍ
  Future<void> loginUser() async {
    // Si ya está cargando, no hacer nada
    if (_isLoading) return;

    _setLoading(true);

    try {
      // Obtenemos los valores de los controladores
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      print('Intentando iniciar sesión con: $email');

      // --- AQUÍ IRÁ LA LÓGICA DE FIREBASE AUTH ---
      // Por ahora, simulamos una llamada a la red que dura 2 segundos
      await Future.delayed(const Duration(seconds: 2));
      
      print('¡Inicio de sesión simulado exitosamente!');
      
      // Si el login es exitoso, aquí navegaríamos a la pantalla principal.

    } catch (e) {
      print('Error en el inicio de sesión: $e');
      // Aquí mostraríamos un SnackBar o un diálogo con el error.
    } finally {
      // Este bloque se ejecuta siempre, haya éxito o error.
      // Nos aseguramos de que el indicador de carga se oculte.
      _setLoading(false);
    }
  }

  // 3. MÉTODO DE LIMPIEZA
  // Sobrescribimos el método dispose para limpiar nuestros controladores.
  // Provider se encargará de llamar a este método cuando ya no se necesite.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}