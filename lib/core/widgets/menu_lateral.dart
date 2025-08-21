import 'package:flutter/material.dart';
import 'package:gfp/core/routes/app_routes.dart';
import 'package:gfp/features/auth/application/providers/autenticacion_provider.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:provider/provider.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AutenticacionProvider>();
    return Drawer(
      child: Container(
        color: ColorAplicacion.secundario, // Color de fondo del Drawer
        child: Column(
          children: [
            SizedBox(height: 50),
            // Elementos del Drawer
            ListTile(
              leading: Icon(
                Icons.home,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Inicio',
                style: TextStyle(
                  color: ColorAplicacion.blanco, // Color del texto
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.inicio);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Categoria',
                style: TextStyle(
                  color: ColorAplicacion.blanco, // Color del texto
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.categorias);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.currency_exchange,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Transacción',
                style: TextStyle(
                  color: ColorAplicacion.blanco, // Color del texto
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/configuracion");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Perfil',
                style: TextStyle(
                  color: ColorAplicacion.blanco, // Color del texto
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/configuracion");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: ColorAplicacion.blanco, // Color del texto
                ),
              ),
              onTap: () {
                authProvider.cerrarSesion();
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
