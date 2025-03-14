class UsuarioModelo {
  final int? id;
  final String nombre;
  final String contrasena;
  final String? email;
  final String? token;

  UsuarioModelo({
    this.id,
    required this.nombre,
    required this.contrasena,
    this.email,
    this.token,
  });

  factory UsuarioModelo.fromJson(Map<String, dynamic> json) {
    return UsuarioModelo(
      id: json["id"],
      nombre: json["nombre"] ?? "",
      contrasena: json["contrasena"] ?? "",
      email: json["email"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "email": email,
      "contrasena": contrasena,
    };
  }
}
