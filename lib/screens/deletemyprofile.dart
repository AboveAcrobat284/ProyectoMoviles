import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart'; // Asegúrate de importar correctamente

class DeleteMyProfileScreen extends StatelessWidget {
  final String userId;

  DeleteMyProfileScreen({Key? key, required this.userId}) : super(key: key);

  final TextEditingController confirmController = TextEditingController();

  Future<void> _deleteUser(BuildContext context) async {
    final String confirmation = confirmController.text;

    if (confirmation != "Estoy de acuerdo") {
      _showErrorDialog(context, 'Debe escribir "Estoy de acuerdo" para confirmar.');
      return;
    }

    final url = Uri.parse('http://18.204.120.248:3010/user/delete/$userId');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        _showSuccessDialog(context);
      } else {
        _showErrorDialog(context, 'Error al eliminar la cuenta. Código de error: ${response.statusCode}. Respuesta: ${response.body}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al eliminar la cuenta. Detalles del error: $error');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Éxito', style: GoogleFonts.modernAntiqua()),
        content: Text('Cuenta eliminada exitosamente.', style: GoogleFonts.modernAntiqua()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()), // Redirige al home
                (route) => false,
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
      body: Stack(
        children: [
          Column(
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
                        'Eliminar cuenta',
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
                      'Por favor, si desea eliminar su cuenta de forma permanente por favor escriba la palabra "Estoy de acuerdo".',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Estoy de acuerdo',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: confirmController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _deleteUser(context);
                      },
                      child: Text(
                        'Eliminar cuenta',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(147, 112, 219, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        shadowColor: const Color(0xFF4B0082),
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
