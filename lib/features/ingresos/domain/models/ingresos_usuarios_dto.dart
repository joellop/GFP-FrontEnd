class IngresosUsuario {
  final int id;
  final int usuarioId;
  final int ingresoConstante;
  final int ingresoIrregular;
  final DateTime fecha;

  IngresosUsuario(
      {required this.id,
      required this.usuarioId,
      required this.ingresoConstante,
      required this.ingresoIrregular,
      required this.fecha});

  factory IngresosUsuario.fromJson(Map<String, dynamic> json) {
    return IngresosUsuario(
        id: json["id"],
        usuarioId: json["usuarioid"],
        ingresoConstante: json["ingresoConstante"],
        ingresoIrregular: json["ingresoIrregular"],
        fecha: json["fecha"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "usuarioId": usuarioId,
      "ingresoConstante": ingresoConstante,
      "ingresoIrregular": ingresoIrregular,
      "fecha": fecha,
    };
  }
}
