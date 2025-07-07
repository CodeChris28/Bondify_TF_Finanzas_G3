// lib/screens/home_screen.dart

import 'package:bondifyfrontend/providers/bondoperation_provider.dart';
import 'package:bondifyfrontend/providers/navigation_provider.dart';
import 'package:bondifyfrontend/widgets/bondoperationitem_widget.dart';
import 'package:bondifyfrontend/widgets/bottom_navigation_bar_widget';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bondoperationProvider = context.watch<BondoperationProvider>();
    final navProvider = context.watch<NavigationProvider>();
    final bondoperations = bondoperationProvider.bondOperations;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Operaciones'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Navega a la pantalla de perfil cuando se presiona el ícono
              Navigator.pushNamed(context, 'profileScreen');
            },
            icon: const Icon(Icons.person_2_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: bondoperations.isEmpty
            ? const Center(child: Text('Aún no tienes operaciones creadas.'))
            : ListView.builder(
                itemCount: bondoperations.length,
                itemBuilder: (context, index) => BondoperationitemWidget(
                    bondOperation: bondoperations[index]),
              ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}