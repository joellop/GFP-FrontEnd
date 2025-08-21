import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/widgets/campo_texto_customizable.dart';

class FormularioAgregarTransaccionModal extends StatefulWidget {
  @override
  FormularioAgregarTransaccionModalState createState() =>
      FormularioAgregarTransaccionModalState();
}

class FormularioAgregarTransaccionModalState
    extends State<FormularioAgregarTransaccionModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();
  final TextEditingController seccionController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAplicacion.celeste),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: ColorAplicacion.blanco),
                  iconSize: 15,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "AGREGAR TRANSACCIÓN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: tituloController,
              titulo: "Titulo",
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese el titulo" : null,
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: cantidadController,
              titulo: "Cantidad",
              esNumerico: true,
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese la cantidad" : null,
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: categoriaController,
              titulo: "Categoria",
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese la categoria" : null,
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: seccionController,
              titulo: "Sección",
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese la sección" : null,
            ),
            SizedBox(height: 24),
            CampoFechaConTitulo(
              controlador: fechaController,
              titulo: "Fecha",
              validacion: (value) =>
                  value!.isEmpty ? "Seleccione una fecha" : null,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAplicacion.celeste),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print(
                          "todos los datos estan llenos");
                      Navigator.pop(context); // Cierra el modal
                    }
                  },
                  child: Text(
                    "Agregar",
                    style: TextStyle(color: ColorAplicacion.blanco),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
