import 'package:flutter/material.dart';
import '../theme/paleta_colores.dart';

class BotonCustomizable extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BotonCustomizable({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorAplicacion.celeste,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorAplicacion.blancoClaro,
          ),
        ),
      ),
    );
  }
}
