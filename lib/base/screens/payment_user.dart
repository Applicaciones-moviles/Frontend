import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:carconnect_aplication/base/screens/payment_card.dart';
import 'package:carconnect_aplication/base/screens/home-client.dart'; // Importar HomeClient
import 'package:carconnect_aplication/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentUser extends StatefulWidget {
  PaymentUser({super.key});

  @override
  _PaymentUserState createState() => _PaymentUserState();
}

class _PaymentUserState extends State<PaymentUser> {
  String? selectedPaymentUser;
  bool isTermsAccepted = false; // Variable para los términos
  int? _selectedPaymentMethod = 0;
  bool _isBillingAddressSameAsShipping = false;
  Map<String, String>? cardDetails;

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tu alquiler ha sido registrado'),
          content: const Text('Gracias por confiar en nosotros'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeClient()), // Redirige al HomeClient
                );
              },
            ),
          ],
        );
      },
    );
  }

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
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Selecciona un método de pago',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'No se cobrará hasta revisar el pedido en la siguiente página',
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Opciones de métodos de pago
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width: 30), // Añade espacio a la izquierda
                        Radio<String>(
                          value: 'Credit Card',
                          activeColor: const Color(0xFF006FFD),
                          groupValue: selectedPaymentUser,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentUser = value;
                            });
                          },
                        ),
                        Text(
                          'Credit Card',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    if (selectedPaymentUser == 'Credit Card') ...[
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: ListTile(
                          title: const Text(
                            "+ Agregar nueva tarjeta",
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentCard()),
                            );
                            if (result != null) {
                              setState(() {
                                cardDetails = result;
                              });
                            }
                          },
                        ),
                      ),
                      if (cardDetails != null) ...[
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text(
                            "Mastercard xxxx xxxx xxxx ${cardDetails!['cardNumber']!.substring(cardDetails!['cardNumber']!.length - 4)}",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                      ListTile(
                        title: const Text(
                            "Mi dirección de facturación es la misma que mi dirección de envío"),
                        leading: Checkbox(
                          value: _isBillingAddressSameAsShipping,
                          onChanged: (bool? value) {
                            setState(() {
                              _isBillingAddressSameAsShipping = value!;
                            });
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<String>(
                            value: 'Apple Pay',
                            activeColor: const Color(0xFF006FFD),
                            groupValue: selectedPaymentUser,
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentUser = value;
                              });
                            },
                          ),
                          Text(
                            'Apple Pay',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Botón de pago
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006FFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 140),
                  ),
                  onPressed: () {
                    _showConfirmationDialog(); // Llama al método para mostrar el diálogo
                  },
                  child: const Text(
                    'Pagar',
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
