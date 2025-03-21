class EmailDto {
  final String para;
  final String asunto;
  final String contenido;

  EmailDto({required this.para, required this.asunto, required this.contenido});

  Map<String, dynamic> toJson() {
    return {"para": para, "asunto": asunto, "contenido": contenido};
  }
}
