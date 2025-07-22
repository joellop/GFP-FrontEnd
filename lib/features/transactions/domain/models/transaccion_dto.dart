class TransaccionDto {
  final int id;
  final int usuarioId;
  final int categoriaId;
  final int reglaPorcentualId;
  final String titulo;
  final int monto;
  final DateTime? fecha;

  TransaccionDto({
    required this.id,
    required this.usuarioId,
    required this.categoriaId,
    required this.reglaPorcentualId,
    required this.titulo,
    required this.monto,
    this.fecha,
  });

  factory TransaccionDto.fromJson(Map<String, dynamic> json) {
    return TransaccionDto(
      id: json["id"],
      usuarioId: json["usuarioId"] ?? "",
      categoriaId: json["categoriaId"] ?? "",
      reglaPorcentualId: json["reglaPorcentualId"],
      titulo: json["titulo"],
      monto: json["monto"],
      fecha: json["fecha"] 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usuarioId": usuarioId,
      "categoriaId": categoriaId,
      "reglaPorcentualId": reglaPorcentualId,
      "titulo": titulo,
      "monto": monto,
      "fecha": fecha
    };
  }
}
