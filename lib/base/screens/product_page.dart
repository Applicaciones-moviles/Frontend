import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carconnect_aplication/base/components/my_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? _fileName;

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'CarConnect',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Contrato de alquiler del auto',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Entre el [Arrendador] DNI [DNI], y [Arrendatario] DNI [DNI], se acuerda el alquiler del vehículo [Vehiculo] con placa [Placa] bajo los siguientes términos:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Text(
              '1) Duración desde [Fecha de inicio] hasta [Fecha de finalización].\n'
                  '2) Renta Diaria: 250 soles.\n'
                  '3) Depósito: [Monto] soles.\n'
                  '4) Devolución: El vehículo debe devolverse en buen estado y con el mismo nivel de combustible.\n'
                  '5) Firmas Digitales: Ambas partes firman digitalmente este contrato.',
              style: TextStyle(fontSize: 16),
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
