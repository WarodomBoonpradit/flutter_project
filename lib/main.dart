import 'package:flutter/material.dart';
import 'package:flutter_project/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Kanit', // กำหนดค่า fontFamily เป็น 'Kanit'
        primaryColor: const Color.fromRGBO(19, 64, 116, 1.0),
        // เพิ่มการตั้งค่าอื่น ๆ ที่จำเป็นใน ThemeData ตามต้องการ
      ),
      home: SplashScreen(), // ระบุหน้าจอหลักของคุณ
    );
  }
}

