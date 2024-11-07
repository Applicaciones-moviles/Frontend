import 'package:carconnect_aplication/base/components/my_button.dart';
import 'package:carconnect_aplication/base/components/my_textfield.dart';
import 'package:carconnect_aplication/base/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
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
                  )
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

              //sign button

              MyButton(text: "Inicia sesión",onPressed: (){},),

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
                    onTap: (){
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