import 'package:flutter/material.dart';

Widget homeCar() {
  return MaterialApp(
    title: 'CarConnect',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF006FFD),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: Colors.black54,
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 2),
          ),
        ),
      ),
    ),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CarConnect', style: TextStyle(color: Colors.black)),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Alquileres'),
              Tab(text: 'Mis Autos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RentalsScreen(),
            MyCarsScreen(),
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
          selectedItemColor: Color(0xFF006FFD),
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.directions_car, size: 100, color: Colors.blue),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Aún no cuentas con solicitudes de alquiler para tu vehículo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class MyCarsScreen extends StatelessWidget {
  const MyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.car_rental, size: 100, color: Colors.pink),
          const Text(
            'Aún no cuentas con un auto alquilado',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explora nuestro catálogo y escoge tu opción deseada.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement navigation or other functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FFD),
              foregroundColor: Colors.white,
            ),
            child: const Text('Añadir auto'),
          )
        ],
      ),
    );
  }
}
