import 'package:flutter/material.dart';
import 'dart:async';
import 'sesion/pantalla_inicio_sesion.dart';

class PantallaPresentacion extends StatefulWidget {
  const PantallaPresentacion({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<PantallaPresentacion> {
  @override
  void initState() {
    super.initState();
    // Simula carga de datos antes de ir a HomeScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaIniciSesion()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "GFP",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
