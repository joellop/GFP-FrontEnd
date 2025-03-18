class CodigoVerificacion {
  final int id;
  final int usuarioId;
  final String codigo;
  final DateTime fechaCreacion;
  final DateTime fechaExpiracion;
  final bool usado;

  CodigoVerificacion({
    required this.id,
    required this.usuarioId,
    required this.codigo,
    required this.fechaCreacion,
    required this.fechaExpiracion,
    required this.usado,
  });

  factory CodigoVerificacion.fromJson(Map<String, dynamic> json) {
    return CodigoVerificacion(
      id: json["id"],
      usuarioId: json["usuarioId"] ?? "",
      codigo: json["codigo"] ?? "",
      fechaCreacion: json["fechaCreacion"],
      fechaExpiracion: json["fechaExpiracion"],
      usado: json["usado"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "codigo": codigo,
      "fechaCreacion": fechaCreacion,
      "fechaExpiracion": fechaExpiracion,
      "usado": usado
    };
  }
}
