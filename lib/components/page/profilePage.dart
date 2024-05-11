import 'package:flutter/material.dart';
import 'package:flutter_project/components/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project/components/page/editProfile.dart'; // นำเข้า EditProfilePage

class ProfilePage extends StatefulWidget {
    final int id;

    ProfilePage({required this.id});

    @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
    Map<String, dynamic>? userData;

    @override
    void initState() {
        super.initState();
        fetchUserData();
    }

    Future<void> fetchUserData() async {
        final url = Uri.parse('http://localhost:3000/users/${widget.id}');

        try {
            final response = await http.get(url);

            if (response.statusCode == 200) {
                setState(() {
                    userData = jsonDecode(response.body);
                });
            } else {
                print('Error: ${response.statusCode}');
            }
        } catch (e) {
            print('Error fetching user data: $e');
        }
    }

    void logout() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
    }

    String hidePassword(String password) {
        return '•' * password.length;
    }

    void goToEditProfile() {
        if (userData != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                        id: widget.id,
                        email: userData!['email'],
                        fname: userData!['fname'],
                        lname: userData!['lname'],
                        address: userData!['address'],
                        avatar: userData!['avatar'],
                    ),
                ),
            ).then((result) {
                if (result != null && result) {
                    fetchUserData();
                }
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(            
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: userData != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                ClipOval(
                                    child: Image.network(
                                        userData!['avatar'],
                                        width: 150,
                                        height: 150, 
                                        fit: BoxFit.cover,
                                    ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            const Text(
                                                'ชื่อ: ',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            Text(
                                                '${userData!['fname'] ?? 'N/A'}',
                                                style: const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                                'นามสกุล: ',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            Text(
                                                '${userData!['lname'] ?? 'N/A'}',
                                                style: const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                                'ที่อยู่: ',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            Text(
                                                '${userData!['address'] ?? 'N/A'}',
                                                style: const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                                'Email: ',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            Text(
                                                '${userData!['email'] ?? 'N/A'}',
                                                style: const TextStyle(fontSize: 15),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                                'Password: ',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                            Text(
                                                hidePassword(userData!['password'] ?? ''),
                                                style: const TextStyle(fontSize: 15),
                                            ),
                                        ],
                                    ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        ElevatedButton(
                                            onPressed: goToEditProfile,
                                            child: const Text('แก้ไขโปรไฟล์'),
                                        ),
                                        const SizedBox(width: 20),
                                        ElevatedButton(
                                            onPressed: logout,
                                            child: const Text('ออกจากระบบ'),
                                        ),
                                    ],
                                ),
                            ],
                        )
                        : const Center(
                            child: CircularProgressIndicator(),
                        ),
                ),
            ),
        );
    }
}
