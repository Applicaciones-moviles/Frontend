import 'package:flutter/material.dart';
import '../models/car.dart';

class RentalsTab extends StatelessWidget {
  final List<Car> rentalCars = [
    //Car(imageUrl: 'https://example.com/car2.jpg', model: 'Kia Sportage 2021', color: 'Negro', licensePlate: 'TRS 998', earnings: 120.0),
    // Car(imageUrl: 'https://example.com/car3.jpg', model: 'Kia Sportage 2023', color: 'Negro', licensePlate: 'TRS 998', earnings: 240.0),
  ];

  @override
  Widget build(BuildContext context) {
    if (rentalCars.isEmpty) {
      return RentalsScreen();
    }

    return ListView.builder(
      itemCount: rentalCars.length,
      itemBuilder: (context, index) {
        final car = rentalCars[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            leading: Image.network(car.imageUrl, width: 80, height: 60, fit: BoxFit.cover),
            title: Text(car.model),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${car.color} / ${car.licensePlate}'),
                if (car.earnings != null)
                  Text('Ganancia Total: S/. ${car.earnings!.toStringAsFixed(2)}'),
                TextButton(
                  onPressed: () {},
                  child: Text('Comunicarme con el Cliente', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RentalsScreen extends StatelessWidget {
  const RentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(Icons.directions_car, size: 100, color: Colors.blue),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Aún no cuentas con solicitudes de alquiler para tu vehículo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}