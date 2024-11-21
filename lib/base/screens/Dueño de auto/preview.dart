import 'package:carconnect_aplication/base/screens/Due%C3%B1o%20de%20auto/product_page_car_owner.dart';
import 'package:flutter/material.dart';

class PreviewCar extends StatelessWidget {
  final String brand;
  final String model;
  final String maxSpeed;
  final String consumption;
  final String dimensions;
  final String weight;
  final String pricePerDay;
  final String licensePlate;
  final String description;
  final String address;
  final String? imageUrl; // Aquí sigue siendo un String que representa la URL de la imagen
  final int availableDays;

  const PreviewCar({
    Key? key,
    required this.brand,
    required this.model,
    required this.maxSpeed,
    required this.consumption,
    required this.dimensions,
    required this.weight,
    required this.pricePerDay,
    required this.licensePlate,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.availableDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Usamos Image.network en lugar de Image.file
              imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              )
                  : Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 100, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text('$brand $model', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('S/.$pricePerDay', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(description, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 17),
              Text('Presentaciones', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text('Velocidad Máxima: $maxSpeed km/h', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text('Consumo: $consumption l/100 km', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              Text('Dimensiones', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text('Largo/Ancho/Alto: $dimensions mm', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              Text('Peso: $weight kg', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              Text('Días disponibles', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text('$availableDays día(s)', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),
              Text('Dirección', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Text('$address', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPageCarOwner(
                        vehiclePlate: licensePlate,
                        dailyRent: pricePerDay,
                        vehicleBrand: brand,
                        vehicleModel: model,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: const Text(
                    'Continuar con la creación',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
