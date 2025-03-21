class CategoriasDto {
  final int id;
  final int usuarioId;
  final String nombre;
  final String color;

  CategoriasDto({
    required this.id,
    required this.usuarioId,
    required this.nombre,
    required this.color,
  });

  factory CategoriasDto.fromJson(Map<String, dynamic> json) {
    return CategoriasDto(
        id: json["id"],
        usuarioId: json["usuarioId"],
        nombre: json["nombre"],
        color: json["color"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "usuarioId": usuarioId,
      "nombre": nombre,
      "color": color
    };
  }
}
