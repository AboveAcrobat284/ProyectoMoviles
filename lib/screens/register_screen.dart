import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // Asegúrate de importar la pantalla de login

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    final String nombre = nombreController.text;
    final String apellido = apellidoController.text;
    final String correo = correoController.text;
    final String password = passwordController.text;

    if (nombre.isEmpty || apellido.isEmpty || correo.isEmpty || password.isEmpty) {
      _showErrorDialog(context, 'Todos los campos son obligatorios.');
      return;
    }

    final url = Uri.parse('http://18.204.120.248:3010/user/crear');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'apellido': apellido,
          'correo': correo,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, 'Error al registrar. Inténtalo de nuevo. Código de error: ${response.statusCode}. Respuesta: ${response.body}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al registrar. Inténtalo de nuevo. Detalles del error: $error');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Éxito', style: GoogleFonts.modernAntiqua()),
        content: Text('Registro realizado correctamente.', style: GoogleFonts.modernAntiqua()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.push(
                ctx,
                MaterialPageRoute(builder: (ctx) => LoginScreen()),
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
              'Crea tu cuenta para poder disfrutar de la experiencia de nuestra plataforma.',
              textAlign: TextAlign.center,
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Regístrate',
                style: GoogleFonts.breeSerif(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Nombre(s)',
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                hintText: 'Nombre(s)',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Apellido(s)',
              style: GoogleFonts.modernAntiqua(
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            TextField(
              controller: apellidoController,
              decoration: const InputDecoration(
                hintText: 'Apellido(s)',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
              onPressed: () => _register(context),
              child: Text(
                'REGISTRAR',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color morado para el botón
                foregroundColor: Colors.white, // Texto en blanco
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
                  '¿Ya tienes una cuenta?',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Ingresa aquí',
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
