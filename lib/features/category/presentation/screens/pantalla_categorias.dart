import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/widgets/footer_boton_agregar.dart';
import 'package:gfp/core/widgets/formulario_agregar_categoria.dart';
import 'package:gfp/core/widgets/menu_lateral.dart';
import 'package:gfp/features/category/domain/models/categorias_dto.dart';
import 'package:gfp/shared/utils/color_utils.dart';

class PantallaCategorias extends StatefulWidget {
  const PantallaCategorias({super.key});

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  // 🔹 Lista local de categorías con colores
  final List<CategoriasDto> _categorias = [
    CategoriasDto(
        id: 1, usuarioId: 1, nombre: "Alimentos", color: "#F44336"), // rojo
    CategoriasDto(
        id: 2, usuarioId: 1, nombre: "Transporte", color: "#0000FF"), // azul
    CategoriasDto(
        id: 3,
        usuarioId: 1,
        nombre: "Entretenimiento",
        color: "#FFEB3B"), // amarillo
    CategoriasDto(
        id: 4, usuarioId: 1, nombre: "Salud", color: "#008000"), // verde
    CategoriasDto(
        id: 5, usuarioId: 1, nombre: "Educación", color: "#008080"), // teal
  ];

//* Mostrar el formulario de agregar/editar categoría
  void _mostrarFormularioCategoria(BuildContext context,
      {CategoriasDto? categoria, int? index}) async {
    final result = await showDialog<CategoriasDto>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorAplicacion.primario,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: FormularioAgregarCategoria(
                categoria: categoria), // 🔹 si es editar, se precarga
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        if (index != null) {
          // 🔹 editar
          _categorias[index] = result;
        } else {
          // 🔹 agregar
          _categorias.add(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Categorías",
                style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 1,
                ),
                itemCount: _categorias.length,
                itemBuilder: (context, index) {
                  final categoria = _categorias[index];
                  return InkWell(
                    onTap: () {
                      _mostrarFormularioCategoria(context,
                          categoria: categoria, index: index); // 🔹 editar
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      color: hexAColor(categoria.color),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            categoria.nombre,
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                  // return Card(
                  //   color: hexToColor(categoria.color),
                  //   elevation: 2,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Center(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(12.0),
                  //       child: Text(
                  //         categoria.nombre,
                  //         style: const TextStyle(fontSize: 18),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterBotonAgregar(
        onTap: () {
          _mostrarFormularioCategoria(context);
        },
      ),
    );
  }
}
