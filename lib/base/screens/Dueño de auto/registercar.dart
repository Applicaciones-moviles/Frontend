import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:carconnect_aplication/base/screens/Dueño de auto/custominput.dart';
import 'package:carconnect_aplication/base/screens/Dueño de auto/preview.dart'; // Importa la clase PreviewCar

class Registercar extends StatefulWidget {
  const Registercar({Key? key}) : super(key: key);

  @override
  _RegistercarState createState() => _RegistercarState();
}

class _RegistercarState extends State<Registercar> {
  DateTime? _startDate;
  DateTime? _endDate;
  File? _selectedImage;
  int _selectedDays = 1; // Días disponibles para alquilar (valor inicial)

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
                    child: Custominput(
                      label: 'Marca',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Custominput(
                      label: 'Modelo',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Velocidad Maxima y Consumo
              Row(
                children: [
                  Expanded(
                    child: Custominput(
                      label: 'Velocidad Máx.',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Custominput(
                      label: 'Consumo',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Largo/Ancho/Alto y Peso
              Row(
                children: [
                  Expanded(
                    child: Custominput(
                      label: 'Largo/Ancho/Alto',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Custominput(
                      label: 'Peso',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Precio por día y Placa
              Row(
                children: [
                  Expanded(
                    child: Custominput(
                      label: 'Precio por día',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Custominput(
                      label: 'Placa',
                    ),
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
                    child: Custominput(
                      label: 'Descripción del Auto',
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
              // Dirección
              Custominput(label: 'Dirección'),
              const SizedBox(height: 20),
              // Términos y Condiciones
              Row(
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewCar(), // Navega a la clase PreviewCar
                    ),
                  );
                },
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
}
