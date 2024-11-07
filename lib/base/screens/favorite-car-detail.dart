import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FavoriteCarDetail extends StatefulWidget {
  @override
  _FavoriteCarDetailState createState() => _FavoriteCarDetailState();
}

class _FavoriteCarDetailState extends State<FavoriteCarDetail> {
  DateTime selectedDate = DateTime.now();
  int amountDays = 1;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('CarConnect', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/carro.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Kia Sportage 2018',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '€ 120.00',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'SUV versátil, perfecto para viajes largos o escapadas de fin de semana. Equipado con tecnología avanzada, amplio espacio interior y un diseño moderno que garantiza confort y seguridad. Ideal para familias o grupos, con una excelente relación calidad-precio para alquiler por horas.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Días por alquilar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('$amountDays d', style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Acción para ver el contrato de alquiler
              },
              child: Text(
                'Ver Contrato de Alquiler',
                style: TextStyle(color: Colors.lightBlue),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Presentaciones',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text(
              'Velocidad máxima: 170 km/h\nConsumo: 9.7 l/100 km',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Dimensiones',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text(
              'Largo/Ancho/Alto: 5.325 / 1.855 / 1.815 mm\nPeso: 2,110 kg',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Propietario',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text(
              'Nombre: Erick R.\nTeléfono: 9902229191\nCorreo: ericksl301@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Alquiler',
              style: TextStyle(
                  color: Colors.lightBlue, fontWeight: FontWeight.bold),
            ),
            Text(
              'Costo por mes: 800\nCosto por hora: 120',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Estado: Pendiente de completar',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
