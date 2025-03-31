import 'package:flutter/material.dart';
import 'package:gfp/theme/paleta_colores.dart';
import 'package:gfp/widgets/campo_texto_customizable.dart';

class FormularioBalanceModal extends StatefulWidget {
  @override
  FormularioModalState createState() => FormularioModalState();
}

class FormularioModalState extends State<FormularioBalanceModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController balanceFijoController = TextEditingController();
  final TextEditingController balanceVolatilController =
      TextEditingController();
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
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                IconButton(
                   style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAplicacion.celeste),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:
                      Icon(Icons.close, color: ColorAplicacion.blanco),
                  iconSize: 15,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "AGREGAR BALANCE",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: balanceFijoController,
              titulo: "Balance fijo",
              esNumerico: true,
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese el balance fijo" : null,
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: balanceVolatilController,
              titulo: "Balance volátil",
              esNumerico: true,
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese el balance volátil" : null,
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
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAplicacion.celeste),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print(
                          "Balance Fijo: ${balanceFijoController.text}, Balance Volátil: ${balanceVolatilController.text}");
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
