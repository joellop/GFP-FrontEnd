import 'package:dio/dio.dart';
import 'package:gfp/utils/conexion_api.dart';
import '../models/usuario_modelo.dart';
import '../models/respuesta_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacionService {
  static const String _tokenKey = 'token';
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/autenticacion";

  ///Inicio de sesion
  Future<RespuestaAPI<UsuarioModelo>> iniciarSesion(
      UsuarioModelo usuario) async {
    try {
      final response = await _dio.post(
        _url,
        data: usuario.toJson(),
      );
      print("Respuesta de api ====> ${response.data}");
      return RespuestaAPI<UsuarioModelo>.fromJson(
        response.data,
        (data) => UsuarioModelo.fromJson(data),
      );
    } on DioException catch (e) {
      return RespuestaAPI<UsuarioModelo>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

  /// Guarda el token en SharedPreferences
  Future<void> guardarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Obtiene el token guardado, si existe
  Future<String?> obtenerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Elimina el token (Cerrar sesión)
  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
