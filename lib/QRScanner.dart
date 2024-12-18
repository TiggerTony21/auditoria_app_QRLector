import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QRScanner extends StatefulWidget {
  final Function(String) onScan;

  QRScanner({Key? key, required this.onScan}) : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void initState() {
    super.initState();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final barcode = scanData.code;
      if (barcode != null) {
        // Llamar a la función para registrar la asistencia
        await registerAttendance(barcode);
        widget.onScan(barcode);
        Navigator.of(context).pop(); // Cerrar el escáner
      }
    });
  }

  Future<void> registerAttendance(String qrCode) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/asistencias'), // Cambia la URL según tu API
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'alumno_id': qrCode, // Suponiendo que el código QR es el ID del alumno
        'fecha': DateTime.now().toIso8601String(),
        'hora': DateTime.now().toIso8601String(), // Hora actual en formato ISO
        'estado': 'presente', // Estado de asistencia
      }),
    );

    if (response.statusCode == 201) {
      // Asistencia registrada con éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Asistencia registrada con éxito')),
      );
    } else {
      // Manejar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar asistencia: ${response.body}')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner QR'),
        backgroundColor: Color(0xff305434), // Color de fondo de la AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navegar hacia atrás
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xffe8e4bc), // Color de fondo del cuerpo
        ),
        child: QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
        ),
      ),
    );
  }
}
