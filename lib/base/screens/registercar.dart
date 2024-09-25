import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/custominput.dart';

class Registercar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registra tu auto',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Ingresa toda la información importante de tu vehículo',style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              //Marca y Modelo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Marca',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Marca'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los campos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Modelo',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Modelo'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              //Velocidad Maxima y Consumo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Velociad Max.',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Velociad Max.'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los campos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Consumo',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Consumo'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              //Largo/Ancho/Alto y Peso
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Largo/Ancho/Alto',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Largo/Ancho/Alto'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los campos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Peso',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Peso'),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              //Imagenes y Descripcion
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ajunta las imagenes de tu auto',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Implementar la acción de subir imagen
                              },
                              child: Text('Subir imagen'),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los campos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descripcion del auto',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Descripcion del auto'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              //Calendario
              Text('Días disponibles para alquilar',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: TableCalendar(
                  firstDay: DateTime.utc(2024, 9, 1),
                  lastDay: DateTime.utc(2024, 9, 30),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                ),
              ),
              SizedBox(height: 30),
              //Direccion y Placa
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dirección',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Dirección'),
                      ],
                    ),
                  ),
                  SizedBox(width: 10), // Espacio entre los campos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Placa',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        CustomInput(label: 'Placa'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              //Terminos y Condiciones
              Row(
                children: [
                  Checkbox(value: false, onChanged: (bool? value) {}),
                  Text('He leído y estoy de acuerdo con los términos y condiciones y la política de privacidad'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implementar la acción de previsualizar perfil
                },
                child: Text('Previsualizar mi perfil'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
