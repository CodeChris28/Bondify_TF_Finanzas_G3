import 'package:bondifyfrontend/providers/bondoperation_provider.dart';
import 'package:bondifyfrontend/providers/navigation_provider.dart';
import 'package:bondifyfrontend/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider< NavigationProvider>(create: (_)=> NavigationProvider()),
        ChangeNotifierProvider< BondoperationProvider>(create: (_)=> BondoperationProvider()),
      ],
      child: MaterialApp( 
        title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: AppRoutes.getRoutes,
      initialRoute: AppRoutes.initialRoute,
      ),    
    );
  }
}
