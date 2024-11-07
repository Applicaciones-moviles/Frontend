import 'dart:convert';
import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:carconnect_aplication/base/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final dniController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedProfile;
  bool isTermsAccepted = false;

  static const String registerEndpoint = 'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/authentication/sign-up';

  Future<void> registerUser() async {
    final username = userController.text;
    final email = emailController.text;
    final dni = dniController.text;
    final cellphone = phoneController.text;
    final password = passwordController.text;

    if (username.isEmpty || email.isEmpty || dni.isEmpty || cellphone.isEmpty || password.isEmpty) {
      showError('Por favor, completa todos los campos.');
      return;
    }

    if (!isValidEmail(email)) {
      showError('Por favor, ingresa un correo electrónico válido.');
      return;
    }

    if (!isValidPhoneNumber(cellphone)) {
      showError('Por favor, ingresa un número de teléfono válido.');
      return;
    }

    if (!isTermsAccepted) {
      showError('Debes aceptar los términos y condiciones.');
      return;
    }

    final Map<String, dynamic> data = {
      "username": username,
      "dni": dni,
      "email": email,
      "cellphone": cellphone,
      "password": password,
      "roles": [selectedProfile == 'Arrendador' ? 'ROLE_LESSOR' : 'ROLE_TENANT'],
    };

    try {
      final response = await http.post(
        Uri.parse(registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      print('Respuesta del servidor: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSuccess('Registro exitoso');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        final responseBody = json.decode(response.body);
        showError(responseBody['message'] ?? 'Error desconocido');
      }
    } catch (e) {
      showError('Error de conexión: $e');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^[0-9]{9,15}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Regístrate',
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
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Crea una cuenta para utilizar CarConnect.',
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Escoge qué perfil desea crear',
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      'Arrendador',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Radio<String>(
                      value: 'Arrendador',
                      activeColor: const Color(0xFF006FFD),
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Arrendatario',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Radio<String>(
                      value: 'Arrendatario',
                      activeColor: const Color(0xFF006FFD),
                      groupValue: selectedProfile,
                      onChanged: (value) {
                        setState(() {
                          selectedProfile = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Nombre
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Nombre',
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
                  controller: userController,
                  hintText: 'Ingresa tu nombre completo',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                // Correo electrónico
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Correo electronico',
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
                  controller: emailController,
                  hintText: 'name@email.com',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                // DNI
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'DNI',
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
                  controller: dniController,
                  hintText: 'Ingresa tu DNI',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                // Celular
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Celular',
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
                  controller: phoneController,
                  hintText: 'Ingresa tu celular personal',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                // Contraseña
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        'Contraseña',
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
                  controller: passwordController,
                  hintText: 'Crea una contraseña',
                  obscureText: true,
                  isPasswordField: true,
                ),

                const SizedBox(height: 15),

                // Términos y condiciones
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: isTermsAccepted,
                          activeColor: const Color(0xFF006FFD),
                          onChanged: (value) {
                            setState(() {
                              isTermsAccepted = value ?? false;
                            });
                          },
                        ),
                      ),
                      const Expanded(
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "He leído y estoy de acuerdo con los ",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Términos y Condiciones',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                Color(0xFF006FFD)),
                          ),
                          TextSpan(
                            text: ' y la ',
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Política de Privacidad.',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color:
                                Color(0xFF006FFD)),
                          ),
                        ])),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Botón de registrar
                MyButton(
                    text: "Crear Perfil",
                    onPressed: isTermsAccepted ? registerUser : null)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
