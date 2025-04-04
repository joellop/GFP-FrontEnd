import 'package:flutter/material.dart';
import 'package:gfp/screens/codigos/pantalla_codigo_verificacion.dart';
import 'package:gfp/screens/principal/pantalla_inicio.dart';
import 'package:gfp/screens/sesion/pantalla_crear_usuario.dart';
import 'package:gfp/screens/sesion/pantalla_inicio_sesion.dart';
import 'package:gfp/services/autenticacion_service.dart';
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
      routes: {
        "/pantallaInicio": (context) => const PantallaInicio(),
        "/pantallaInicioSesion": (context) => const PantallaIniciSesion(),
        "/pantallaCrearUsuario": (context) => const PantallaCrearUsuario(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/pantallaVerificacionCodigo") {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => PantallaCodigoVerificacion(
              usuario: args['usuario'],
              codigo: args['codigo'],
            ),
          );
        }
        return null;
      },
      home: FutureBuilder<bool>(
        future: verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra la pantalla de presentación mientras se verifica el token
            return const PantallaPresentacion();
          } else if (snapshot.hasData && snapshot.data == true) {
            // Si tiene token, redirige a la pantalla principal
            return const PantallaInicio();
          } else {
            // Si no tiene token, redirige al login
            return const PantallaIniciSesion();
          }
        },
      ),
    );
  }

  // Función que verifica si el usuario tiene un token almacenado
  Future<bool> verificarSesion() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = await AutenticacionService().obtenerToken();
    return token != null;
  }
}
