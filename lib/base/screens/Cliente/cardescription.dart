import 'dart:io';
import 'package:carconnect_aplication/base/screens/Cliente/cart.dart';
import 'package:carconnect_aplication/base/screens/shared/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cardescription extends StatefulWidget {
  final String carId;

  const Cardescription({Key? key, required this.carId}) : super(key: key);

  @override
  _CardescriptionState createState() => _CardescriptionState();
}

class _CardescriptionState extends State<Cardescription> {
  DateTime selectedDate = DateTime.now();
  int amountDays = 1;
  Map<String, dynamic> carDetails = {};
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  bool isFavorite = false;

  void _showCalendar() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 400,
          child: Column(
            children: [
              Text(
                'Selecciona una fecha',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: selectedDate,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                  });
                  Navigator.pop(context);
                },
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDate, day);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCarDetails();
    fetchFavoriteCars();
  }

  Future<void> fetchCarDetails() async {
    final carId = widget.carId;

    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/vehicle/$carId'
    );
    String? token = await _storage.read(key: 'auth_token');
    if (token == null) {
      print('Token no disponible. El usuario no está autenticado.');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final carData = json.decode(response.body);
        print('Detalles del coche: $carData');
        setState(() {
          carDetails = carData;
        });
      } else {
        print('Failed to load car details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching car details: $e');
    }
  }

  Future<void> fetchFavoriteCars() async {
    final userId = await _storage.read(key: 'user_id');
    final token = await _storage.read(key: 'auth_token');

    if (userId == null || token == null) {
      print('User ID o Token no disponible. El usuario no está autenticado.');
      return;
    }

    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId/favorites');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Vehículos en favoritos: $data');


        final favoriteIds = List<int>.from(data.map((vehicle) => vehicle['id']));
        final currentCarId = int.parse(widget.carId);
        if (favoriteIds.contains(currentCarId)) {
          setState(() {
            isFavorite = true;
          });
        }
      } else {
        print('Error al cargar los favoritos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al hacer la solicitud de favoritos: $e');
    }
  }

  Future<void> toggleFavorite() async {
    final userId = await _storage.read(key: 'user_id');
    final token = await _storage.read(key: 'auth_token');

    if (userId == null || token == null) {
      print('User ID o Token no disponible. El usuario no está autenticado.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    }

    final vehicleId = widget.carId;

    if (isFavorite) {
      await removeFromFavorites(userId, token, vehicleId);
    } else {
      await addToFavorites(userId, token, vehicleId);
    }
  }


  Future<void> addToFavorites(String userId, String token,
      String vehicleId) async {
    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId/favorites');

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final body = json.encode({
      'vehicleId': vehicleId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        setState(() {
          isFavorite = true;
        });
        print('Vehículo agregado a favoritos');
      } else {
        print('Error al agregar a favoritos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al hacer POST de favoritos: $e');
    }
  }

  Future<void> removeFromFavorites(String userId, String token,
      String vehicleId) async {
    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId/favorites/vehicle/$vehicleId');

    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 204) {
        setState(() {
          isFavorite = false;
        });
        print('Vehículo eliminado de favoritos');
      } else {
        print('Error al eliminar de favoritos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al hacer DELETE de favoritos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Description'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            carDetails['UrlImage'] != null
                ? Image.network(
              carDetails['UrlImage'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            )
                : Container(
              height: 250,
              color: Colors.grey[300],
              child: Center(
                child: Text('Imagen no disponible'),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  carDetails['Brand'] ?? 'Marca no disponible',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: toggleFavorite,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Días por alquilar',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (amountDays > 1) amountDays--;
                        });
                      },
                    ),
                    Text('$amountDays', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          amountDays++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'S/. ${(carDetails['RentalCost'] ?? 120) * amountDays}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
                carDetails['Descripcion'] ?? 'Descripcion no disponible'
            ),
            SizedBox(height: 20),
            Text(
              'Presentaciones',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text('Velocidad máxima: 170 km/h\nConsumo: 9.7 l/100 km'),
            SizedBox(height: 10),
            Text(
              'Dimensiones',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text('Largo/Ancho/Alto: 5.325 / 1.855 / 1.815 mm\nPeso: 2.110 kg'),
            SizedBox(height: 10),
            Text(
              'Propietario',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text(
                'Nombre: Erick R.\nTeléfono: 9902229191\nCorreo: ericksl301@gmail.com'),
            SizedBox(height: 10),
            Text(
              'Alquiler',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text('Costo por mes: 800\nCosto por hora: 120'),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _showCalendar,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue, width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fecha de reserva: ${selectedDate.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.lightBlue),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cart()),
                );
              },
              child: Text('Continuar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}