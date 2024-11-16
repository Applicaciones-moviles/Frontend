import 'package:flutter/material.dart';
import '../../models/car.dart';
import 'package:carconnect_aplication/base/screens/Due%C3%B1o%20de%20auto/registercar.dart';


class MyCarsTab extends StatelessWidget {
  final List<Car> myCars = [
    Car(imageUrl: 'https://example.com/car1.jpg', model: 'Kia Sportage 2021', color: 'Negro', licensePlate: 'TRS 998'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: myCars.length,
            itemBuilder: (context, index) {
              final car = myCars[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  leading: Image.network(car.imageUrl, width: 80, height: 60, fit: BoxFit.cover),
                  title: Text(car.model),
                  subtitle: Text('${car.color} / ${car.licensePlate}'),
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}