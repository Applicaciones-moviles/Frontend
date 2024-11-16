import 'package:carconnect_aplication/base/screens/Cliente/cart.dart';
import 'package:carconnect_aplication/base/screens/Cliente/catalogue.dart';
import 'package:carconnect_aplication/base/screens/shared/login_page.dart';
import 'package:carconnect_aplication/base/screens/Cliente/payment_card.dart';
import 'package:carconnect_aplication/base/screens/shared/product_page.dart';
import 'package:carconnect_aplication/base/screens/shared/register_page.dart';
import 'package:carconnect_aplication/base/screens/shared/settings.dart';
import 'package:carconnect_aplication/base/screens/Cliente/payment_user.dart';
import 'package:flutter/material.dart';
import 'base/screens/Cliente/cardescription.dart';
import 'base/screens/Cliente/home-client.dart';
import 'base/screens/Dueño de auto/home-car.dart';

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
      home: LoginPage(),
      routes: {
        //"/":(context)=> const Home(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
      },
    );
  }
}