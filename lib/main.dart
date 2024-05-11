import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/splash.dart';
import 'package:flutter_project/favorite_provider.dart';
import 'package:flutter_project/cart_provider.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MultiProvider(
            providers: [
                ChangeNotifierProvider(create: (context) => FavoriteProvider()),
                ChangeNotifierProvider(create: (context) => CartProvider()),
            ],
            child: MaterialApp(
                title: 'Flutter App',
                theme: ThemeData(
                    fontFamily: 'Kanit',
                ),
                home: const SplashScreen(),
            ),
        );
    }
}


