import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart'; // Importa la pantalla de registro
import 'home_screen.dart'; // Importa la pantalla de inicio

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            const TextField(
              decoration: InputDecoration(
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
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(147, 112, 219, 1)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
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
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
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
