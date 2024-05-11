import 'package:flutter/material.dart';
import 'package:flutter_project/components/page/registerPage.dart';
import 'package:flutter_project/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    final url = Uri.parse('http://localhost:3000/users/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
    });

    try {
        final response = await http.post(url, headers: headers, body: body);
        final data = jsonDecode(response.body);
        
        if (response.statusCode == 200) {
            final user = data['user'];
            if (user != null) {
                final userId = user['id'];                
                final fname = user['fname'];
                final lname = user['lname'];
                final address = user['address'];
                final email = user['email'];
                final password = user['password'];
                final avatar = user['avatar'];
                
                _showSnackBar('Login successful!');

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen(
                        id: userId,
                        fname: fname,
                        lname: lname,
                        address: address,                
                        email: email,
                        password: password,
                        avatar: avatar
                    )),
                );
            } else {
                _showSnackBar('User data not found');
            }
        } else {
            final errorData = jsonDecode(response.body);
            final errorMessage = errorData['error'] ?? 'Login failed';
            _showSnackBar(errorMessage);
        }
    } catch (e) {
        print('Error during login: $e');
        _showSnackBar('เกิดข้อผิดพลาดในการเชื่อมต่อ');
    }
}


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromRGBO(11, 37, 69, 1.0),
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Container(
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
                child: Form(
                  key: _formKey,
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
                            return 'Please enter a valid email';
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
                              await login();
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
                              builder: (context) => const registerPage(),
                            ),
                          );
                        },
                        child: const Text('ยังไม่มีบัญชี? สมัครสมาชิก'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}