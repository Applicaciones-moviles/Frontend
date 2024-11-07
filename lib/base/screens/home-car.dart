import 'package:flutter/material.dart';
import 'my_cars_tab.dart';
import 'rentals_tab.dart';

class HomeCar extends StatefulWidget {
  const HomeCar({super.key});

  @override
  State<HomeCar> createState() => _HomeCarState();
}

class _HomeCarState extends State<HomeCar> with SingleTickerProviderStateMixin {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CarConnect', style: TextStyle(color: Colors.black)),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedItemColor: const Color(0xFF006FFD),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}