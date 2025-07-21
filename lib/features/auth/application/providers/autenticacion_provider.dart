import 'package:flutter/material.dart';
import '../../data/services/autenticacion_service.dart';
import '../../domain/models/usuario_modelo.dart';
import '../../../../models/respuesta_api.dart';

class AutenticacionProvider with ChangeNotifier {
  final AutenticacionService _authService = AutenticacionService();

  bool _cargando = false;
  bool get cargando => _cargando;

  Future<RespuestaAPI<UsuarioModelo>> iniciarSesion(String nombre, String contrasena) async {
    _setCargando(true);

    final respuesta = await _authService.iniciarSesion(
      UsuarioModelo(nombre: nombre, contrasena: contrasena),
    );

    _setCargando(false);
    return respuesta;
  }

  void _setCargando(bool value) {
    _cargando = value;
    notifyListeners();
  }
}