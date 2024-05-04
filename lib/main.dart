import 'package:flutter/material.dart';
import 'package:flutter_project/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Kanit',         
      ),
      home: const SplashScreen(),
    );
  }
}

