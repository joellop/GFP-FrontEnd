import 'package:dio/dio.dart';
import 'package:gfp/models/categorias_dto.dart';
import 'package:gfp/models/respuesta_api.dart';
import 'package:gfp/utils/conexion_api.dart';

class CategoriasService {
  final Dio _dio = ConexionApi().dio;
  final String _url = "${ConexionApi().baseUrl}/categorias";

  Future<RespuestaAPI<List<CategoriasDto>>> obtenerCategorias(
      int usuarioId) async {
    try {
      final response =
          await _dio.get("$_url/obtenerCategoriaUsuario/$usuarioId");
      return RespuestaAPI<List<CategoriasDto>>.fromJson(
          response.data,
          (data) => (data as List)
              .map((item) => CategoriasDto.fromJson(item))
              .toList());
    } on DioException catch (e) {
      return RespuestaAPI<List<CategoriasDto>>(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }

  Future<RespuestaAPI<CategoriasDto>> crearCategoria(
      CategoriasDto categoria) async {
    try {
      final response =
          await _dio.post("$_url/crearCategoria", data: categoria.toJson());
      return RespuestaAPI<CategoriasDto>.fromJson(
          response.data, (data) => CategoriasDto.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<CategoriasDto>(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }

  Future<RespuestaAPI<CategoriasDto>> actualizarCategoria(
      CategoriasDto categoria) async {
    try {
      final response =
          await _dio.put("$_url/actualizarCategoria", data: categoria.toJson());
      return RespuestaAPI<CategoriasDto>.fromJson(
          response.data, (data) => CategoriasDto.fromJson(data));
    } on DioException catch (e) {
      return RespuestaAPI<CategoriasDto>(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }

    Future<RespuestaAPI<dynamic>> eliminarCategoria(
      int categoriaId) async {
    try {
      final response =
          await _dio.delete("$_url/eliminarCategoria/$categoriaId");
      return RespuestaAPI<dynamic>.fromJson(
          response.data, (_) => null);
    } on DioException catch (e) {
      return RespuestaAPI<dynamic>(
          dato: null,
          exito: false,
          mensaje: e.response?.data["mensaje"] ?? "error en la petición");
    }
  }
}
