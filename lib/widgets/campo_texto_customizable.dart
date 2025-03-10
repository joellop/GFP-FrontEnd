import 'package:flutter/material.dart';
import '../theme/paleta_colores.dart';

class CampoTextoCustomizable extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CampoTextoCustomizable({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(color: ColorAplicacion.blanco),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: ColorAplicacion.blanco),
        prefixIcon: Icon(prefixIcon, color: ColorAplicacion.blanco),
        filled: true,
        fillColor: ColorAplicacion.primario,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
