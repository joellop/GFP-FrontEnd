import 'package:flutter/material.dart';
import 'package:gfp/features/auth/application/providers/codigo_verificacion_provider.dart';
import 'package:gfp/features/auth/domain/models/codigo_verificacion.dart';
import 'package:gfp/models/respuesta_api.dart';
import 'package:gfp/features/auth/domain/models/usuario_modelo.dart';
import 'package:gfp/core/utils/mensajes.dart';
import 'package:gfp/core/utils/validaciones.dart';
import 'package:gfp/core/widgets/boton_customizable.dart';
import '../../../../core/widgets/campo_texto_customizable.dart';
import '../../../../core/theme/paleta_colores.dart';
import 'package:provider/provider.dart';
import 'package:gfp/features/auth/application/providers/usuario_provider.dart';

class PantallaCrearUsuario extends StatefulWidget {
  const PantallaCrearUsuario({super.key});

  @override
  PantallaCrearUsuarioState createState() => PantallaCrearUsuarioState();
}

class PantallaCrearUsuarioState extends State<PantallaCrearUsuario> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  Future<void> _crearUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    final usuarioProvider = context.read<UsuarioProvider>();
    final codigoProvider = context.read<CodigoVerificacionProvider>();

    final usuario = UsuarioModelo(
      nombre: _nombreController.text,
      email: _emailController.text,
      contrasena: _contrasenaController.text,
    );

    final respuestaUsuario = await usuarioProvider.crearUsuario(usuario);

    if (!mounted) return;

    if (respuestaUsuario.exito) {
      final RespuestaAPI<String> respuestaCodigo =
          await codigoProvider.generarCodigo(respuestaUsuario.dato!.id);

      if (!mounted) return;

      if (respuestaCodigo.exito) {
        Navigator.pushReplacementNamed(context, "/pantallaVerificacionCodigo",
            arguments: {
              "usuario": respuestaUsuario.dato,
              "codigo": respuestaCodigo.dato
            });
      } else {
        Mensajes.mostrarMensaje(context, respuestaCodigo.mensaje,
            color: ColorAplicacion.error);
      }
    } else {
      Mensajes.mostrarMensaje(context, respuestaUsuario.mensaje,
          color: ColorAplicacion.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cargando = context.watch<UsuarioProvider>().cargando;
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
                    "Crear usuario",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CampoTextoConIcono(
                    controlador: _nombreController,
                    placeholder: "Usuario",
                    icono: Icons.person,
                    validacion: (value) =>
                        value!.isEmpty ? "Ingrese un nombre de usuario" : null,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CampoTextoConIcono(
                    controlador: _emailController,
                    placeholder: "Correo electronico",
                    icono: Icons.email,
                    validacion: (value) {
                      if (value == null || value.isEmpty) {
                        return "El correo es obligatorio";
                      }

                      return Validaciones.validarCorreo(value)
                          ? null
                          : "Correo invalido";
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CampoTextoConIcono(
                    controlador: _contrasenaController,
                    placeholder: "Contraseña",
                    icono: Icons.lock,
                    esContrasena: true,
                    validacion: (value) => (value == null || value.isEmpty)
                        ? "La contraseña es obligatoria"
                        : null,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  cargando
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: ColorAplicacion.blanco))
                      : BotonCustomizable(
                          text: "Crear usuario", onPressed: _crearUsuario)
                ],
              )),
        ),
      ),
    );
  }
}
