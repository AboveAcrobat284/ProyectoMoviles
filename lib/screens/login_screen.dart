import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'home_screen.dart'; // Importa la pantalla de inicio

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String correo = correoController.text;
    final String password = passwordController.text;

    if (correo.isEmpty || password.isEmpty) {
      _showErrorDialog(context, 'Todos los campos son obligatorios.');
      return;
    }

    final url = Uri.parse('http://18.204.120.248:3010/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': correo,
          'password': password,
        }),
      );

      final responseBody = response.body;
      print("Response Body: $responseBody");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(responseBody);
        print("Parsed Response: $responseData");

        if (responseData['token'] != null) {
          final String token = responseData['token'];
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          print("Decoded Token: $decodedToken");

          // Obtén los datos del usuario usando el token
          _getUserData(context, token, correo);
        } else {
          _showErrorDialog(context, 'Error: No se encontraron datos del usuario en la respuesta.');
        }
      } else {
        _showErrorDialog(context, 'Los campos ingresados no pertenecen a un usuario existente. Código de error: ${response.statusCode}. Respuesta: $responseBody');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al iniciar sesión. Inténtalo de nuevo. Detalles del error: $error');
    }
  }

  Future<void> _getUserData(BuildContext context, String token, String correo) async {
    final url = Uri.parse('http://18.204.120.248:3010/user/get');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      final responseBody = response.body;
      print("User Data Response Body: $responseBody");

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(responseBody);
        print("User Data Parsed Response: $responseData");

        final user = responseData.firstWhere((user) => user['correo'] == correo, orElse: () => null);

        if (user != null) {
          final String userId = user['id'].toString();
          _showSuccessDialog(context, userId);
        } else {
          _showErrorDialog(context, 'Error: No se encontraron datos del usuario en la respuesta.');
        }
      } else {
        _showErrorDialog(context, 'Error al obtener los datos del usuario. Código de error: ${response.statusCode}. Respuesta: $responseBody');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al obtener los datos del usuario. Detalles del error: $error');
    }
  }

  void _showSuccessDialog(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Éxito', style: GoogleFonts.modernAntiqua()),
        content: Text('Inicio de sesión exitoso.', style: GoogleFonts.modernAntiqua()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.push(
                ctx,
                MaterialPageRoute(builder: (ctx) => HomeScreen(userId: userId)),
              );
            },
            child: Text('OK', style: GoogleFonts.modernAntiqua()),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error', style: GoogleFonts.modernAntiqua()),
        content: Text(message, style: GoogleFonts.modernAntiqua()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK', style: GoogleFonts.modernAntiqua()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/Logo.jpeg',
                height: 100,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              '¡Te damos la bienvenida!',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSerifText(
                textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Al iniciar sesión podrás disfrutar de todos los beneficios sin limitaciones de nuestra aplicación',
              textAlign: TextAlign.center,
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Inicia sesión',
                style: GoogleFonts.breeSerif(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Correo electrónico',
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: correoController,
              decoration: const InputDecoration(
                hintText: 'ejemplo@correo.com',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Contraseña',
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text(
                'INICIAR SESIÓN',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                  side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                ),
                shadowColor: const Color(0xFF4B0082), // Color de la sombra
                elevation: 5, // Elevación para la sombra
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿Deseas registrarte?',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Hazlo aquí',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(fontSize: 16, color: Color.fromRGBO(147, 112, 219, 1)),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Remove default padding
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
