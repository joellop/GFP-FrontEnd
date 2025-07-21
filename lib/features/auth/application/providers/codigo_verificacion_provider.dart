import 'package:flutter/material.dart';
import 'package:gfp/features/auth/data/services/email_service.dart';
import 'package:gfp/features/auth/domain/models/codigo_verificacion.dart';
import 'package:gfp/features/auth/data/services/codigo_verificacion_service.dart';
import 'package:gfp/features/auth/domain/models/email_dto.dart';
import 'package:gfp/models/respuesta_api.dart';

class CodigoVerificacionProvider extends ChangeNotifier {
  final CodigoVerificacionService _codigoService = CodigoVerificacionService();
  final EmailService _emailService = EmailService();

  Future<RespuestaAPI<String>> generarCodigo(int? usuarioId) async {
    return await _codigoService.generarCodigo(usuarioId);
  }

  Future<RespuestaAPI<String>> verificarCodigo(CodigoVerificacion codigo) async {
    return await _codigoService.verificarCodigo(codigo);
  }

    Future<RespuestaAPI<dynamic>> enviarCorreo(EmailDto email) async {
    return await _emailService.enviarEmail(email);
  }
}
