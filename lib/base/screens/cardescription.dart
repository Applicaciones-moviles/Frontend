import 'package:carconnect_aplication/base/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Cardescription extends StatefulWidget {
  @override
  _CardescriptionState createState() => _CardescriptionState();
}

class _CardescriptionState extends State<Cardescription> {
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
        title: Text('Car Description'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/carro.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Kia Sportage 18',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              'S/. ${120 * amountDays}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'SUV versátil, perfecto para viajes largos o escapadas de fin de semana. Equipado con tecnología avanzada, amplio espacio interior y un diseño moderno que garantiza confort y seguridad. Ideal para familias o grupos, con una excelente relación calidad-precio para alquiler por horas.',
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
