import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/components/home.dart';
import 'package:flutter_project/components/profile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    BusinessTab(),
    SchoolTab(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'MightyGizmos',
          style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color.fromRGBO(19, 64, 116, 1.0),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            print('Menu button pressed');
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // พื้นหลังสีขาว
          border: Border(
            top: BorderSide(
              color: Colors.black, // สีเส้นขอบด้านบน
              width:  0.25, // ความหนาของเส้นขอบ
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.grey.withOpacity(0.5), // ไอคอนโปร่งแสงเมื่อยังไม่ได้เลือก
          selectedItemColor: const Color.fromRGBO(19, 64, 116, 1.0), // สีดำเมื่อเลือกแท็บ
        ),
      ),
    );
  }
}



class BusinessTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Index 1: Business',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SchoolTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Index 2: School',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}