import 'package:carconnect_aplication/base/screens/profile.dart';
import 'package:carconnect_aplication/base/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:carconnect_aplication/base/screens/catalogue.dart';

class HomeCar extends StatefulWidget {
  const HomeCar({super.key});

  @override
  State<HomeCar> createState() => _HomeCarState();
}

class _HomeCarState extends State<HomeCar> {
  int _selectedIndex = 1; // Inicializa en la vista de Inicio

  // Definir las páginas para navegar
  static const List<Widget> _pages = <Widget>[
    ProfileScreen(), // Pantalla de Perfil
    HomeCarMain(), // Pantalla de Inicio (HomeCar)
    Settings(), // Pantalla de Configuración
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
        appBar: _selectedIndex == 1
            ? AppBar(
          title: const Text('CarConnect', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Alquileres'),
              Tab(text: 'Mis Autos'),
            ],
          ),
        )
            : null,
        body: _selectedIndex == 1
            ? const HomeCarMain() // Cuando se está en la vista principal de HomeCar
            : _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil', // Índice 0 para navegar a `ProfileScreen`
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio', // Índice 1 para navegar a `HomeCarMain`
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configuración', // Índice 2 para navegar a `Settings`
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

// Nueva clase para la pantalla principal de HomeCar
class HomeCarMain extends StatelessWidget {
  const HomeCarMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      children: [
        RentalsScreen(), // Pantalla de Alquileres
        MyCarsScreen(), // Pantalla de Mis Autos
      ],
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
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        CarCard(
          imageUrl: 'https://example.com/car_image.png',
          title: 'Kia Sportage 2021',
          description: 'Negro / TRS 998',
          price: 'S/. 120.00',
          onPressedDetails: () {
            // Aquí puedes añadir la lógica para ver los detalles del coche.
          },
        ),
        const SizedBox(height: 16),
        CarCard(
          imageUrl: 'https://example.com/car_image2.png',
          title: 'Toyota Corolla 2022',
          description: 'Blanco / ABC 123',
          price: 'S/. 150.00',
          onPressedDetails: () {
            // Aquí puedes añadir la lógica para ver los detalles del coche.
          },
        ),
      ],
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
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: onPressedDetails,
                      child: const Text('Ver más Detalles'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
