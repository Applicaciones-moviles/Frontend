import 'package:carconnect_aplication/base/screens/cardescription.dart';
import 'package:carconnect_aplication/base/widgets/car_catalogue.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Catalogue extends StatefulWidget {
  const Catalogue({super.key});

  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  List<dynamic> cars = [];
  List<dynamic> filteredCars = [];
  List<String> brandOptions = [];
  String searchQuery = '';
  String? sortBy;
  String? selectedBrand;
  double minPrice = 0;
  double maxPrice = double.infinity;

  String processImgurUrl(String url) {
    String id = url.replaceAll('https://imgur.com/', '');
    if (id.contains('/a/')) {
      id = id.replaceAll('/a/', '');
    }
    id = id.split('/').last;
    id = id.split('.').first;
    return 'https://i.imgur.com/$id.jpeg';
  }

  String processImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return 'assets/carro.png';
    }
    String cleanUrl = imageUrl.trim();
    try {
      if (cleanUrl.contains('imgur.com')) {
        return processImgurUrl(cleanUrl);
      }
      Uri uri = Uri.parse(cleanUrl);
      if (!uri.hasScheme) {
        return 'assets/carro.png';
      }
      return cleanUrl;
    } catch (e) {
      print('Error processing image URL: $e');
      return 'assets/carro.png';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/vehicle');
    const String token =
        'eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJ1c3VhcmlvQGdtYWlsLmNvbSIsImlhdCI6MTczMDk1MjI4OCwiZXhwIjoxNzMxNTU3MDg4fQ.8cX5S2cEzNwQJwAPbeUJksaXiO-oKDVicM7Bfwiit8L50rr7f6anyTB8_XbEQ5JV';

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> carsData = json.decode(response.body);
        setState(() {
          cars = carsData.map((car) {
            car['UrlImage'] = processImageUrl(car['UrlImage']);
            return car;
          }).toList();

          brandOptions =
              cars.map((car) => car['Brand'] as String).toSet().toList();

          applySearchFilterSort();
        });
      } else {
        print('Failed to load cars. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching cars: $e');
    }
  }

  void applySearchFilterSort() {
    setState(() {
      filteredCars = cars.where((car) {
        final carName = car['Brand']?.toLowerCase() ?? '';
        final searchMatch = carName.contains(searchQuery.toLowerCase());
        final priceMatch =
            car['RentalCost'] >= minPrice && car['RentalCost'] <= maxPrice;
        final brandMatch =
            selectedBrand == null || car['Brand'] == selectedBrand;
        return searchMatch && priceMatch && brandMatch;
      }).toList();

      if (sortBy == 'Newest') {
        filteredCars.sort((a, b) => DateTime.parse(b['StartDate'])
            .compareTo(DateTime.parse(a['StartDate'])));
      } else if (sortBy == 'Oldest') {
        filteredCars.sort((a, b) => DateTime.parse(a['StartDate'])
            .compareTo(DateTime.parse(b['StartDate'])));
      } else if (sortBy == 'LowPrice') {
        filteredCars.sort(
                (a, b) => (a['RentalCost'] ?? 0).compareTo(b['RentalCost'] ?? 0));
      } else if (sortBy == 'HighPrice') {
        filteredCars.sort(
                (a, b) => (b['RentalCost'] ?? 0).compareTo(a['RentalCost'] ?? 0));
      }
    });
  }

  void setSortBy(String? criteria) {
    setState(() {
      sortBy = criteria;
      applySearchFilterSort();
    });
  }

  void setFilter(double min, double max) {
    setState(() {
      minPrice = min;
      maxPrice = max;
      applySearchFilterSort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                            FluentSystemIcons.ic_fluent_arrow_left_filled),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: const Color.fromARGB(255, 96, 123, 243),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: const Color(0xffF8F9FE),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                  FluentSystemIcons.ic_fluent_search_filled,
                                  size: 17),
                              const SizedBox(width: 5),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Buscar por marca",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (query) {
                                    setState(() {
                                      searchQuery = query;
                                      applySearchFilterSort();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String?>(
                        value: sortBy,
                        hint: const Text("Ordenar"),
                        items: [
                          DropdownMenuItem(
                              value: 'Newest', child: Text("Más Nuevo")),
                          DropdownMenuItem(
                              value: 'Oldest', child: Text("Más Viejo")),
                          DropdownMenuItem(
                              value: 'LowPrice', child: Text("Menor Precio")),
                          DropdownMenuItem(
                              value: 'HighPrice', child: Text("Mayor Precio")),
                        ],
                        onChanged: setSortBy,
                      ),
                      DropdownButton<String?>(
                        value: selectedBrand,
                        hint: const Text("Filtrar por Marca"),
                        items: brandOptions.map((brand) {
                          return DropdownMenuItem(
                            value: brand,
                            child: Text(brand),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBrand = value;
                            applySearchFilterSort();
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: filteredCars.length,
                      itemBuilder: (context, index) {
                        final car = filteredCars[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cardescription()),
                            );
                          },
                          child: CarCatalogue(
                            imageUrl: car['UrlImage'],
                            brand: car['Brand'] ?? 'Auto sin nombre',
                            rentalCost: car['RentalCost'].toString() ?? 'N/A',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}