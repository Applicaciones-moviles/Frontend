import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:carconnect_aplication/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentCard extends StatefulWidget {
  PaymentCard({super.key});

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final TextEditingController numberCardController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameOwnerController = TextEditingController();

  bool isTermsAccepted = false;
  // Variable para los términos
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: const Text(
          'Pagos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Numero de la Tarjeta',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: numberCardController,
                  hintText: 'Numero de la Tarjeta',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Row(
                              children: [
                                Text(
                                  'Fecha de Vencimiento',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextfield(
                            controller: dateController,
                            hintText: '00/0000',
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Row(
                              children: [
                                Text(
                                  'CVV',
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          MyTextfield(
                            controller: cvvController,
                            hintText: '000',
                            obscureText: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Nombre del titular',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: nameOwnerController,
                  hintText: 'Ingresa tu celular personal',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006FFD), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 20,horizontal:140), 
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      'cardNumber': numberCardController.text,
                      'cardHolder': nameOwnerController.text,
                      'expiryDate': dateController.text,
                      'cvv': cvvController.text,
                    });
                  },
                  child: Text(
                    'Añadir Tarjeta',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
