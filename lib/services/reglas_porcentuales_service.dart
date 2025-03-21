import 'package:dio/dio.dart';
import 'package:gfp/models/reglas_porcentuales_dto.dart';
import 'package:gfp/utils/conexion_api.dart';
import '../models/respuesta_api.dart';

class ReglasPorcentualesService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/reglas-porcentual";

  ///Inicio de sesion
  Future<RespuestaAPI<List<ReglasPorcentualesDto>>>
      obtenerReglasPorcentuales() async {
    try {
      final response = await _dio.get("$_url/obtenerReglasPorcentuales");

      return RespuestaAPI<List<ReglasPorcentualesDto>>.fromJson(
          response.data,
          (data) => (data as List)
              .map((item) => ReglasPorcentualesDto.fromJson(item))
              .toList());
    } on DioException catch (e) {
      return RespuestaAPI<List<ReglasPorcentualesDto>>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }
}
