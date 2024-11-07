class Car {
  final String imageUrl;
  final String model;
  final String color;
  final String licensePlate;
  final double? earnings;

  Car({
    required this.imageUrl,
    required this.model,
    required this.color,
    required this.licensePlate,
    this.earnings,
  });
}
