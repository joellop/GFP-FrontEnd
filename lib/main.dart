import 'package:flutter/material.dart';
import 'screens/pantalla_presentacion.dart';
import 'theme/tema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GFP App",
      theme: TemaAplicacion.temaGlobal,
      home: const PantallaPresentacion(), // Pantalla de presentacion
    );
  }
}
