import 'package:dio/dio.dart';
import 'package:gfp/models/transaccion_dto.dart';
import 'package:gfp/utils/conexion_api.dart';
import '../models/respuesta_api.dart';

class TransaccionesService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/transacciones";

  Future<RespuestaAPI<List<TransaccionDto>>> obtenerTransacciones(
      TransaccionDto transaccion) async {
    try {
      String urlBase = "$_url/obtenerTransacciones/${transaccion.usuarioId}";

      Map<String, String> queryParams = {};

      if (transaccion.titulo.isNotEmpty) {
        queryParams["titulo"] = transaccion.titulo;
      }

      if (transaccion.fecha != null) {
        queryParams["fecha"] = transaccion.fecha!.toIso8601String();
      }

      Uri uri = Uri.parse(urlBase).replace(queryParameters: queryParams);

      String urlFinal = uri.toString();

      final response = await _dio.get(urlFinal);

      return RespuestaAPI<List<TransaccionDto>>.fromJson(
          response.data,
          (data) => (data as List)
              .map((item) => TransaccionDto.fromJson(item))
              .toList());
    } on DioException catch (e) {
      return RespuestaAPI<List<TransaccionDto>>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

  Future<RespuestaAPI<TransaccionDto>> crearTransaccion(
      TransaccionDto transaccion) async {
    try {
      final response =
          await _dio.post("$_url/crearTransaccion", data: transaccion);

      return RespuestaAPI<TransaccionDto>.fromJson(
          response.data, (data) => TransaccionDto.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<TransaccionDto>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

    Future<RespuestaAPI<TransaccionDto>> actualizarTransaccion(
      TransaccionDto transaccion) async {
    try {
      final response =
          await _dio.put("$_url/actualizarTransaccion", data: transaccion);

      return RespuestaAPI<TransaccionDto>.fromJson(
          response.data, (data) => TransaccionDto.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<TransaccionDto>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

   Future<RespuestaAPI<void>> eliminarTransaccion(
      TransaccionDto transaccion) async {
    try {
      final response =
          await _dio.delete("$_url/eliminarTransaccion/${transaccion.id}");

      return RespuestaAPI<void>.fromJson(
          response.data, (data) => data as Null);
    } on DioException catch (e) {
      return RespuestaAPI<void>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }
}
