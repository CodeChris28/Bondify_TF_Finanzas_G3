import 'package:bondifyfrontend/screens/home_screen.dart';
import 'package:bondifyfrontend/screens/screens.dart';
import 'package:flutter/widgets.dart';


class AppRoutes {
    static String initialRoute = 'loginScreen';
    static Map<String, Widget Function(BuildContext)> getRoutes = {
        'homeScreen': (BuildContext context) => const HomeScreen(),
        'loginScreen': (BuildContext context) => const LoginScreen(),
        'createOperationsScreen': (BuildContext context) => const CreateOperationScreen(),
        'resultsScreen': (BuildContext context) => const ResultsScreen(),
    };

}