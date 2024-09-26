import 'package:carconnect_aplication/base/widgets/car_catalogue.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class Catalogue extends StatelessWidget {
  const Catalogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: ListView(
          children: [
            const SizedBox(
              height: 7,
            ),
            Container(
              //color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xffF8F9FE),
                    ),
                    child: const Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FluentSystemIcons.ic_fluent_search_filled,
                          size: 17,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Busca por nombre, marca y año"),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(38, 7, 7, 7)),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                FluentSystemIcons.ic_fluent_arrow_sort_regular,
                                size: 17,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3)),
                              Text(
                                "Sort",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromARGB(38, 7, 7, 7)),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                FluentSystemIcons.ic_fluent_filter_regular,
                                size: 17,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3)),
                              Text(
                                "Filter",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GridView.builder(
                      shrinkWrap:
                          true, // Permite que la grilla se ajuste a su contenido
                      physics:
                          const NeverScrollableScrollPhysics(), // Desactiva el scroll interno
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: 10, // Define el número de elementos
                      itemBuilder: (context, index) {
                        return const CarCatalogue();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
