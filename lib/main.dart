import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: SplashScreen(),
      routes: {
        '/login': (context) => login(),
        '/home': (context) => HomeScreen(username: ModalRoute.of(context)!.settings.arguments as String),
        '/profile': (context) => Profil(),  // Ensure this is properly defined
      },
    );
  }
}
