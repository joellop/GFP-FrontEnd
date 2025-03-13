class Validaciones {
  static bool validarCorreo(String correo) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(correo);
  }
}
