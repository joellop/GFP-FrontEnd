import 'package:flutter/material.dart';
import 'paleta_colores.dart';

class TemaAplicacion {
  static ThemeData get temaGlobal {
    return ThemeData(
      primaryColor: ColorAplicacion.primario, // Color principal
      scaffoldBackgroundColor: ColorAplicacion.primario, // Fondo de toda la app
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorAplicacion.secundario, // Color del AppBar
        foregroundColor: ColorAplicacion.blancoClaro, // Color de los iconos y textos en el AppBar
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ColorAplicacion.blanco),
        bodyMedium: TextStyle(color: ColorAplicacion.blanco),
      ),
    );
  }
}
