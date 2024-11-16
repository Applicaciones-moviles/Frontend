import 'package:flutter/material.dart';

class Custominput extends StatelessWidget {
  final String label;
  final int? maxLines; // Add maxLines as a parameter

  const Custominput({
    Key? key,
    required this.label,
    this.maxLines = 1, // Default value of maxLines is 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines, // Set the maxLines property here
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
