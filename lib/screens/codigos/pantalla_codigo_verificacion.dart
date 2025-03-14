import 'package:flutter/material.dart';
import 'package:gfp/models/codigo_verificacion.dart';
import 'package:gfp/models/usuario_modelo.dart';
import 'package:gfp/theme/paleta_colores.dart';
import 'package:gfp/utils/mensajes.dart';
import 'package:gfp/widgets/boton_customizable.dart';
import 'package:gfp/widgets/campo_texto_customizable.dart';

class PantallaCodigoVerificacion extends StatefulWidget {
  final UsuarioModelo usuario;
  final CodigoVerificacion codigo;
  PantallaCodigoVerificacion(
      {super.key, required this.usuario, required this.codigo});

  @override
  State<PantallaCodigoVerificacion> createState() =>
      _PantallaCodigoVerificacionState();
}

class _PantallaCodigoVerificacionState
    extends State<PantallaCodigoVerificacion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codigoController = TextEditingController();
  // Aquí puedes usar widget.usuario para acceder al UsuarioModelo
  UsuarioModelo get usuario => widget.usuario;
  CodigoVerificacion get codigo => widget.codigo;

  Future<void> _validarCodigo() async {
    Mensajes.mostrarMensaje(
        context, "codigo digitado ==> ${_codigoController.text}",
        color: ColorAplicacion.exito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Codigo de verificación",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Te enviamos un código de verificación al correo joel@outlook.com",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(height: 100),
                CampoTextoSinIcono(
                  controlador: _codigoController,
                  placeholder: "Digite el código",
                  esNumerico: true,
                ),
                const SizedBox(height: 100),
                BotonCustomizable(text: "Validar", onPressed: _validarCodigo)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
