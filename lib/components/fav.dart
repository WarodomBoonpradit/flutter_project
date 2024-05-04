import 'package:flutter/material.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
} 

class _FavState extends State<Fav> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Index 1: Fav testing',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}