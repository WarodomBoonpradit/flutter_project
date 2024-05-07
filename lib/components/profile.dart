import 'package:flutter/material.dart';
import 'package:flutter_project/components/page/loginPage.dart'; // นำเข้า LoginPage
import 'package:flutter_project/components/page/registerPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // สำหรับใช้ jsonDecode และ jsonEncode

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    // สร้าง URL สำหรับการล็อกอิน
    final url = Uri.parse('http://localhost:3000/users/login');

    // กำหนด headers และ body สำหรับคำขอ HTTP
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    // ส่งคำขอ POST ไปยัง URL ด้วย headers และ body
    final response = await http.post(url, headers: headers, body: body);

    // ตรวจสอบสถานะของคำตอบ
    if (response.statusCode == 200) {
      // การล็อกอินสำเร็จ
      final data = jsonDecode(response.body);
      
      // แสดงข้อความว่าการล็อกอินสำเร็จ
      _showSnackBar('Login successful!');
      
      // นำทางผู้ใช้ไปที่หน้า LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // การล็อกอินล้มเหลว
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['error'] ?? 'Login failed';
      
      // แสดงข้อความว่าการล็อกอินล้มเหลว
      _showSnackBar(errorMessage);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.lightBlue[50],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await login(); // เรียกฟังก์ชัน login แบบ asynchronous
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => registerPage(),
                          ),
                        );
                      },
                      child: const Text('ยังไม่มีบัญชี? สมัครสมาชิก'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
