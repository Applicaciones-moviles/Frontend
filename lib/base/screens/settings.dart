import 'package:carconnect_aplication/base/screens/faq.dart';
import 'package:carconnect_aplication/base/screens/login_page.dart';
import 'package:carconnect_aplication/base/screens/terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
                radius: 60,
                child: Image.asset(
                  'assets/images/car.jpg',
                )),
            const SizedBox(
              height: 13,
            ),
            const Text(
              'Juan Perez',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            const Text('@jperez'),
            const SizedBox(
              height: 13,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Terms()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Términos y Condiciones',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Faq()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FAQ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
