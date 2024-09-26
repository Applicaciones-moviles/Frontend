import 'package:flutter/material.dart';

class Cardescription extends StatefulWidget {
  @override
  _CardescriptionState createState() => _CardescriptionState();
}

class _CardescriptionState extends State<Cardescription> {
  int amountDays = 1; // Variable para los días de alquiler
  double pricePerDay = 120.00; // Precio fijo por día

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Description'),
      ),
      body: SingleChildScrollView( // Añadido para permitir scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen principal en la parte superior
            Image.asset(
              'assets/carro.png',
              width: double.infinity, // Se ajusta al ancho del contenedor
              height: 200, // Ajusta la altura de la imagen
              fit: BoxFit.cover, // Asegura que la imagen cubra el espacio
            ),
            SizedBox(height: 16.0),
            // Título del coche
            Text(
              'Kia Sportage 18',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Días por alquilar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Días por alquilar:',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (amountDays > 1) {
                          setState(() {
                            amountDays--;
                          });
                        }
                      },
                    ),
                    Text(
                      '$amountDays',
                      style: TextStyle(fontSize: 16),
                    ),
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
            // Mostrar el precio calculado
            Text(
              'S/. ${(pricePerDay * amountDays).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20.0),
            // Descripción final
            Text(
              'SUV versátil, perfecto para viajes largos o escapadas de fin de semana. '
              'Equipado con tecnología avanzada, amplio espacio interior y un diseño moderno '
              'que garantiza confort y seguridad. Ideal para familias o grupos, con una excelente '
              'relación calidad-precio para alquiler por horas.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20.0), // Espacio antes de las secciones adicionales
            // Sección de Presentaciones
            _buildSectionTitle('Presentaciones'),
            _buildInfo('Velocidad máxima: 170 km/h'),
            _buildInfo('Consumo: 9.7 l/100 km'),
            SizedBox(height: 20.0), // Espacio entre secciones
            // Sección de Dimensiones
            _buildSectionTitle('Dimensiones'),
            _buildInfo('Largo/Ancho/Alto: 5.325 / 1.855 / 1.815 mm'),
            _buildInfo('Peso: 2.110 kg'),
            SizedBox(height: 20.0), // Espacio entre secciones
            // Sección de Propietario
            _buildSectionTitle('Propietario'),
            _buildInfo('Nombre: Erick R.'),
            _buildInfo('Teléfono: 9902229191'),
            _buildInfo('Correo: ericksl301@gmail.com'),
            SizedBox(height: 20.0), // Espacio entre secciones
            // Sección de Alquiler
            _buildSectionTitle('Alquiler'),
            _buildInfo('Costo por mes: 3600'),
            _buildInfo('Costo por dia: 120'),
          ],
        ),
      ),
    );
  }

  // Método para construir el título de la sección
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue, // Color azul claro
      ),
    );
  }

  // Método para construir la información
  Widget _buildInfo(String info) {
    return Text(
      info,
      style: TextStyle(fontSize: 16, color: Colors.black), // Color negro
    );
  }
}
