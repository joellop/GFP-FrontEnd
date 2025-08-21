import 'package:flutter/material.dart';
import 'package:gfp/features/category/data/services/categorias_service.dart';
import 'package:gfp/features/category/domain/models/categorias_dto.dart';
import 'package:gfp/shared/models/respuesta_api.dart';

class CategoriaProvider with ChangeNotifier {
  final CategoriasService _categoriasService = CategoriasService();
  bool _cargando = false;
  bool get cargando => _cargando;

  Future<RespuestaAPI<List<CategoriasDto>>> obtenerCategorias(
      int usuarioId) async {
    _setCargando(true);
    final respuesta = await _categoriasService.obtenerCategorias(usuarioId);
    _setCargando(false);
    return respuesta;
  }

  Future<RespuestaAPI<CategoriasDto>> crearCategorias(
      CategoriasDto categoria) async {
    _setCargando(true);
    final respuesta = await _categoriasService.crearCategoria(categoria);
    _setCargando(false);
    return respuesta;
  }

  Future<RespuestaAPI<CategoriasDto>> actualizarCategorias(
      CategoriasDto categoria) async {
    _setCargando(true);
    final respuesta = await _categoriasService.actualizarCategoria(categoria);
    _setCargando(false);
    return respuesta;
  }

  Future<RespuestaAPI<dynamic>> eliminarCategorias(int categoriaId) async {
    _setCargando(true);
    final respuesta = await _categoriasService.eliminarCategoria(categoriaId);
    _setCargando(false);
    return respuesta;
  }

  void _setCargando(bool value) {
    _cargando = value;
    notifyListeners();
  }
}
