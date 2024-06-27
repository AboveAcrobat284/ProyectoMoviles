import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mytrips_screen.dart'; // Importa la pantalla de mis viajes

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTripSelected = true;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Si ya estás en HomeScreen, no necesitas navegar de nuevo.
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyTripsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buenas tardes',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRoundTripSelected = true;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Ida y vuelta',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                            ),
                            if (isRoundTripSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 2,
                                width: 100, // Ajusta el ancho de la línea
                                color: Colors.black,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isRoundTripSelected = false;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Sólo ida',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                            ),
                            if (!isRoundTripSelected)
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                height: 2,
                                width: 100, // Ajusta el ancho de la línea
                                color: Colors.black,
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(230, 230, 250, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Origen',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              '¿De dónde sales?',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                            ),
                            const Divider(color: Colors.white),
                            Text(
                              'Destino',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Text(
                              '¿A dónde quieres ir?',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 40,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 1,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.swap_vert),
                            color: const Color.fromRGBO(147, 112, 219, 1),
                            iconSize: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/Glorieta_Letras_Tonalá.jpg'),
                    const SizedBox(height: 10),
                    Text(
                      'Tonalá - Tuxtla Gutiérrez',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Sumérgete en un oasis tropical lleno de encanto',
                      style: GoogleFonts.modernAntiqua(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Viajar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin),
            label: 'Mis viajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Destinos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(147, 112, 219, 1),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
