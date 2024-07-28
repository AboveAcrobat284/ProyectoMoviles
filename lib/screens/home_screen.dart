import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'myprofile_screen.dart';
import 'mytrips_screen.dart'; // Importa la pantalla de mis viajes

class HomeScreen extends StatefulWidget {
  final String userId;
  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRoundTripSelected = true;
  int _selectedIndex = 0;
  String origin = '¿De dónde sales?';
  String destination = '¿A dónde quieres ir?';
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyTripsScreen(userId: widget.userId)),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProfileScreen(userId: widget.userId)),
      );
    }
    // Otras opciones de navegación se pueden manejar aquí
  }

  void _selectLocation(bool isOrigin) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Arriaga Chiapas'),
              onTap: () {
                if (isOrigin && destination == 'Arriaga Chiapas' ||
                    !isOrigin && origin == 'Arriaga Chiapas') {
                  _showErrorDialog(
                      'No puedes seleccionar la misma ubicación para Origen y Destino.');
                } else {
                  setState(() {
                    if (isOrigin) {
                      origin = 'Arriaga Chiapas';
                    } else {
                      destination = 'Arriaga Chiapas';
                    }
                  });
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: const Text('Tonalá Chiapas'),
              onTap: () {
                if (isOrigin && destination == 'Tonalá Chiapas' ||
                    !isOrigin && origin == 'Tonalá Chiapas') {
                  _showErrorDialog(
                      'No puedes seleccionar la misma ubicación para Origen y Destino.');
                } else {
                  setState(() {
                    if (isOrigin) {
                      origin = 'Tonalá Chiapas';
                    } else {
                      destination = 'Tonalá Chiapas';
                    }
                  });
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              title: const Text('Tuxtla Gutiérrez Chiapas'),
              onTap: () {
                if (isOrigin && destination == 'Tuxtla Gutiérrez Chiapas' ||
                    !isOrigin && origin == 'Tuxtla Gutiérrez Chiapas') {
                  _showErrorDialog(
                      'No puedes seleccionar la misma ubicación para Origen y Destino.');
                } else {
                  setState(() {
                    if (isOrigin) {
                      origin = 'Tuxtla Gutiérrez Chiapas';
                    } else {
                      destination = 'Tuxtla Gutiérrez Chiapas';
                    }
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _swapLocations() {
    setState(() {
      final temp = origin;
      origin = destination;
      destination = temp;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd MMMM yyyy').format(selectedDate!);
      });
    }
  }

  void _resetFields() {
    setState(() {
      origin = '¿De dónde sales?';
      destination = '¿A dónde quieres ir?';
      selectedDate = null;
      dateController.clear();
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error', style: GoogleFonts.breeSerif()),
        content: Text(message, style: GoogleFonts.breeSerif()),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK', style: GoogleFonts.breeSerif()),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd MMMM yyyy').format(DateTime.now());
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
                            GestureDetector(
                              onTap: () => _selectLocation(true),
                              child: Text(
                                origin,
                                style: GoogleFonts.breeSerif(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            const Divider(color: Colors.white),
                            Text(
                              'Destino',
                              style: GoogleFonts.breeSerif(
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _selectLocation(false),
                              child: Text(
                                destination,
                                style: GoogleFonts.breeSerif(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (origin != '¿De dónde sales?' && destination != '¿A dónde quieres ir?') ...[
                              TextField(
                                controller: dateController,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                decoration: InputDecoration(
                                  labelText: 'Salida',
                                  labelStyle: GoogleFonts.breeSerif(
                                    textStyle: const TextStyle(fontSize: 14),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _resetFields,
                                child: Text('Limpiar búsqueda', style: GoogleFonts.breeSerif()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(147, 112, 219, 1),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size.fromHeight(50), // Botón ancho
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // De momento no hace nada
                                },
                                child: Text('Buscar viaje', style: GoogleFonts.breeSerif()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(147, 112, 219, 1), // Color morado
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size.fromHeight(50), // Botón ancho
                                ),
                              ),
                            ],
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
                            onPressed: _swapLocations,
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
