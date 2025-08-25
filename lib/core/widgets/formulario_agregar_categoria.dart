import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/widgets/campo_texto_customizable.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gfp/features/category/domain/models/categorias_dto.dart';
import 'package:gfp/shared/utils/color_utils.dart';

class FormularioAgregarCategoria extends StatefulWidget {
  final CategoriasDto? categoria;
  const FormularioAgregarCategoria({super.key, this.categoria});

  @override
  State<FormularioAgregarCategoria> createState() =>
      _FormularioAgregarCategoriaState();
}

class _FormularioAgregarCategoriaState
    extends State<FormularioAgregarCategoria> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController tituloController = TextEditingController();
  // Color seleccionado por el usuario
  Color _colorSeleccionado = Colors.blue; // Valor inicial
  @override
  void initState() {
    super.initState();
    // 🔹 Si viene una categoría, precargar sus datos
    if (widget.categoria != null) {
      tituloController.text = widget.categoria!.nombre;
      _colorSeleccionado = hexAColor(widget.categoria!.color);
    }
  }

  void _abrirSelectorColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Selecciona un color"),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _colorSeleccionado,
              onColorChanged: (color) {
                print(colorAHex(color));
                // setState(() {
                //   _colorSeleccionado = color;
                // });
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

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
              widget.categoria == null
                  ? "AGREGAR CATEGORÍA"
                  : "EDITAR CATEGORÍA",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CampoTextoConTitulo(
              controlador: tituloController,
              titulo: "Título",
              validacion: (value) =>
                  value!.isEmpty ? "Ingrese el título" : null,
            ),
            SizedBox(height: 16),
            // Solo este bloque alineado a la izquierda
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Color:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _abrirSelectorColor,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _colorSeleccionado,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                    ),
                  ),
                ],
              ),
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
                      Navigator.pop(context); // Cierra el modal
                    }
                  },
                  child: Text(
                    widget.categoria == null ? "Agregar" : "Guardar",
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
