import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image selection
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _profileImagePath;
  String _email = "correo@example.com";
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      String? token = await _storage.read(key: 'auth_token');
      String? userId = await _storage.read(key: 'user_id');

      if (token == null || userId == null) {
        showError('No se encontró el token de autenticación.');
        return;
      }

      final response = await http.get(
        Uri.parse('https://azuredrivesafeapp-gehpfxd0gzhxf9a0.eastus-01.azurewebsites.net/api/v1/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        setState(() {
          _nameController.text = responseBody['username'] ?? "Usuario Desconocido";
          _email = responseBody['email'] ?? "correo@example.com";
          _emailController.text = responseBody['email'] ?? "";
          _phoneController.text = responseBody['cellphone']?.toString() ?? "";
          _dniController.text = responseBody['dni'] ?? "";
        });
      } else {
        showError('No se pudo obtener los datos del usuario.');
      }
    } catch (e) {
      showError('Error de conexión: $e');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Opciones',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: _profileImagePath != null
                      ? Image.file(File(_profileImagePath!), fit: BoxFit.cover).image
                      : const AssetImage('assets/default_profile.png') as ImageProvider,
                  child: _profileImagePath == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _nameController.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _buildTextField('Nombre', _nameController.text,
                controller: _nameController, enabled: false),
            _buildTextField('Correo electrónico', _emailController.text,
                controller: _emailController, enabled: false),
            _buildTextField('DNI', _dniController.text,
                controller: _dniController, enabled: false),
            _buildTextField('Celular', _phoneController.text,
                controller: _phoneController, enabled: false), // Bloqueado
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder,
      {TextEditingController? controller, required bool enabled}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          hintText: placeholder,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey[200],
        ),
      ),
    );
  }
}
