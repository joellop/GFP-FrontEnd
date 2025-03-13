import 'package:dio/dio.dart';
import '../models/usuario_modelo.dart';
import '../models/respuesta_api.dart';

class UsuariosService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.59:3000/usuario", // Cambia esto por tu URL real
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

///Inicio de sesion
Future<RespuestaAPI<UsuarioModelo>> crearUsuario(UsuarioModelo usuario) async {
    try {
      final response = await _dio.post(
        "/crearUsuario",
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
