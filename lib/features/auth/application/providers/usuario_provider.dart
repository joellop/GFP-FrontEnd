import 'package:flutter/material.dart';
import 'package:gfp/features/auth/data/services/usuarios_service.dart';
import 'package:gfp/features/auth/domain/models/usuario_modelo.dart';
import 'package:gfp/shared/models/respuesta_api.dart';

class UsuarioProvider with ChangeNotifier {
  final UsuariosService _usuariosService = UsuariosService();

  bool _cargando = false;
  bool get cargando => _cargando;

  Future<RespuestaAPI<UsuarioModelo>> crearUsuario(
      UsuarioModelo usuario) async {
    _setCargando(true);
    final respuesta = await _usuariosService.crearUsuario(usuario);
    _setCargando(false);
    return respuesta;
  }

  Future<RespuestaAPI<UsuarioModelo>> actualizarUsuario(UsuarioModelo usuario) async {
    _setCargando(true);
    final respuesta = await _usuariosService.actualizarUsuario(usuario);
    _setCargando(false);
    return respuesta;
  }

    Future<RespuestaAPI<int>> actualizarContrasena(CambioContrasena contrasena) async {
    _setCargando(true);
    final respuesta = await _usuariosService.actualizarContrasena(contrasena);
    _setCargando(false);
    return respuesta;
  }

  void _setCargando(bool value) {
    _cargando = value;
    notifyListeners();
  }
}
