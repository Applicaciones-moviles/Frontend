import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. Objetivo del Servicio"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Esta aplicación permite a los usuarios alquilar vehículos por días con el fin de facilitar la movilidad de forma rápida y segura."),
              ),
              SizedBox(
                height: 15,
              ),
              Text("2. Requisitos del Usuario"),
              BulletedList(
                bullet: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 19,
                ),
                listItems: [
                  'Ser mayor de 21 años.',
                  'Contar con licencia de conducir vigente.',
                  'Presentar un documento de identidad oficial.',
                ],
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text("3. Política de Reservas y Pagos"),
              BulletedList(
                bullet: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 19,
                ),
                listItems: [
                  'El pago del alquiler se realizará por adelantado a través de los métodos habilitados en la app.',
                  'No se permite la modificación de reservas dentro de las 24 horas previas al inicio del alquiler.',
                ],
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text("4. Política de Cancelación"),
              BulletedList(
                bullet: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 19,
                ),
                listItems: [
                  'Cancelaciones realizadas con 48 horas de antelación tendrán reembolso completo.',
                  'Cancelaciones posteriores no tendrán derecho a reembolso.',
                ],
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text("5. Responsabilidad del Usuario"),
              BulletedList(
                bullet: Icon(
                  Icons.check,
                  color: Colors.black,
                  size: 19,
                ),
                listItems: [
                  'El usuario es responsable del estado del vehículo durante el periodo de alquiler.',
                  'En caso de daños o accidentes, el usuario deberá cubrir los costos según lo establecido en la póliza de seguro.',
                ],
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                  "6. Firma Digital"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Ambas partes deberán aceptar los términos mediante firma digital al momento de la reserva."),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


