class RespuestaAPI<T> {
  final T? dato;
  final bool exito;
  final String mensaje;

  RespuestaAPI({
    required this.dato,
    required this.exito,
    required this.mensaje,
  });

  factory RespuestaAPI.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return RespuestaAPI<T>(
      dato: json["dato"] != null ? fromJsonT(json["dato"]) : null,
      exito: json["exito"] ?? false,
      mensaje: json["mensaje"] ?? "",
    );
  }
}
