import 'package:flutter/material.dart';

Widget homeClient() {
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
              Tab(text: 'Alquilar Autos'),
              Tab(text: 'Autos Favoritos'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RentCarsScreen(),
            FavoriteCarsScreen(),
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

class RentCarsScreen extends StatelessWidget {
  const RentCarsScreen({super.key});

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
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FFD),
              foregroundColor: Colors.white,
            ),
            child: const Text('Ver Catálogo'),
          )
        ],
      ),
    );
  }
}

class FavoriteCarsScreen extends StatelessWidget {
  const FavoriteCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.favorite, size: 100, color: Colors.pink),
          const Text(
            'Aún no tienes autos favoritos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Explora nuestro catálogo guarda todos los autos de tu interés',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FFD),
              foregroundColor: Colors.white,
            ),
            child: const Text('Ver Catálogo'),
          )
        ],
      ),
    );
  }
}
