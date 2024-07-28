import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileChangeScreen extends StatelessWidget {
  final String userId;

  ProfileChangeScreen({Key? key, required this.userId}) : super(key: key);

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _updateUserData(BuildContext context) async {
    final String nombre = nombreController.text;
    final String correo = correoController.text;
    final String password = passwordController.text;

    if (nombre.isEmpty || correo.isEmpty || password.isEmpty) {
      _showErrorDialog(context, 'Todos los campos son obligatorios.');
      return;
    }

    final url = Uri.parse('http://18.204.120.248:3010/user/update/$userId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'correo': correo,
          'password': password,
        }),
      );

      final responseBody = response.body;
      print("Response Body: $responseBody");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, 'Error al actualizar datos. Inténtalo de nuevo. Código de error: ${response.statusCode}. Respuesta: $responseBody');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al actualizar datos. Inténtalo de nuevo. Detalles del error: $error');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Éxito', style: GoogleFonts.modernAntiqua()),
        content: Text('Datos actualizados correctamente.', style: GoogleFonts.modernAntiqua()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop(true); // Vuelve a la pantalla anterior
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  color: const Color.fromRGBO(147, 112, 219, 1),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cambio de datos de perfil',
                          style: GoogleFonts.dmSerifText(
                            textStyle: const TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        Image.asset(
                          'assets/images/Logo.jpeg',
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Por favor, si desea cambiar los datos de su perfil rellene todos los campos y seleccione la opción (Guardar datos)',
                        style: GoogleFonts.breeSerif(
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nuevo nombre',
                        style: GoogleFonts.breeSerif(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      TextField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nuevo correo',
                        style: GoogleFonts.breeSerif(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      TextField(
                        controller: correoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nueva contraseña',
                        style: GoogleFonts.breeSerif(
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          _updateUserData(context);
                        },
                        child: Text(
                          'Guardar datos',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color.fromRGBO(147, 112, 219, 1),
              height: 60,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 40),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
