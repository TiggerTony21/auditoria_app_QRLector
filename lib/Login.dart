import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'Alumno.dart';

class Login {
  String numeroCuenta;
  String password;

  Login({required this.numeroCuenta, required this.password});

  Future<Alumno?> authenticate(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/alumnos/validar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'numero_cuenta': numeroCuenta,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Parsear la respuesta para obtener los datos del alumno
        final data = jsonDecode(response.body);

        // Acceder al objeto 'alumno' en la respuesta
        final alumnoData = data['alumno'];

        // Manejar posibles valores nulos
        String nombre = alumnoData['nombre'];
        String semestre = alumnoData['semestre'];
        String correoInstitucional = alumnoData['correo_institucional'];
        String carrera = alumnoData['carrera'];
        int id = alumnoData['id']; // Asegúrate de que el ID también se maneje

        // Crear una instancia de Alumno
        Alumno alumno = Alumno(
          id: id,
          nombre: nombre,
          semestre: semestre,
          correoInstitucional: correoInstitucional,
          carrera: carrera,
        );

        return alumno; // Devolver la instancia de Alumno

      } else if (response.statusCode == 401) {
        print('Autenticación fallida: Credenciales inválidas');
        return null; // Autenticación fallida
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null; // Autenticación fallida
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null; // Autenticación fallida
    }
  }
}