import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ(Preguntas Frecuentes)'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("1. ¿Cómo puedo alquilar un auto?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Debes registrarte en la app, seleccionar el vehículo, las fechas de alquiler y completar el pago en línea."),
              ),
              SizedBox(
                height: 15,
              ),
              Text("2. ¿Qué documentos necesito?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Una licencia de conducir válida y un documento de identidad oficial."),
              ),
              SizedBox(
                height: 15,
              ),
              Text("3. ¿Puedo cancelar o modificar una reserva?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Sí, puedes cancelar hasta 48 horas antes del inicio del alquiler con reembolso total. Las modificaciones deben hacerse al menos 24 horas antes."),
              ),
              SizedBox(
                height: 15,
              ),
              Text("4. ¿Qué pasa si el auto tiene daños?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Si se detectan daños durante tu uso, deberás cubrir los costos de reparación, ya sea mediante el seguro o directamente."),
              ),
              SizedBox(
                height: 15,
              ),
              Text("5. ¿Los autos tienen seguro?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Sí, todos los autos incluyen una póliza de seguro que cubre daños y accidentes bajo ciertas condiciones."),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "6. ¿Hay un límite de kilometraje?"),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(17, 5, 0, 0),
                child: Text(
                    "Dependiendo del plan de alquiler, puede existir un límite. Se te notificará al momento de hacer la reserva."),
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