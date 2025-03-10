import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';
import '../widgets/campo_texto_customizable.dart';
import '../widgets/boton_customizable.dart';
import 'pantalla_inicio.dart';

class PantallaIniciSesion extends StatefulWidget {
  const PantallaIniciSesion({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<PantallaIniciSesion> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Simulación de autenticación (reemplazar con lógica real)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PantallaInicio()),
      );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                CampoTextoCustomizable(
                  controller: _emailController,
                  hintText: "Correo electrónico",
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ingrese un correo válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CampoTextoCustomizable(
                  controller: _passwordController,
                  hintText: "Contraseña",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Mínimo 6 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                BotonCustomizable(
                  text: "Ingresar",
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
