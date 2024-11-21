import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'preview.dart'; // Importa la clase PreviewCar

class Registercar extends StatefulWidget {
  const Registercar({Key? key}) : super(key: key);

  @override
  _RegistercarState createState() => _RegistercarState();
}

class _RegistercarState extends State<Registercar> {
  DateTime? _startDate;
  DateTime? _endDate;
  int _selectedDays = 1; // Días disponibles para alquilar (valor inicial)
  bool _isTermsAccepted = false; // Controla si se aceptaron los términos

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

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _navigateToPreview() {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes aceptar los términos y condiciones.')),
      );
      return;
    }

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
          image: _selectedImage,
          availableDays: _selectedDays, // Pasa los días seleccionados
        ),
      ),
    );
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
              // Imágenes del Auto y Descripción
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              image: _selectedImage != null
                                  ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: _selectedImage == null
                                ? const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Adjunta las imágenes de tu auto',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
              // Botón Previsualizar
              ElevatedButton(
                onPressed: _navigateToPreview,
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
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}