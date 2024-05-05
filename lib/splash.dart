import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
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
        decoration: const BoxDecoration(
          color: Color.fromRGBO(11, 37, 69, 1.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [              
              ClipOval(
                child: Image.network(
                  'https://cdn.discordapp.com/attachments/1215338957923942431/1236622795002220664/logo.png?ex=6638ae39&is=66375cb9&hm=8c6bb5e6a724cb6da4a93d4a9ee798f8147158129612f573b5341c416df97974&',
                  width: 220,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'MIGHTYGIZMOS',
                style: TextStyle(
                  fontSize: 24,                  
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
