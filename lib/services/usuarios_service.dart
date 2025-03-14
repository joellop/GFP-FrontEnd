import 'package:dio/dio.dart';
import 'package:gfp/utils/conexion_api.dart';
import '../models/usuario_modelo.dart';
import '../models/respuesta_api.dart';

class UsuariosService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/usuario";

  ///Inicio de sesion
  Future<RespuestaAPI<UsuarioModelo>> crearUsuario(
      UsuarioModelo usuario) async {
    try {
      final response = await _dio.post(
        "$_url/crearUsuario",
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
}
