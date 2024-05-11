import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/components/home.dart';
import 'package:flutter_project/components/cart.dart';
import 'package:flutter_project/components/fav.dart';
import 'package:flutter_project/components/page/profilePage.dart';
import 'package:flutter_project/favorite_provider.dart';

class HomeScreen extends StatefulWidget {
    final int id;
    final String avatar;
    final String email;
    final String fname;
    final String lname;
    final String address;
    final String password;

    const HomeScreen({
        Key? key,
        required this.id,
        required this.fname,
        required this.lname,
        required this.address,
        required this.email,
        required this.password,
        required this.avatar,
    }) : super(key: key);

    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int _selectedIndex = 0;

    @override
    Widget build(Build_context) {
        return ChangeNotifierProvider(
            create: (context) => FavoriteProvider(),
            child: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    title: const Text(
                        'MIGHTYGIZMOS',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                        ),
                    ),
                    backgroundColor: const Color.fromRGBO(11, 37, 69, 1.0),
                ),
                body: IndexedStack(
                    index: _selectedIndex,
                    children: [
                        const Home(),
                        FavoritePage(),
                        CartPage(),
                        ProfilePage(id: widget.id), // ส่ง id ไปยัง ProfilePage
                    ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                        setState(() {
                            _selectedIndex = index;
                        });
                    },
                    items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined),
                            label: 'Home',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.favorite_outline),
                            label: 'Favorite',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_cart_outlined),
                            label: 'Cart',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline),
                            label: 'Profile',
                        ),
                    ],
                    unselectedItemColor: Colors.grey.withOpacity(0.5),
                    selectedItemColor: const Color.fromRGBO(19, 64, 116, 1.0),
                ),
            ),
        );
    }
}
