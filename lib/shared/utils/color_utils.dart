import 'package:flutter/material.dart';

/// Convierte un color en formato HEX (#RRGGBB) a [Color] de Flutter.
Color hexAColor(String hex) {
  if (!RegExp(r'^#([A-Fa-f0-9]{6})$').hasMatch(hex)) {
    throw FormatException("El formato del HEX debe ser #RRGGBB");
  }
  return Color(int.parse(hex.substring(1), radix: 16) + 0xFF000000);
}

/// Convierte un [Color] de Flutter a formato HEX (#RRGGBB).
String colorAHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}
