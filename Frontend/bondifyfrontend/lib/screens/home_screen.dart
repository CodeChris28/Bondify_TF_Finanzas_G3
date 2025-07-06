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
        title: Text('Bondify - Home'),
        centerTitle: false,
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined))],
      ),
      body: Padding(padding: const EdgeInsets.all(10.0),
      child: bondoperations.isEmpty? Text('PLs CREATE A BOND OPERATION'):ListView.builder(itemCount: bondoperations.length, itemBuilder: (context, index)=>BondoperationitemWidget(bondOperation: bondoperations[index]),),),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      
    );
  }
}