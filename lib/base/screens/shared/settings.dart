import 'dart:convert';
import 'package:carconnect_aplication/base/screens/shared/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:carconnect_aplication/base/screens/shared/faq.dart';
import 'package:carconnect_aplication/base/screens/shared/login_page.dart';
import 'package:carconnect_aplication/base/screens/shared/terms.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  String? _username = "Cargando...";
  String? _email = "Cargando...";
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final token = await _storage.read(key: 'auth_token');
    final userId = await _storage.read(key: 'user_id');

    if (token == null || userId == null) {
      _redirectToLogin("Por favor, inicia sesión nuevamente.");
      return;
    }

    final url = Uri.parse(
        'https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _username = data['username'];
          _email = data['email'];
          _avatarUrl = null; // Inicialmente, sin imagen de perfil.
        });
      } else if (response.statusCode == 401) {
        _redirectToLogin("Sesión expirada. Por favor, inicia sesión nuevamente.");
      } else {
        print("Error al obtener datos del usuario. Código: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al conectarse al servidor: $e");
    }
  }

  void _redirectToLogin(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _avatarUrl != null
                      ? NetworkImage(_avatarUrl!)
                      : const AssetImage('assets/images/default_profile.png')
                  as ImageProvider,
                  child: _avatarUrl == null
                      ? const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  )
                      : null,
                ),
                /*
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfileScreen()),
                      ).then((_) {
                        _fetchUserData(); // Refrescar datos al volver.
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                */
              ],
            ),
            const SizedBox(height: 13),
            Text(
              _username ?? 'Cargando...',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            Text(_email ?? 'Cargando...'),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Terms()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Términos y Condiciones',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
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
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FAQ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await _storage.deleteAll(); // Limpiar token y otros datos
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cerrar Sesión',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
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
