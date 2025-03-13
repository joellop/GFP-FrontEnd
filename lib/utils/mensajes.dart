import 'package:flutter/material.dart';

class Mensajes {
static void mostrarMensaje(BuildContext context, String mensaje, {Color color = Colors.blue}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensaje),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ),
  );
}

}
