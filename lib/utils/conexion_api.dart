import 'package:dio/dio.dart';

class ConexionApi {
  static final ConexionApi _instancia = ConexionApi._interno();
  final Dio dio;
  final String baseUrl = "http://192.168.1.59:3000";

  factory ConexionApi() {
    return _instancia;
  }

  ConexionApi._interno()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );
}
