import 'dart:convert';
import 'package:carconnect_aplication/base/screens/home-client.dart';
import 'package:carconnect_aplication/base/screens/register_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String loginEndpoint = 'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/authentication/sign-in';


  Future<void> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;


    if (email.isEmpty || password.isEmpty) {
      showError('Por favor, completa todos los campos.');
      return;
    }


    final Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );



      if (response.statusCode == 200 || response.statusCode == 201) {

        final responseBody = json.decode(response.body);
        final token = responseBody['token'];
        final userId = responseBody['id'];


        await _storage.write(key: 'auth_token', value: token);
        await _storage.write(key: 'user_id', value: userId.toString());

        showSuccess('Inicio de sesión exitoso');

        String? storedToken = await _storage.read(key: 'auth_token');
        String? storedId = await _storage.read(key: 'user_id');
        print("Token guardado: $storedToken");
        print("Id del usuario es: $storedId");


        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeClient())
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/base/images/login_image.png',
                    height: 210,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Bienvenido a CarConnect!',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 25),
              MyTextfield(
                controller: emailController,
                hintText: 'Correo electronico',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
                isPasswordField: true,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                          color: Color(0xFF006FFD),
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Inter',
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              MyButton(
                text: "Inicia sesión",
                onPressed: loginUser,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes una cuenta? ',
                    style: GoogleFonts.inter(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Crea una cuenta',
                      style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
