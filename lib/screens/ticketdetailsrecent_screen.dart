import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TicketDetailsRecentScreen extends StatefulWidget {
  const TicketDetailsRecentScreen({Key? key}) : super(key: key);

  @override
  _TicketDetailsRecentScreenState createState() => _TicketDetailsRecentScreenState();
}

class _TicketDetailsRecentScreenState extends State<TicketDetailsRecentScreen> {
  List<Map<String, dynamic>> recentTickets = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchRecentTickets();
  }

  Future<void> _fetchRecentTickets() async {
    final now = DateTime.now();
    final oneWeekAgo = now.subtract(Duration(days: 7));
    final url = Uri.parse('http://18.204.120.248:3010/boleto/get');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Filtrar boletos que tienen fecha dentro de la última semana
        final recentTicketsData = data.where((ticket) {
          final ticketDate = DateTime.parse(ticket['fecha']);
          return ticketDate.isAfter(oneWeekAgo) && ticketDate.isBefore(now);
        }).toList();

        if (recentTicketsData.isNotEmpty) {
          setState(() {
            recentTickets = recentTicketsData.cast<Map<String, dynamic>>();
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            isError = true;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

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
                'Boletos de la última semana',
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isError
                ? Center(child: Text('Error al cargar los boletos.'))
                : ListView.builder(
                    itemCount: recentTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = recentTickets[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  ticket['origen'] == 'Arriaga'
                                      ? 'assets/images/Arriaga.png'
                                      : ticket['origen'] == 'Tuxtla Gutierrez'
                                          ? 'assets/images/Tuxtla.jpeg'
                                          : 'assets/images/Glorieta_Letras_Tonalá.jpg',
                                  height: 200,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                '${ticket['origen']} - ${ticket['destino']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Fecha de salida: ${ticket['fecha']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Hora de salida: ${ticket['horaSalida']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Hora de llegada: ${ticket['horaLlegada']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Asiento: ${ticket['asiento']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Precio: ${ticket['precio']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Número de corrida: ${ticket['numCorrida']}',
                                style: GoogleFonts.dmSerifText(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
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
