class ReglasPorcentualesDto {
  final int id;
  final String nombre;
  final int porcentaje;


  ReglasPorcentualesDto({
    required this.id,
    required this.nombre,
    required this.porcentaje,
  });

  factory ReglasPorcentualesDto.fromJson(Map<String, dynamic> json) {
    return ReglasPorcentualesDto(
      id: json["id"],
      nombre: json["nombre"] ?? "",
      porcentaje: json["porcentaje"] ?? "",
    );
  }
}
