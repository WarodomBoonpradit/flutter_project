import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[200]!,
              Colors.lightBlue[50]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'MightyGizmos',    
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),           
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}