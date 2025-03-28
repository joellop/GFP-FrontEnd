import 'package:flutter/material.dart';
import 'package:gfp/services/autenticacion_service.dart';
import 'package:gfp/theme/paleta_colores.dart';

class MenuLateral extends StatelessWidget {
  final AutenticacionService _apiService = AutenticacionService();

  @override
  Widget build(BuildContext context) {
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
                Navigator.pushReplacementNamed(context, "/pantallaInicio");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: ColorAplicacion.blanco, // Color del ícono
              ),
              title: Text(
                'Configuración',
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
                _apiService.cerrarSesion();
                Navigator.pushReplacementNamed(
                    context, "/pantallaInicioSesion");
              },
            ),
          ],
        ),
      ),
    );
  }
}
