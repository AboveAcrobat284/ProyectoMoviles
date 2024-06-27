import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // Importa la pantalla de inicio de sesión
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hola!!',
              style: GoogleFonts.dmSerifText(
                textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '¡Te damos la bienvenida!',
              style: GoogleFonts.dmSerifText( 
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Al iniciar sesión podrás disfrutar de todos los beneficios sin limitaciones de nuestra aplicación',
              textAlign: TextAlign.center,
              style: GoogleFonts.modernAntiqua(
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text(
                'INICIAR SESIÓN',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color morado
                foregroundColor: Colors.white, // Color del texto
                padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 16), // Tamaño del botón ajustado
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes ligeramente redondeados
                  side: const BorderSide(color: Colors.white, width: 2), // Borde blanco
                ),
                shadowColor: const Color(0xFF4B0082), // Color de la sombra
                elevation: 5, // Elevación para la sombra
              ),
            )
          ],
        ),
      ),
    );
  }
}
