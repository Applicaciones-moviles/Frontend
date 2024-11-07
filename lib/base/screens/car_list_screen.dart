import 'package:flutter/material.dart';
import 'my_cars_tab.dart';
import 'rentals_tab.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CarConnect'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.car_rental), text: 'Alquileres'),
            Tab(icon: Icon(Icons.directions_car), text: 'Mis Autos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RentalsTab(),
          MyCarsTab(),
        ],
      ),
    );
  }
}