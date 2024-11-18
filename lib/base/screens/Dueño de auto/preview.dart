import 'package:carconnect_aplication/base/screens/Due%C3%B1o%20de%20auto/product_page_car_owner.dart';
import 'package:flutter/material.dart';

import '../Cliente/product_page.dart';
// Importa ProductPage (asegúrate de que esté en el archivo correcto)

class PreviewCar extends StatefulWidget {
  @override
  _PreviewCarState createState() => _PreviewCarState();
}

class _PreviewCarState extends State<PreviewCar> {
  int _rentalDays = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://example.com/car_image.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Kia Sportage 2018',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 8),
              Text(
                '€ 120.00',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Text(
                'SUV versátil, perfecto para viajes largos o escapadas de fin de semana. Equipado con tecnología avanzada, amplio espacio interior y un diseño moderno que garantiza confort y seguridad. Ideal para familias o grupos, con una excelente relación calidad-precio para alquiler por horas.',
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Días por alquilar',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline,
                            color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            if (_rentalDays > 1) {
                              _rentalDays--;
                            }
                          });
                        },
                      ),
                      Text('$_rentalDays', style: TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            _rentalDays++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              SizedBox(height: 16),
              Text(
                'Presentaciones',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Velocidad máxima: 170 km/h\nConsumo: 9.7 l/100 km',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Text(
                'Dimensiones',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Largo/Ancho/Alto: 5,325 / 1,855 / 1,815 mm\nPeso: 2,110 kg',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Días disponibles',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '31 días',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Dirección:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Jr. Las Palmeras 369',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPageCarOwner(), // Redirige a ProductPage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Continuar con la creación',
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
