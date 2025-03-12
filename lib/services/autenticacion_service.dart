import 'package:dio/dio.dart';
import '../models/usuario_modelo.dart';
import '../models/respuesta_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutenticacionService {
  static const String _tokenKey = 'token';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.59:3000/", // Cambia esto por tu URL real
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );


Future<RespuestaAPI<UsuarioModelo>> iniciarSesion(UsuarioModelo usuario) async {
    try {
      final response = await _dio.post(
        "/autenticacion",
        data: usuario.toJson(),
      );
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
