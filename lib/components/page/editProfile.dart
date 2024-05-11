import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatefulWidget {
  final int id;
  final String email;
  final String fname;
  final String lname;
  final String address;
  final String avatar;

  EditProfilePage({
    required this.id,
    required this.email,
    required this.fname,
    required this.lname,
    required this.address,
    required this.avatar,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // สร้างตัวควบคุม TextEditingController สำหรับฟอร์ม
  late TextEditingController _emailController;
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _addressController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _avatarUrlController; // สำหรับ URL รูปภาพ

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นสำหรับตัวควบคุม TextEditingController
    _emailController = TextEditingController(text: widget.email);
    _fnameController = TextEditingController(text: widget.fname);
    _lnameController = TextEditingController(text: widget.lname);
    _addressController = TextEditingController(text: widget.address);
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _avatarUrlController = TextEditingController(text: widget.avatar);
  }

  // ฟังก์ชันสำหรับบันทึกการแก้ไขข้อมูลผู้ใช้งาน
  Future<void> saveProfile() async {
    // URL API สำหรับการอัปเดตข้อมูลผู้ใช้งาน
    final url = Uri.parse('http://localhost:3000/users/${widget.id}');

    // ตรวจสอบรหัสผ่านใหม่และรหัสผ่านยืนยันว่าตรงกัน
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    // สร้างข้อมูลที่ต้องการส่งไปยัง API เซิร์ฟเวอร์
    final body = {
      'email': _emailController.text,
      'fname': _fnameController.text,
      'lname': _lnameController.text,
      'address': _addressController.text,
      'avatar': _avatarUrlController.text,
    };

    if (_passwordController.text.isNotEmpty) {
      body['password'] = _passwordController.text;
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        print('Error: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile.')),
        );
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred while updating profile.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(11, 37, 69, 1.0),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.all(16.0), 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _fnameController,
                        decoration: const InputDecoration(
                          labelText: 'ชื่อ',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _lnameController,
                        decoration: const InputDecoration(
                          labelText: 'นามสกุล',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'ที่อยู่',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _avatarUrlController,
                        decoration: const InputDecoration(
                          labelText: 'รูปภาพ URL',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่านใหม่',
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'รหัสผ่านใหม่อีกครั้ง',
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: saveProfile,
                child: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันช่วยสร้าง TextField ด้วย BoxDecoration และเงา
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      height: 50, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
