import 'package:flutter/material.dart';
import 'my_cars_tab.dart';
import 'rentals_tab.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CarConnect'),
      ),
      body: _selectedIndex == 0 ? RentalsTab() : MyCarsTab(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Alquileres',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Mis Autos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}