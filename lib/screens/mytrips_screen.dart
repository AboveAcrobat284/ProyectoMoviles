import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/consulttickets_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/Requestedticketdetails.dart'; // Importa la pantalla de detalles del boleto solicitado

class MyTripsScreen extends StatelessWidget {
  final String userId;

  const MyTripsScreen({Key? key, required this.userId}) : super(key: key);

  Future<void> _buscarBoleto(BuildContext context, String numCorrida) async {
    final url = Uri.parse('http://18.204.120.248:3010/boleto/get'); // Endpoint para obtener todos los boletos
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final boleto = data.firstWhere(
          (element) => element['numCorrida'].toString() == numCorrida,
          orElse: () => null,
        );

        if (boleto != null) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Éxito', style: GoogleFonts.modernAntiqua()),
              content: Text('Viaje encontrado correctamente.', style: GoogleFonts.modernAntiqua()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequestedTicketDetails(ticketDetails: boleto)),
                    );
                  },
                  child: Text('OK', style: GoogleFonts.modernAntiqua()),
                ),
              ],
            ),
          );
        } else {
          _showErrorDialog(context, 'Boleto no encontrado.');
        }
      } else {
        _showErrorDialog(context, 'Error al buscar boleto. Código de error: ${response.statusCode}. Respuesta: ${response.body}');
      }
    } catch (error) {
      _showErrorDialog(context, 'Error al buscar boleto. Detalles del error: $error');
    }
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
    final TextEditingController numCorridaController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          flexibleSpace: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(147, 112, 219, 1),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Text(
                    'MIS VIAJES',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Número de corrida',
              style: GoogleFonts.dmSerifText(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            TextField(
              controller: numCorridaController,
              decoration: const InputDecoration(
                hintText: '',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _buscarBoleto(context, numCorridaController.text);
              },
              child: Text(
                'Continuar',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                foregroundColor: Colors.white, // Color del texto
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
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromRGBO(147, 112, 219, 1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Si necesitas seguir la trayectoria durante, puedes hacerlo aquí.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para seguir el viaje
                    },
                    child: Text(
                      'Seguir mi viaje',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                      foregroundColor: Colors.white, // Color del texto
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Botón más ancho
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                      ),
                      shadowColor: const Color(0xFF4B0082), // Color de la sombra
                      elevation: 5, // Elevación para la sombra
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ConsultTicketsScreen()),
                );
              },
              child: Text(
                'Consultar boletos',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                ),
                shadowColor: const Color(0xFF4B0082), // Color de la sombra
                elevation: 5, // Elevación para la sombra
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height - 50)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
