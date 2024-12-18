import 'package:flutter/material.dart';
import 'Login.dart';
import 'MenuPrincipal.dart';
import 'Alumno.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String numeroCuenta = '';
  String password = '';

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      Login login = Login(numeroCuenta: numeroCuenta, password: password);
      Alumno? alumno = await login.authenticate(context);

      if (alumno != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuPrincipal(alumno: alumno)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login fallido')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Número de Cuenta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu número de cuenta';
                  }
                  return null;
                },
                onChanged: (value) {
                  numeroCuenta = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  return null;
                },
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff305434), // Color de fondo del botón
                ),
                onPressed: () => _submit(context),
                child: Text('Iniciar Sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}