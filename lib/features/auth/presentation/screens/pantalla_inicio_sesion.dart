import 'package:flutter/material.dart';
import 'package:gfp/core/utils/mensajes.dart';
import 'package:gfp/features/auth/application/providers/autenticacion_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/paleta_colores.dart';
import '../../../../core/widgets/campo_texto_customizable.dart';
import '../../../../core/widgets/boton_customizable.dart';

class PantallaIniciSesion extends StatefulWidget {
  const PantallaIniciSesion({super.key});

  @override
  PantallaIniciSesionState createState() => PantallaIniciSesionState();
}

class PantallaIniciSesionState extends State<PantallaIniciSesion> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

   final authProvider = context.read<AutenticacionProvider>();

    final respuesta = await authProvider.iniciarSesion(
      _nombreController.text,
      _contrasenaController.text,
    );

    if (!mounted) return;

    if (respuesta.exito && respuesta.dato != null) {
      Navigator.pushReplacementNamed(context, "/pantallaInicio");
    } else {
      Mensajes.mostrarMensaje(context, respuesta.mensaje, color: ColorAplicacion.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cargando = context.watch<AutenticacionProvider>().cargando;

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
                      value!.isEmpty ? "Ingrese su contraseña" : null,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/pantallaCrearUsuario");
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: const Text("Crear usuario",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: ColorAplicacion.blanco,
                              fontStyle: FontStyle.italic,
                            )))),
                const SizedBox(height: 40),
                cargando
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
