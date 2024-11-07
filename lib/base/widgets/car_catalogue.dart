import 'package:carconnect_aplication/base/res/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CarCatalogue extends StatelessWidget {
  const CarCatalogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF8F9FE),
      child: Column(
        children: [
          Container(
              height: 95,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/images/car.jpg'),
                fit: BoxFit.cover,
              ))),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Kia Sportage 2018"),
                  Text(
                    "S/.120",
                    textAlign: TextAlign.left,
                    style: AppStyles.headLineStyle4,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
