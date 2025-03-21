import 'package:dio/dio.dart';
import 'package:gfp/models/ingresos_usuarios_dto.dart';
import 'package:gfp/utils/conexion_api.dart';
import '../models/respuesta_api.dart';

class IngresosUsuariosService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/ingresos-usuarios";

  Future<RespuestaAPI<IngresosUsuario>> obtenerIngresosUsuario(
      int usuarioId, DateTime fecha) async {
    try {
      final response =
          await _dio.get("$_url/obtenerIngresosUsuario/$usuarioId/$fecha");

      return RespuestaAPI<IngresosUsuario>.fromJson(
          response.data, (data) => IngresosUsuario.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<IngresosUsuario>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

  Future<RespuestaAPI<IngresosUsuario>> crearActualizarIngresos(
      IngresosUsuario ingresos) async {
    try {
      final response =
          await _dio.post("$_url/crearActualizarIngresos", data: ingresos.toJson());
      return RespuestaAPI<IngresosUsuario>.fromJson(
          response.data, (data) => IngresosUsuario.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }

  Future<RespuestaAPI<IngresosUsuario>> soloActualizarIngresos(
      IngresosUsuario ingresos) async {
    try {
      final response =
          await _dio.put("$_url/soloActualizarIngresos", data: ingresos.toJson());

      return RespuestaAPI<IngresosUsuario>.fromJson(
          response.data, (data) => IngresosUsuario.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<IngresosUsuario>(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }
}
