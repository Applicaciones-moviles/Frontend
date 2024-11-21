import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'preview.dart';

class Registercar extends StatefulWidget {
  const Registercar({Key? key}) : super(key: key);

  @override
  _RegistercarState createState() => _RegistercarState();
}

class _RegistercarState extends State<Registercar> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _selectedDays = 1;
  bool _isTermsAccepted = false;

  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _maxSpeedController = TextEditingController();
  final TextEditingController _consumptionController = TextEditingController();
  final TextEditingController _dimensionsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _pricePerDayController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController(); // Controlador para la URL de la imagen

  String? _imageUrl;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<int?> _getUserId() async {
    String? userId = await _storage.read(key: 'user_id');
    return userId != null ? int.tryParse(userId) : null;
  }

  Future<void> _createVehicle() async {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos y condiciones.')),
      );
      return;
    }

    if (_imageUrl == null || _imageUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes proporcionar una URL de imagen.')),
      );
      return;
    }


    final String? _authToken = await _getToken();
    final int? _userId = await _getUserId();

    if (_authToken == null || _userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró un token de autenticación o user_id.')),
      );
      return;
    }


    final vehicleData = {
      "userId": _userId,
      "Brand": _brandController.text,
      "Model": _modelController.text,
      "Placa": _licensePlateController.text,
      "Descripcion": _descriptionController.text,
      "MaximumSpeed": int.tryParse(_maxSpeedController.text) ?? 0,
      "Consumption": int.tryParse(_consumptionController.text) ?? 0,
      "Weight": int.tryParse(_weightController.text) ?? 0,
      "Dimensions": _dimensionsController.text,
      "RentalCost": double.tryParse(_pricePerDayController.text) ?? 0,
      "UrlImage": _imageUrl,
      "RentStatus": "Disponible",
      "RentDays": _selectedDays,
      "Direccion": _addressController.text,
    };

    // Endpoint del API
    final url = Uri.parse('https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/vehicle');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_authToken',
        },
        body: json.encode(vehicleData),
      );

      if (response.statusCode == 201) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewCar(
              brand: _brandController.text,
              model: _modelController.text,
              maxSpeed: _maxSpeedController.text,
              consumption: _consumptionController.text,
              dimensions: _dimensionsController.text,
              weight: _weightController.text,
              pricePerDay: _pricePerDayController.text,
              licensePlate: _licensePlateController.text,
              description: _descriptionController.text,
              address: _addressController.text,
              imageUrl: _imageUrl,
              availableDays: _selectedDays,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode} - ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ocurrió un error al crear el vehículo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Información del Auto',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Completa la información obligatoria del auto.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              // Marca y Modelo
              Row(
                children: [
                  Expanded(
                    child: _buildInputField('Marca', _brandController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField('Modelo', _modelController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Velocidad Máxima y Consumo
              Row(
                children: [
                  Expanded(
                    child: _buildInputField('Velocidad Máx.', _maxSpeedController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField('Consumo', _consumptionController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Dimensiones y Peso
              Row(
                children: [
                  Expanded(
                    child: _buildInputField('Largo/Ancho/Alto', _dimensionsController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField('Peso', _weightController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Precio por día y Placa
              Row(
                children: [
                  Expanded(
                    child: _buildInputField('Precio por día', _pricePerDayController),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField('Placa', _licensePlateController),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // URL de la imagen y Descripción
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildInputField(
                      'URL de la imagen',
                      _imageUrlController,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildInputField(
                      'Descripción del Auto',
                      _descriptionController,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Días disponibles para alquilar
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Días disponibles para alquilar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: _selectedDays,
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedDays = newValue ?? 1;
                  });
                },
                items: List.generate(31, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1} días'),
                  );
                }),
              ),
              const SizedBox(height: 20),
              _buildInputField('Dirección', _addressController),
              const SizedBox(height: 20),
              // Términos y Condiciones
              Row(
                children: [
                  Checkbox(
                    value: _isTermsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        _isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'He leído y estoy de acuerdo con los Términos y Condiciones y la Política de Privacidad.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _createVehicle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Previsualizar mi auto',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      onChanged: (value) {
        if (label == 'URL de la imagen') {
          setState(() {
            _imageUrl = value;
          });
        }
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
