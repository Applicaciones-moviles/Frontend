import 'package:carconnect_aplication/base/screens/Cliente/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Cart extends StatefulWidget {
  final String imageUrl;
  final String brand;
  final String model;
  final String licensePlate;
  final double rentalCost;
  final DateTime startDate;
  final DateTime endDate;

  const Cart({
    super.key,
    required this.imageUrl,
    required this.brand,
    required this.model,
    required this.licensePlate,
    required this.rentalCost,
    required this.startDate,
    required this.endDate,
  });

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? customerName;
  String? customerDNI;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    // Leer datos del cliente desde FlutterSecureStorage
    final name = await _storage.read(key: 'user_name');
    final phone = await _storage.read(key: 'user_phone');

    setState(() {
      customerName = name ?? "Nombre no disponible";
      customerDNI = phone ?? "Teléfono no disponible";
    });
  }

  @override
  Widget build(BuildContext context) {
    final int rentalDays = widget.endDate.difference(widget.startDate).inDays + 1;
    final double totalPrice = rentalDays * widget.rentalCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tu Carrito",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 96, 123, 243),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 19.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color.fromARGB(38, 7, 7, 7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 130,
                          height: 110,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: widget.imageUrl.isNotEmpty
                                  ? NetworkImage(widget.imageUrl)
                                  : const AssetImage('assets/images/car.jpg')
                              as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 11),
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(const Size(161, 110)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.brand} ${widget.model}",
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Placa: ${widget.licensePlate}",
                                style: const TextStyle(
                                  color: Color.fromARGB(122, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Precio Total",
                                    style: TextStyle(fontSize: 13.0),
                                  ),
                                  Text(
                                    "S/.${totalPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 19.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, -1),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 15.0, color: Color.fromARGB(143, 0, 0, 0)),
                      ),
                      Text(
                        "S/.${totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff006FFD),
                    ),
                    onPressed: customerName != null && customerDNI != null
                        ? () => _navigateToProductPage(context)
                        : null,
                    child: const Text(
                      "Continuar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(
          lessorName: customerName ?? "Nombre no disponible",
          lessorDni: customerDNI ?? "Teléfono no disponible",
          vehicleModel: widget.model,
          vehicleBrand: widget.brand,
          licensePlate: widget.licensePlate,
          startDate: widget.startDate.toLocal().toString().split(' ')[0],
          endDate: widget.endDate.toLocal().toString().split(' ')[0],
          dailyRent: widget.rentalCost,
        ),
      ),
    );
  }
}
