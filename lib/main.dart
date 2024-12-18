import 'package:flutter/material.dart';
import 'LoginForm.dart'; // Pantalla de Login
import 'Alumno.dart'; // Modelo Alumno
import 'Asistencias.dart'; // Pantalla de asistencias
import 'QRScanner.dart'; // Pantalla de escáner QR

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación de Auditoría',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginForm(), // Pantalla inicial es el LoginForm
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  final Alumno alumno;

  MenuPrincipal({required this.alumno}); // Recibe el objeto Alumno

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú Principal'),
      ),
      body: Padding(
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

