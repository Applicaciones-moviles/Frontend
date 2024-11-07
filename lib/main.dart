import 'package:carconnect_aplication/base/screens/cart.dart';
import 'package:carconnect_aplication/base/screens/catalogue.dart';
import 'package:carconnect_aplication/base/screens/login_page.dart';
import 'package:carconnect_aplication/base/screens/payment_card.dart';
import 'package:carconnect_aplication/base/screens/register_page.dart';
import 'package:carconnect_aplication/base/screens/settings.dart';
import 'package:carconnect_aplication/base/screens/welcome.dart';
import 'package:carconnect_aplication/base/screens/payment_user.dart';
import 'package:flutter/material.dart';
import 'base/screens/cardescription.dart';
import 'base/screens/home-client.dart';
import 'base/screens/home-car.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        fontFamily: 'Roboto',                                                                                                                               colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Settings(),
      routes: {
        //"/":(context)=> const Home(),
        "/login": (context) => LoginPage(),
        "/welcome": (context) => const Welcome(),
        "/register": (context) => RegisterPage(),
      },
    );
  }
}