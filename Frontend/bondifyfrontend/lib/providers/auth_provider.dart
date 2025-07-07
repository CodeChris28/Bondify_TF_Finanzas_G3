// lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  firebase_auth.User? _firebaseUser;
  bool _isLoading = false;
  String? _errorMessage;

  firebase_auth.User? get firebaseUser => _firebaseUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    print("[AuthProvider] Inicializado. Escuchando cambios de autenticación...");
    _firebaseAuth.authStateChanges().listen((firebase_auth.User? user) {
      if (user != null) {
        print("[AuthProvider] ¡Usuario detectado! UID: ${user.uid}");
      } else {
        print("[AuthProvider] No hay usuario. Estado de sesión cerrado.");
      }
      _firebaseUser = user;
      if (user == null) {
        clearControllers();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }


Future<bool> signInWithEmailAndPassword() async {
  _setLoading(true);
  _setErrorMessage(null);
  try {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    // Si la línea de arriba no dio error, el login fue exitoso.
    _setLoading(false); // Detenemos la carga
    return true; // <-- Devolvemos 'true' para avisar del éxito
  } on firebase_auth.FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'invalid-email' || e.code == 'invalid-credential') {
      _setErrorMessage('Correo o contraseña incorrectos.');
    } else {
      _setErrorMessage('Ocurrió un error al iniciar sesión.');
    }
    _setLoading(false); // Detenemos la carga
    return false; // <-- Devolvemos 'false' para avisar del error
  }
}

Future<void> signOut() async {
    // Limpiamos los controladores de texto por si acaso
    clearControllers();
    // Usamos el método de Firebase para cerrar la sesión actual
    await _firebaseAuth.signOut();
    // El listener `authStateChanges` en el constructor se encargará del resto
  }

}