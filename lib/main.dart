import 'package:flutter/material.dart';
import 'package:gfp/core/routes/app_routes.dart';
import 'package:gfp/features/auth/application/providers/autenticacion_provider.dart';
import 'package:gfp/features/auth/application/providers/codigo_verificacion_provider.dart';
import 'package:gfp/features/auth/application/providers/usuario_provider.dart';
import 'package:gfp/features/auth/presentation/screens/pantalla_codigo_verificacion.dart';
import 'package:gfp/features/category/application/providers/categoria_provider.dart';
import 'package:gfp/features/category/presentation/screens/pantalla_categorias.dart';
import 'package:gfp/features/home/application/providers/inicio_provider.dart';
import 'package:gfp/features/home/presentation/screens/pantalla_inicio.dart';
import 'package:gfp/features/auth/presentation/screens/pantalla_crear_usuario.dart';
import 'package:gfp/features/auth/presentation/screens/pantalla_inicio_sesion.dart';
import 'package:gfp/features/auth/data/services/autenticacion_service.dart';
import 'package:provider/provider.dart';
import 'features/presentacion/global/splash/pantalla_presentacion.dart';
import 'core/theme/tema.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AutenticacionProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => CodigoVerificacionProvider()),
        ChangeNotifierProvider(create: (_) => InicioProvider()),
        ChangeNotifierProvider(create: (_) => CategoriaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GFP App",
      theme: TemaAplicacion.temaGlobal,
      routes: {
        AppRoutes.inicio: (context) => const PantallaInicio(),
        AppRoutes.login: (context) => const PantallaIniciSesion(),
        AppRoutes.registro: (context) => const PantallaCrearUsuario(),
        AppRoutes.categorias: (context) => const PantallaCategorias(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.verificacion) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => PantallaCodigoVerificacion(
              usuario: args['usuario'],
              codigo: args['codigo'],
            ),
          );
        }
        return null;
      },
      home: FutureBuilder<bool>(
        future: verificarSesion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra la pantalla de presentación mientras se verifica el token
            return const PantallaPresentacion();
          } else if (snapshot.hasData && snapshot.data == true) {
            // Si tiene token, redirige a la pantalla principal
            return const PantallaInicio();
          } else {
            // Si no tiene token, redirige al login
            return const PantallaIniciSesion();
          }
        },
      ),
    );
  }

  // Función que verifica si el usuario tiene un token almacenado
  Future<bool> verificarSesion() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = await AutenticacionService().obtenerToken();
    return token != null;
  }
}
