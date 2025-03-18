import 'package:dio/dio.dart';
import 'package:gfp/services/autenticacion_service.dart';

class ConexionApi {
  static final ConexionApi _instancia = ConexionApi._interno();
  final Dio dio;
  final String baseUrl = "http://192.168.1.79:3000";

  factory ConexionApi() {
    return _instancia;
  }

  ConexionApi._interno()
      : dio = Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        //Obtener token
        String? token = await AutenticacionService().obtenerToken();
        if (token != null) {
          //agregar el token en el encabezado de la solicitud
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }
}
