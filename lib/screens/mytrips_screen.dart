import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'consulttickets_screen.dart'; // Importa la pantalla de consulta de boletos

class MyTripsScreen extends StatelessWidget {
  const MyTripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Código de boleto',
              style: GoogleFonts.dmSerifText(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: '',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Correo Electrónico',
              style: GoogleFonts.dmSerifText(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const TextField(
              decoration: InputDecoration(
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
                // Lógica para continuar
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
