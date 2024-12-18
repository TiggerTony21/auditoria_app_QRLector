import 'package:flutter/material.dart';
import 'Alumno.dart';
import 'QRScanner.dart'; // Asegúrate de importar la clase QRScanner
import 'Asistencias.dart'; // Asegúrate de importar la clase ConsultaAsistencias

class MenuPrincipal extends StatelessWidget {
  final Alumno alumno;

  MenuPrincipal({required this.alumno}); // Recibe el objeto Alumno

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
        backgroundColor: Color(0xff305434), // Color de fondo de la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navegar hacia atrás
          },
        ),
      ),
      body: Container(
        // Aquí se aplica el fondo con el color hex
        decoration: BoxDecoration(
          color: Color(0xffe8e4bc), // Color de fondo
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${alumno.nombre}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Semestre: ${alumno.semestre}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Correo: ${alumno.correoInstitucional}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text('Carrera: ${alumno.carrera}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20), // Espacio adicional

            // Botón para escanear QR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff305434), // Color de fondo del botón usando el código hex
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QRScanner(
                      onScan: (qrCode) {
                        // Aquí puedes manejar lo que sucede después de escanear
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Escaneado: $qrCode')),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text('Escáner QR'),
            ),

            // Botón para consultar asistencias
            SizedBox(height: 20), // Espacio adicional
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff305434), // Color de fondo del botón usando el código hex
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Asistencias(alumno: alumno),
                  ),
                );
              },
              child: Text('Consultar Asistencias'),
            ),
          ],
        ),
      ),
    );
  }
}