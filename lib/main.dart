import 'package:flutter/material.dart';
import 'package:price_app/screens/splash_screen.dart';
import 'screens/registration_screen1.dart';
import 'screens/registration_screen2.dart';
import 'screens/registration_screen3.dart';

void main()=> runApp(MyApp());
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(), // Default route
        '/registration2': (context) => Registration2(), // Route for Registration2
        '/registration3': (context) => Registration3(), // Route for Registration3
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


