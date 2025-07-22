import 'package:flutter/material.dart';
import '../../data/services/autenticacion_service.dart';
import '../../domain/models/usuario_modelo.dart';
import '../../../../shared/models/respuesta_api.dart';

class AutenticacionProvider with ChangeNotifier {
  final AutenticacionService _authService = AutenticacionService();

  bool _cargando = false;
  bool get cargando => _cargando;

  Future<RespuestaAPI<UsuarioModelo>> iniciarSesion(
      String nombre, String contrasena) async {
    _setCargando(true);

    final respuesta = await _authService.iniciarSesion(
      UsuarioModelo(nombre: nombre, contrasena: contrasena),
    );
    if (respuesta.exito && respuesta.dato != null) {
      await _authService.guardarToken(respuesta.dato!.token!);
    }

    _setCargando(false);
    return respuesta;
  }

  Future<String?> obtenerToken() async {
    final respuesta = await _authService.obtenerToken();

    return respuesta;
  }

  Future<void> cerrarSesion() async {
    final respuesta = await _authService.cerrarSesion();
    return respuesta;
  }

  void _setCargando(bool value) {
    _cargando = value;
    notifyListeners();
  }
}
