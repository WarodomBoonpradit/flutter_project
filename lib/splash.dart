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
                  'https://cdn.discordapp.com/attachments/1215338957923942431/1236622795002220664/logo.png?ex=6639ffb9&is=6638ae39&hm=140b50c521726d9105cefb807cbd40b8e6cc1f35f1f8b16424d67b6350fea551&',
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
