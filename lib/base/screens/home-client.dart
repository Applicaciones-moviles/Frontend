import 'package:carconnect_aplication/base/screens/catalogue.dart';
import 'package:carconnect_aplication/base/screens/favorite-car-detail.dart'; // Importar FavoriteCarDetail
import 'package:carconnect_aplication/base/screens/cardescription.dart'; // Importar Cardescription
import 'package:flutter/material.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    RentCarsScreen(),
    FavoriteCarsScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CarConnect', style: TextStyle(color: Colors.black)),
          bottom: _selectedIndex == 0
              ? const TabBar(
            tabs: [
              Tab(text: 'Alquilar Autos'),
              Tab(text: 'Autos Favoritos'),
            ],
          )
              : null,
        ),
        body: _selectedIndex == 0
            ? const TabBarView(
          children: [
            RentCarsScreen(),
            FavoriteCarsScreen(),
          ],
        )
            : _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuración',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF006FFD),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class RentCarsScreen extends StatelessWidget {
  const RentCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        CarCard(
          imageUrl: 'https://example.com/car_image.png',
          title: 'Kia Sportage 2021',
          description: 'Negro / TRS 998',
          price: 'S/. 120.00',
          onPressedDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoriteCarDetail()),
            );
          },
        ),
        const Spacer(),
        Center(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Catalogue()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006FFD),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Ver Catálogo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FavoriteCarsScreen extends StatelessWidget {
  const FavoriteCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        CarCard(
          imageUrl: 'https://example.com/car_image.png',
          title: 'Kia Sportage 2021',
          description: 'Negro / TRS 998',
          price: 'S/. 120.00',
          onPressedDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cardescription()),
            );
          },
        ),
        const SizedBox(height: 16),
        CarCard(
          imageUrl: 'https://example.com/car_image.png',
          title: 'Kia Sportage 2023',
          description: 'Negro / TRS 998',
          price: 'S/. 220.00',
          onPressedDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cardescription()),
            );
          },
        ),
        const SizedBox(height: 16),
        CarCard(
          imageUrl: 'https://example.com/car_image.png',
          title: 'Kia Sportage 2023',
          description: 'Negro / TRS 998',
          price: 'S/. 220.00',
          onPressedDetails: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cardescription()),
            );
          },
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'Perfil de Usuario',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'Configuración',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final VoidCallback onPressedDetails;

  const CarCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onPressedDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(description),
              trailing: Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: onPressedDetails,
                  child: const Text('Ver más Detalles'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
