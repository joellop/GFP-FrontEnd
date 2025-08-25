import 'package:dio/dio.dart';
import 'package:gfp/features/auth/domain/models/codigo_verificacion.dart';
import 'package:gfp/core/network/conexion_api.dart';
import '../../../../shared/models/respuesta_api.dart';

class CodigoVerificacionService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/codigos-verificacion";

  ///Genera el codigo de verificación
  Future<RespuestaAPI<String>> generarCodigo(int? usuarioId) async {
    try {
      final response = await _dio.get(
        "$_url/GenerarCodigo/$usuarioId",
      );
      return RespuestaAPI<String>.fromJson(
        response.data,
        (data) => data.toString(),
      );
    } on DioException catch (e) {
      return RespuestaAPI<String>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }

  Future<RespuestaAPI<String>> verificarCodigo(
      CodigoVerificacion datoCodigo) async {
    try {
      final response =
          await _dio.post("$_url/VerificarCodigo", data: datoCodigo.toJson());

      return RespuestaAPI<String>.fromJson(
          response.data, (data) => data as String);
    } on DioException catch (e) {
      return RespuestaAPI(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "Error en la petición");
    }
  }
}
