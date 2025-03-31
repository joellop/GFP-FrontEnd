import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final bool esNumerico;
  final bool permitirDecimales;

  const CampoTextoSinIcono(
      {super.key,
      required this.controlador,
      required this.placeholder,
      this.validacion,
      this.esNumerico = false,
      this.permitirDecimales = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      validator: validacion,
      style: const TextStyle(color: ColorAplicacion.blanco),
      keyboardType: esNumerico
          ? TextInputType.numberWithOptions(decimal: permitirDecimales)
          : TextInputType.text,
      inputFormatters: esNumerico
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ]
          : null,
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
  final bool esNumerico;
  final bool permitirDecimales;

  const CampoTextoConTitulo(
      {super.key,
      required this.controlador,
      required this.titulo,
      this.validacion,
      this.esNumerico = false,
      this.permitirDecimales = false});

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
          keyboardType: esNumerico
              ? TextInputType.numberWithOptions(decimal: permitirDecimales)
              : TextInputType.text,
          inputFormatters: esNumerico
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ]
              : null,
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

///Input fecha con titulo
class CampoFechaConTitulo extends StatefulWidget {
  final TextEditingController controlador;
  final String titulo;
  final String? Function(String?)? validacion;

  const CampoFechaConTitulo({
    super.key,
    required this.controlador,
    required this.titulo,
    this.validacion,
  });
  @override
  CampoFechaConTituloState createState() => CampoFechaConTituloState();
}

class CampoFechaConTituloState extends State<CampoFechaConTitulo> {
  Future<void> _seleccionarFecha() async {
    DateTime? pickedDate = await showDatePicker(
      context: context, // Ahora sí accede al contexto
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // Personaliza el tema si lo deseas
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        widget.controlador.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del campo de texto
        Text(
          widget.titulo,
          style: TextStyle(
            fontSize: 13,
            color: ColorAplicacion.blanco,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controlador,
          validator: widget.validacion,
          readOnly: true, // Hace que el usuario no pueda escribir manualmente
          style: const TextStyle(color: ColorAplicacion.blanco),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorAplicacion.secundario,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon:
                Icon(Icons.calendar_today, color: ColorAplicacion.blanco),
          ),
          onTap: _seleccionarFecha,
        ),
      ],
    );
  }
}
