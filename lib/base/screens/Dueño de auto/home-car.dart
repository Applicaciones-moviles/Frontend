import 'package:carconnect_aplication/base/screens/Cliente/cardescription.dart';
import 'package:carconnect_aplication/base/screens/Due%C3%B1o%20de%20auto/registercar.dart';
import 'package:carconnect_aplication/base/screens/shared/profile.dart';
import 'package:carconnect_aplication/base/screens/shared/settings.dart';
import 'package:flutter/material.dart';
import 'package:carconnect_aplication/base/screens/Cliente/catalogue.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class MyCarsScreen extends StatefulWidget {
  const MyCarsScreen({super.key});

  @override
  _MyCarsScreenState createState() => _MyCarsScreenState();
}

class _MyCarsScreenState extends State<MyCarsScreen> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  List<dynamic> userVehicles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserVehicles();
  }

  Future<void> _fetchUserVehicles() async {
    final userId = await _storage.read(key: 'user_id');
    final token = await _storage.read(key: 'auth_token');

    if (userId == null || token == null) {
      print('User ID o Token no disponible. El usuario no está autenticado.');
      return;
    }

    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId/vehicles');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userVehicles = data;
          isLoading = false;
        });
      } else {
        print('Error al cargar los vehículos: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error al hacer la solicitud: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userVehicles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.car_rental, size: 100, color: Colors.grey),
            const SizedBox(height: 10),
            const Text(
              'Aún no tienes vehículos registrados.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Agrega vehículos a tu cuenta para comenzar a gestionarlos.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            const Text(
              'Añade más autos para ser alquilados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registercar()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Añadir auto',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Si hay vehículos, mostramos la lista de vehículos
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: userVehicles.length + 1, // +1 para agregar el botón al final
      itemBuilder: (context, index) {
        if (index < userVehicles.length) {
          // Mostrar los vehículos
          final vehicle = userVehicles[index];
          return CarCard(
            imageUrl: vehicle['UrlImage'] ?? '',
            title: vehicle['Brand'] ?? 'Marca no disponible',
            description: vehicle['Descripcion'] ?? 'Descripción no disponible',
            price: 'S/. ${vehicle['RentalCost'] ?? 0}',
            onPressedDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cardescription(carId: vehicle['id'].toString()),
                ),
              );
            },
          );
        } else {
          // Mostrar el mensaje y el botón "Añadir auto" al final
          return Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Añade más autos para ser alquilados',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registercar()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Añadir auto',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }
      },
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
