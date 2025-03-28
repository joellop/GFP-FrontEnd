import 'package:flutter/material.dart';
import 'package:gfp/utils/mensajes.dart';
import '../../theme/paleta_colores.dart';
import '../../widgets/campo_texto_customizable.dart';
import '../../widgets/boton_customizable.dart';
import '../../services/autenticacion_service.dart';
import '../../models/usuario_modelo.dart';
import '../../models/respuesta_api.dart';

class PantallaIniciSesion extends StatefulWidget {
  const PantallaIniciSesion({super.key});

  @override
  PantallaIniciSesionState createState() => PantallaIniciSesionState();
}

class PantallaIniciSesionState extends State<PantallaIniciSesion> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutenticacionService _apiService = AutenticacionService();

  bool _cargando = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _cargando = true);

    final usuario = UsuarioModelo(
      nombre: _nombreController.text,
      contrasena: _contrasenaController.text,
    );

    final RespuestaAPI<UsuarioModelo> respuesta =
        await _apiService.iniciarSesion(usuario);

    if (!mounted) return;

    setState(() => _cargando = false);

    if (true) {
      // _guardarToken(respuesta.dato!.token ?? "");
      Navigator.pushReplacementNamed(context, "/pantallaInicio");
    } else {
      _mostrarMensaje(respuesta.mensaje);
    }
  }

  void _guardarToken(String token) async {
    await _apiService.guardarToken(token);
  }

  void _mostrarMensaje(String mensaje) {
    Mensajes.mostrarMensaje(context, mensaje, color: ColorAplicacion.error);
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
                const Text("Iniciar Sesión",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                CampoTextoConIcono(
                  controlador: _nombreController,
                  placeholder: "Usuario",
                  icono: Icons.person,
                  validacion: (value) =>
                      value!.isEmpty ? "Ingrese su usuario" : null,
                ),
                const SizedBox(height: 30),
                CampoTextoConIcono(
                  controlador: _contrasenaController,
                  placeholder: "Contraseña",
                  icono: Icons.lock,
                  esContrasena: true,
                  validacion: (value) =>
                      value!.isEmpty ? "Ingrese su contras" : null,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/pantallaCrearUsuario");
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: const Text("¿Crear usuario?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorAplicacion.blanco,
                              fontStyle: FontStyle.italic,
                            )))),
                const SizedBox(height: 40),
                _cargando
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: ColorAplicacion.blanco))
                    : BotonCustomizable(text: "Ingresar", onPressed: _login),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
