import 'package:flutter/material.dart';
import 'package:online_pharmacy_assignment/pages/HomeScreen.dart';
import 'package:online_pharmacy_assignment/pages/LoginScreen.dart';
import 'package:online_pharmacy_assignment/pages/UnderConstruction_Doctor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for Navigator',
      // MaterialApp contains our top-level Navigator
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const LoginScreen(),
        '/home': (BuildContext context) => const HomeScreen(),
        '/underconstructionDoctor': (BuildContext context) =>
            const UnderConstruction_Doctor(),
      },
    );
  }
}
