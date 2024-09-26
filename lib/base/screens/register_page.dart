import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:flutter/material.dart';
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
  bool isTermsAccepted = false; // Variable para los términos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    Text(
                      'Regístrate',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Arrendador',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Radio<String>(
                    value: 'Arrendador',
                    activeColor: Color(0xFF006FFD),
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
                    activeColor: Color(0xFF006FFD),
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

              // Checkbox para términos y condiciones
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: isTermsAccepted,
                        activeColor: Color(0xFF006FFD),
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
                                color: Color(0xFF006FFD)), // Cambia el color aquí
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
                                color: Color(0xFF006FFD)), // Cambia el color aquí
                          ),
                        ]))),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              MyButton(
                  text: "Crear Perfil",
                  onPressed: isTermsAccepted ? () {} : null)
            ],
          ),
        ),
      ),
    );
  }
}
