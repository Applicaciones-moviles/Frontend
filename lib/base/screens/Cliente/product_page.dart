import 'package:carconnect_aplication/base/screens/Cliente/payment_user.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:carconnect_aplication/base/components/my_button.dart';

class ProductPage extends StatefulWidget {
  final String lessorName;
  final String lessorDni;
  final String vehicleModel;
  final String vehicleBrand;
  final String licensePlate;
  final String startDate;
  final String endDate;
  final double dailyRent;

  const ProductPage({
    Key? key,
    required this.lessorName,
    required this.lessorDni,
    required this.vehicleModel,
    required this.vehicleBrand,
    required this.licensePlate,
    required this.startDate,
    required this.endDate,
    required this.dailyRent,
  }) : super(key: key);

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
      appBar: AppBar(),
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
              'Entre ${widget.lessorName}, DNI ${widget.lessorDni}, y [Arrendatario], '
                  'se acuerda el alquiler del vehículo ${widget.vehicleBrand} ${widget.vehicleModel} '
                  'con placa ${widget.licensePlate} bajo los siguientes términos:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Text(
              '1. Duración desde ${widget.startDate} hasta ${widget.endDate}.\n'
                  '2. Renta Diaria: ${widget.dailyRent.toStringAsFixed(2)} soles.\n'
                  '3. Devolución: El vehículo debe devolverse en buen estado y con el mismo nivel de combustible.\n'
                  '4. Firmas Digitales: Ambas partes firman digitalmente este contrato.',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentUser()),
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
