import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/bondoperation_model.dart';

// Este provider ahora se encargará de todas las operaciones CRUD (Crear, Leer, Actualizar, Eliminar)
// para las operaciones de bonos en Firestore.
class BondoperationProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // La lista de operaciones ahora se cargará desde la base de datos.
  List<BondOperation> bondOperations = [];

  // El constructor ahora escucha los cambios de autenticación.
  // Cuando un usuario inicia sesión, automáticamente se cargan sus operaciones.
  BondoperationProvider() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        fetchOperations(user.uid);
      } else {
        // Si el usuario cierra sesión, limpiamos la lista.
        bondOperations.clear();
        notifyListeners();
      }
    });
  }

  // --- MÉTODO PARA LEER LAS OPERACIONES ---
  // Obtiene todas las operaciones de un usuario específico desde Firestore.
  Future<void> fetchOperations(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('bondOperations') // Busca en la colección 'bondOperations'
          .where('userId', isEqualTo: userId) // Filtra para traer solo las de este usuario
          .get();

      // Convierte cada documento de Firestore en un objeto BondOperation de nuestro modelo.
      bondOperations = snapshot.docs.map((doc) {
        return BondOperation.fromMap(doc.data(), doc.id);
      }).toList();

      notifyListeners(); // Avisa a la UI que hay nuevos datos para mostrar.
    } catch (e) {
      print("Error al obtener las operaciones: $e");
    }
  }

  // --- MÉTODO PARA AÑADIR UNA NUEVA OPERACIÓN (EL PASO CLAVE) ---
  // Este es el método que llamará nuestro formulario.
  Future<void> addOperation(BondOperation operation) async {
    try {
      // ¡AQUÍ ESTÁ LA MAGIA!
      // Esta línea le dice a Firestore:
      // 1. Ve a la colección 'bondOperations'.
      // 2. Si no existe, créala.
      // 3. Añade un nuevo documento con los datos de nuestro objeto 'operation'.
      await _firestore.collection('bondOperations').add(operation.toMap());

      // Después de guardar, volvemos a cargar la lista para que se refleje en la HomeScreen.
      // Es importante obtener el `userId` del objeto que estamos guardando.
      await fetchOperations(operation.userId);

    } catch (e) {
      print("Error al añadir la operación: $e");
    }
  }

  // --- MÉTODO PARA ELIMINAR UNA OPERACIÓN ---
  Future<void> deleteBondOperation(String operationId) async {
    try {
      await _firestore.collection('bondOperations').doc(operationId).delete();
      // Eliminamos la operación de la lista local para una respuesta visual inmediata.
      bondOperations.removeWhere((op) => op.id == operationId);
      notifyListeners();
    } catch (e) {
      print("Error al eliminar la operación: $e");
    }
  }
}
