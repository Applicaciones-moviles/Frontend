import 'package:flutter/material.dart';
import 'base/screens/car_list_screen.dart'; // Import the CarListScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CarListScreen(), // Set CarListScreen as the home screen
    );
  }
}
