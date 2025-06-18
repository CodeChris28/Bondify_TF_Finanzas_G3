import 'package:bondifyfrontend/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Bondify - Home'),
        centerTitle: false,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined))],
      ),
    );
  }
}