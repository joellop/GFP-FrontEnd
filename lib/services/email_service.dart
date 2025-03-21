import 'package:dio/dio.dart';
import 'package:gfp/models/email_dto.dart';
import 'package:gfp/models/respuesta_api.dart';
import 'package:gfp/utils/conexion_api.dart';

class EmailService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/email";

  Future<RespuestaAPI<dynamic>> enviarEmail(EmailDto email) async {
    try {
      final response =
          await _dio.post("$_url/enviarEmail", data: email.toJson());
      return RespuestaAPI<dynamic>.fromJson(response.data, (_) => null);
    } on DioException catch (e) {
      return RespuestaAPI<dynamic>(
        dato: null,
        exito: false,
        mensaje: e.response?.data["mensaje"] ?? "Error en la petición",
      );
    }
  }
}
