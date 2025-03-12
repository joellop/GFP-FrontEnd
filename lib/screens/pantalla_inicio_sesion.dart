import 'package:flutter/material.dart';
import '../theme/paleta_colores.dart';
import '../widgets/campo_texto_customizable.dart';
import '../widgets/boton_customizable.dart';
import '../services/autenticacion_service.dart';
import '../models/usuario_modelo.dart';
import '../models/respuesta_api.dart';
import 'pantalla_inicio.dart';

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

    if (respuesta.exito && respuesta.dato != null) {
      _guardarToken(respuesta.dato!.token ?? "");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PantallaInicio()),
      );
    } else {
      _mostrarMensaje(respuesta.mensaje);
    }
  }

  void _guardarToken(String token) async {
    await _apiService.guardarToken(token);
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Iniciar Sesión",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                CampoTextoCustomizable(
                  controller: _nombreController,
                  hintText: "Usuario",
                  prefixIcon: Icons.person,
                  validator: (value) =>
                      value!.isEmpty ? "Ingrese su usuario" : null,
                ),
                const SizedBox(height: 15),
                CampoTextoCustomizable(
                  controller: _contrasenaController,
                  hintText: "Contraseña",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: (value) =>
                      value!.length < 6 ? "Mínimo 6 caracteres" : null,
                ),
                const SizedBox(height: 25),
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
