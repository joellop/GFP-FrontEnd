import 'package:flutter/material.dart';
import '../theme/paleta_colores.dart';

///Input con icono (inluye para contasena)
class CampoTextoConIcono extends StatefulWidget {
  final TextEditingController controlador;
  final String placeholder;
  final IconData icono;
  final bool esContrasena;
  final String? Function(String?)? validacion;

  const CampoTextoConIcono({
    super.key,
    required this.controlador,
    required this.placeholder,
    required this.icono,
    this.esContrasena = false,
    this.validacion,
  });

  @override
  CampoTextoConIconoState createState() => CampoTextoConIconoState();
}

class CampoTextoConIconoState extends State<CampoTextoConIcono> {
  bool _obscureText = true; // Inicialmente oculta la contraseña

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controlador,
      obscureText: widget.esContrasena ? _obscureText : false,
      validator: widget.validacion,
      style: const TextStyle(color: ColorAplicacion.blanco),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: const TextStyle(color: ColorAplicacion.blanco, fontSize: 13),
        prefixIcon: Icon(widget.icono, color: ColorAplicacion.blanco),
        filled: true,
        fillColor: ColorAplicacion.secundario,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: widget.esContrasena
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: ColorAplicacion.blanco,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}

///Input sin icono
class CampoTextoSinIcono extends StatelessWidget {
  final TextEditingController controlador;
  final String placeholder;
  final String? Function(String?)? validacion;

  const CampoTextoSinIcono({
    super.key,
    required this.controlador,
    required this.placeholder,
    this.validacion,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      validator: validacion,
      style: const TextStyle(color: ColorAplicacion.blanco),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: ColorAplicacion.blanco, fontSize: 13),
        filled: true,
        fillColor: ColorAplicacion.secundario,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

///Input con titulo
class CampoTextoConTitulo extends StatelessWidget {
  final TextEditingController controlador;
  final String titulo;
  final String? Function(String?)? validacion;

  const CampoTextoConTitulo({
    super.key,
    required this.controlador,
    required this.titulo,
    this.validacion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del campo de texto
        Text(
          titulo,
          style: TextStyle(
            fontSize: 13,
            color: ColorAplicacion.blanco,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controlador,
          validator: validacion,
          style: const TextStyle(color: ColorAplicacion.blanco),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorAplicacion.secundario,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ), // Espaciado interior
          ),
        ),
      ],
    );
  }
}
