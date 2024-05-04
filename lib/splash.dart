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
                  'https://cdn.discordapp.com/attachments/1215338957923942431/1236346595243462797/logo.png?ex=6637acfe&is=66365b7e&hm=b0a931e86a891713dbdb51aeed066c2e3877ed9189eaa2a7ff4fe0659e928817&', // URL ของรูปภาพที่คุณต้องการ
                  width: 200,
                  height: 200,
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
