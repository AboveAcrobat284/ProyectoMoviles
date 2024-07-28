import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestedTicketDetails extends StatelessWidget {
  final Map<String, dynamic> ticketDetails;

  const RequestedTicketDetails({Key? key, required this.ticketDetails}) : super(key: key);

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
                        'Detalles de boleto',
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
                      'Detalles del boleto solicitado',
                      style: GoogleFonts.breeSerif(
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ticketDetails['destino'] == 'Arriaga'
                                ? 'assets/images/Arriaga.png'
                                : ticketDetails['destino'] == 'Tuxtla Gutierrez'
                                    ? 'assets/images/Tuxtla.jpeg'
                                    : 'assets/images/Glorieta_Letras_Tonalá.jpg',
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '${ticketDetails['origen']} - ${ticketDetails['destino']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Fecha de salida: ${ticketDetails['fecha']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Hora de salida: ${ticketDetails['horaSalida']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Hora de llegada: ${ticketDetails['horaLlegada']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Asiento: ${ticketDetails['asiento']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Precio: ${ticketDetails['precio']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Número de corrida: ${ticketDetails['numCorrida']}',
                            style: GoogleFonts.breeSerif(
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
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
