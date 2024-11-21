import 'package:carconnect_aplication/base/screens/Due%C3%B1o%20de%20auto/home-car.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPageCarOwner extends StatefulWidget {
  final String vehiclePlate;
  final String dailyRent;
  final String vehicleBrand; // Nueva propiedad para la marca
  final String vehicleModel; // Nueva propiedad para el modelo

  const ProductPageCarOwner({
    super.key,
    required this.vehiclePlate,
    required this.dailyRent,
    required this.vehicleBrand, // Inicializar marca
    required this.vehicleModel, // Inicializar modelo
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPageCarOwner> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String? _fileName;
  String? _landlordName = "Cargando...";
  String? _landlordDni = "Cargando...";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final token = await _storage.read(key: 'auth_token');
    final userId = await _storage.read(key: 'user_id');

    if (token == null || userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: no se pudo autenticar al usuario.')),
      );
      return;
    }

    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _landlordName = data['username'];
          _landlordDni = data['dni'];
        });
      } else {
        print('Error al obtener datos del usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      if (file.size <= 5 * 1024 * 1024) {
        setState(() {
          _fileName = file.name;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El archivo no puede ser mayor a 5 MB'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarConnect - Contrato de Alquiler'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'CarConnect',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contrato de Alquiler del Auto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Entre $_landlordName, DNI $_landlordDni, y [Cliente], DNI [Número], '
                  'se acuerda el alquiler del vehículo ${widget.vehicleBrand} ${widget.vehicleModel} '
                  'con placa ${widget.vehiclePlate} bajo los siguientes términos:',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              '1. Duración: desde [Fecha de inicio] hasta [Fecha de finalización].\n'
                  '2. Renta Diaria: ${widget.dailyRent} soles.\n'
                  '3. Devolución: El vehículo debe devolverse en buen estado y con el mismo nivel de combustible.\n'
                  '4. Firmas Digitales: Ambas partes firman digitalmente este contrato.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                MyButton(
                  text: _fileName ?? 'Adjuntar firma digital',
                  onPressed: _pickFile,
                ),
                const SizedBox(height: 20),
                MyButton(
                  text: 'Confirmar Creación del perfil',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeCar()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
