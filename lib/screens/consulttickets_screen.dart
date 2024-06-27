import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/screens/ticketdetailsrecent_screen.dart';
import 'package:flutter_application_1/screens/alltickets_screen.dart'; // Asegúrate de que la ruta sea correcta

class ConsultTicketsScreen extends StatelessWidget {
  const ConsultTicketsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromRGBO(147, 112, 219, 1), Color.fromRGBO(147, 112, 219, 1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'Consulta de boletos',
                style: GoogleFonts.dmSerifText(
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TicketDetailsRecentScreen()),
                  );
                },
                child: Text(
                  'Boleto más recientes',
                  style: GoogleFonts.dmSerifText(
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    letterSpacing: 3.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                  foregroundColor: Colors.white, // Color del texto
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                  ),
                  shadowColor: const Color(0xFF4B0082), // Color de la sombra
                  elevation: 5, // Elevación para la sombra
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AllTicketsScreen()), // Redirección a AllTicketsScreen
                  );
                },
                child: Text(
                  'Todos los boletos',
                  style: GoogleFonts.dmSerifText(
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    letterSpacing: 3.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color del fondo del botón
                  foregroundColor: Colors.white, // Color del texto
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                  ),
                  shadowColor: const Color(0xFF4B0082), // Color de la sombra
                  elevation: 5, // Elevación para la sombra
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(147, 112, 219, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30), // Hacer la flecha más grande
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
