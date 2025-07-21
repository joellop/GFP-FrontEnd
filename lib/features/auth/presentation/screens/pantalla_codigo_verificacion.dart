import 'package:flutter/material.dart';
import 'package:gfp/features/auth/application/providers/codigo_verificacion_provider.dart';
import 'package:gfp/features/auth/domain/models/codigo_verificacion.dart';
import 'package:gfp/features/auth/domain/models/email_dto.dart';
import 'package:gfp/features/auth/domain/models/usuario_modelo.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/utils/mensajes.dart';
import 'package:gfp/core/widgets/boton_customizable.dart';
import 'package:gfp/core/widgets/campo_texto_customizable.dart';
import 'package:provider/provider.dart';

class PantallaCodigoVerificacion extends StatefulWidget {
  final UsuarioModelo usuario;
  final String codigo;
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
  String get codigo => widget.codigo;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final codigoProvider = context.read<CodigoVerificacionProvider>();

      final email = EmailDto(
        para: usuario.email!,
        asunto: "Código de Verificación GFP",
        contenido: codigo,
      );

      final respuesta = await codigoProvider.enviarCorreo(email);

      if (!mounted) return;

      if (!respuesta.exito) {
        Mensajes.mostrarMensaje(
          context,
          "Error al enviar el correo: ${respuesta.mensaje}",
          color: ColorAplicacion.error,
        );
      }
    });
  }

  Future<void> _validarCodigo() async {
    final codigoProvider = context.read<CodigoVerificacionProvider>();

    final codigo = CodigoVerificacion(
        usuarioId: usuario.id!, codigo: _codigoController.text);

    final respuesta = await codigoProvider.verificarCodigo(codigo);

    if (!mounted) return;

    if (respuesta.exito) {
      Navigator.pushReplacementNamed(context, "/pantallaInicio");
    } else {
      Mensajes.mostrarMensaje(
          context, "codigo digitado ==> ${_codigoController.text}",
          color: ColorAplicacion.exito);
    }
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
                Text.rich(
                  TextSpan(
                    text: 'Te enviamos un código de verificación al correo ',
                    style: TextStyle(fontSize: 15.0),
                    children: [
                      TextSpan(
                        text: usuario.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey, // o el color que quieras
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
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
