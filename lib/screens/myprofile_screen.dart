import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'profilechange_screen.dart';
import './deletemyprofile.dart'; // Importa la pantalla de eliminación de perfil
import '../main.dart'; // Asegúrate de importar correctamente

class MyProfileScreen extends StatefulWidget {
  final String userId;

  const MyProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late TextEditingController nombreController;
  late TextEditingController correoController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    correoController = TextEditingController();
    passwordController = TextEditingController();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final url = Uri.parse('http://18.204.120.248:3010/user/get/${widget.userId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        setState(() {
          nombreController.text = data['nombre'];
          correoController.text = data['correo'];
          passwordController.text = data['password'];
        });
      } else {
        _showErrorDialog('Error al obtener datos del usuario.');
      }
    } catch (error) {
      _showErrorDialog('Error al obtener datos del usuario. Detalles: $error');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error', style: GoogleFonts.breeSerif()),
        content: Text(message, style: GoogleFonts.breeSerif()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK', style: GoogleFonts.breeSerif()),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()), // Asegúrate de que 'MyApp' sea la pantalla de inicio
      (route) => false,
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tu Perfil',
          style: GoogleFonts.dmSerifText(
            textStyle: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromRGBO(147, 112, 219, 1),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/Logo.jpeg'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/Perfil.jpeg'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'MI PERFIL',
                        style: GoogleFonts.dmSerifText(
                          textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Mi nombre',
                  style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Correo electrónico',
                  style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  controller: correoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Contraseña',
                  style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileChangeScreen(userId: widget.userId),
                      ),
                    );
                    if (result == true) {
                      _fetchUserData(); // Actualiza los datos del usuario
                    }
                  },
                  child: Text(
                    '¿Desea cambiar sus datos?',
                    style: GoogleFonts.breeSerif(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteMyProfileScreen(userId: widget.userId),
                      ),
                    );
                  },
                  child: Text(
                    'Eliminar mi cuenta',
                    style: GoogleFonts.breeSerif(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app, size: 40),
                  onPressed: _logout,
                  color: const Color.fromRGBO(147, 112, 219, 1),
                ),
                Text(
                  'Cerrar sesión',
                  style: GoogleFonts.breeSerif(
                    textStyle: const TextStyle(fontSize: 16, color: Color.fromRGBO(147, 112, 219, 1)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
