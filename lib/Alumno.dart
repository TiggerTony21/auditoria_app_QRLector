import 'dart:convert';
import 'package:http/http.dart' as http;

class Alumno {
  final int id;
  final String nombre;
  final String correoInstitucional;
  final String semestre;
  final String carrera;

  Alumno({
    required this.id,
    required this.nombre,
    required this.correoInstitucional,
    required this.semestre,
    required this.carrera,
  });



  factory Alumno.fromJson(Map<String, dynamic> json) {
    print('JSON: $json'); // Agrega esto para ver los datos deserializados
    return Alumno(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? 'Nombre no disponible',
      correoInstitucional: json['correo_institucional'] ??
          'Correo no disponible',
      semestre: json['semestre'] ?? 'Semestre no disponible',
      carrera: json['carrera'] ?? 'Carrera no disponible',
    );
  }

  static Future<List<Alumno>> fetchAlumnos() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost:3000/alumnos'));
      print('Response: ${response
          .body}'); // Agrega esto para ver la respuesta de la API
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((alumno) => Alumno.fromJson(alumno)).toList();
      } else {
        throw Exception('Error al cargar alumnos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}