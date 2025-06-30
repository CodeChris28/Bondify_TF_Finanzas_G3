import 'package:bondifyfrontend/screens/home_screen.dart';
import 'package:flutter/widgets.dart';

import '../screens/login_screen.dart';

class AppRoutes {
    static String initialRoute = 'loginScreen';
    static Map<String, Widget Function(BuildContext)> getRoutes = {
        'homeScreen': (BuildContext context) => const HomeScreen(),
        'loginScreen': (BuildContext context) => const LoginScreen(),
    };

}