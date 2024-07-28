import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllTicketsScreen extends StatefulWidget {
  const AllTicketsScreen({Key? key}) : super(key: key);

  @override
  _AllTicketsScreenState createState() => _AllTicketsScreenState();
}

class _AllTicketsScreenState extends State<AllTicketsScreen> {
  List<Map<String, dynamic>> tickets = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    final url = Uri.parse('http://18.204.120.248:3010/boleto/get');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          tickets = data.cast<Map<String, dynamic>>();
          isLoading = false;
        });
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

  List<Widget> _buildTicketList() {
    Map<String, List<Map<String, dynamic>>> groupedTickets = {};

    for (var ticket in tickets) {
      String date = ticket['fecha'];
      if (!groupedTickets.containsKey(date)) {
        groupedTickets[date] = [];
      }
      groupedTickets[date]!.add(ticket);
    }

    List<Widget> ticketWidgets = [];
    groupedTickets.forEach((date, tickets) {
      ticketWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: GoogleFonts.breeSerif(
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            ...tickets.map((ticket) => GestureDetector(
              onTap: () {
                // Acción del botón (de momento no hace nada)
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
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
                    const SizedBox(height: 20),
                    Text(
                      '${ticket['origen']} - ${ticket['destino']}',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Fecha de salida: ${ticket['fecha']}',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Número de corrida: ${ticket['numCorrida']}',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      );
    });

    return ticketWidgets;
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
              colors: [
                Color.fromRGBO(147, 112, 219, 1),
                Color.fromRGBO(147, 112, 219, 1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center(
              child: Text(
                'Lista de boletos',
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isError
              ? Center(child: Text('Error al cargar los boletos.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildTicketList(),
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
