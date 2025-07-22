class RespuestaAPI<T> {
  final T? dato;
  final bool exito;
  final String mensaje;

  RespuestaAPI({
    required this.dato,
    required this.exito,
    required this.mensaje,
  });

  /// Factory para un solo objeto o tipo primitivo (String, int, Modelos, etc.)
  factory RespuestaAPI.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return RespuestaAPI<T>(
      dato: json['dato'] != null ? fromJsonT(json['dato']) : null,
      exito: json['exito'] ?? false,
      mensaje: json['mensaje'] ?? '',
    );
  }

  /// Para serializar (si lo necesitas)
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'dato': dato != null ? toJsonT(dato as T) : null,
      'exito': exito,
      'mensaje': mensaje,
    };
  }
}
