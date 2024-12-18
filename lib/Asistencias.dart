import 'package:flutter/material.dart';
import 'Alumno.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Asistencias extends StatefulWidget {
  final Alumno alumno;

  Asistencias({required this.alumno});

  @override
  _AsistenciasState createState() => _AsistenciasState();
}

class _AsistenciasState extends State<Asistencias> {
  List<dynamic> asistencias = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchAsistencias();
  }

  Future<void> fetchAsistencias() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/asistencias/${widget.alumno.id}'));

      if (response.statusCode == 200) {
        setState(() {
          asistencias = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar las asistencias';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencias de ${widget.alumno.nombre}'),
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
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : ListView.builder(
          itemCount: asistencias.length,
          itemBuilder: (context, index) {
            final asistencia = asistencias[index];
            return Card(
              child: ListTile(
                title: Text('Clase: ${asistencia['grupo_id']}'),
                subtitle: Text(
                  'Fecha: ${asistencia['fecha']} - Hora: ${asistencia['hora']} - Estado: ${asistencia['estado']}',
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff305434), // Color del botón flotante
        onPressed: () {
          // Acción para el botón flotante (puedes personalizar esta acción)
        },
        child: Icon(Icons.add), // Icono del botón flotante
      ),
    );
  }
}
