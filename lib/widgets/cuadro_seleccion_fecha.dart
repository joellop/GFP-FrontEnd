import 'package:flutter/material.dart';
import 'package:gfp/theme/paleta_colores.dart';

class CuadroSeleccionWidget extends StatelessWidget {
  final String titulo;
  final String valor;
  final VoidCallback onTap;

  const CuadroSeleccionWidget({
    super.key,
    required this.titulo,
    required this.valor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorAplicacion.secundario,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(valor, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
