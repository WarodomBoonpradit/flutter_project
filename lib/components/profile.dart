import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ใช้ SingleChildScrollView สำหรับการเลื่อนหน้าในกรณีที่คีย์บอร์ดเปิดและช่องกรอกข้อมูลถูกบัง
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // เพิ่มช่องว่างระหว่างข้อความและช่องกรอกข้อมูล
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // เพิ่มช่องว่างระหว่างช่องกรอกข้อมูล
            TextField(
              obscureText: true, // ซ่อนรหัสผ่านเมื่อพิมพ์
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // เพิ่มช่องว่างระหว่างช่องกรอกข้อมูลและปุ่ม
            ElevatedButton(
              onPressed: () {
                // เพิ่มโค้ดที่นี่เมื่อปุ่มเข้าสู่ระบบถูกกด
                print('Login button pressed');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
