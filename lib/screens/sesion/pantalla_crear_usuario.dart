import 'package:flutter/material.dart';
import 'package:gfp/models/codigo_verificacion.dart';
import 'package:gfp/models/respuesta_api.dart';
import 'package:gfp/models/usuario_modelo.dart';
import 'package:gfp/screens/codigos/pantalla_codigo_verificacion.dart';
import 'package:gfp/services/codigo_verificacion.dart';
import 'package:gfp/services/usuarios_service.dart';
import 'package:gfp/utils/mensajes.dart';
import 'package:gfp/utils/validaciones.dart';
import 'package:gfp/widgets/boton_customizable.dart';
import '../../widgets/campo_texto_customizable.dart';
import '../../theme/paleta_colores.dart';

class PantallaCrearUsuario extends StatefulWidget {
  const PantallaCrearUsuario({super.key});

  @override
  PantallaCrearUsuarioState createState() => PantallaCrearUsuarioState();
}

class PantallaCrearUsuarioState extends State<PantallaCrearUsuario> {
  bool _cargando = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final UsuariosService _usuarioService = UsuariosService();
  final CodigoVerificacionService _codigoService = CodigoVerificacionService();

  Future<void> _crearUsuario() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    final usuario = UsuarioModelo(
      nombre: _nombreController.text,
      email: _emailController.text,
      contrasena: _contrasenaController.text,
    );

    final RespuestaAPI<UsuarioModelo> respuestaUsuario =
        await _usuarioService.crearUsuario(usuario);

    if (!mounted) return;

    setState(() => _cargando = false);

    if (respuestaUsuario.exito) {

      final RespuestaAPI<CodigoVerificacion> respuestaCodigo =
          await _codigoService.generarCodigo(respuestaUsuario.dato!.id);

      if (!mounted) return;

      if (respuestaCodigo.exito) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => PantallaCodigoVerificacion(
                  usuario: respuestaUsuario.dato!,
                  codigo: respuestaCodigo.dato!)),
        );
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
                  _cargando
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
