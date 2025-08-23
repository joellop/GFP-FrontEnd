import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/widgets/footer_boton_agregar.dart';
import 'package:gfp/core/widgets/formulario_agregar_categoria.dart';
import 'package:gfp/core/widgets/menu_lateral.dart';

class PantallaCategorias extends StatefulWidget {
  const PantallaCategorias({super.key});

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

// 🔹 Modelo simple de categoría
class Categoria {
  final String id;
  final String nombre;
  final Color color;

  Categoria({
    required this.id,
    required this.nombre,
    required this.color,
  });
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  // 🔹 Lista local de categorías con colores
  final List<Categoria> _categorias = [
    Categoria(id: "1", nombre: "Alimentos", color: Colors.orange),
    Categoria(id: "2", nombre: "Transporte", color: Colors.blue),
    Categoria(id: "3", nombre: "Entretenimiento", color: Colors.purple),
    Categoria(id: "4", nombre: "Salud", color: Colors.green),
    Categoria(id: "5", nombre: "Educación", color: Colors.teal),
    Categoria(id: "6", nombre: "Deportes", color: Colors.red),
    Categoria(id: "7", nombre: "Viajes", color: Colors.indigo),
    Categoria(id: "8", nombre: "Otros", color: Colors.grey),
    Categoria(id: "9", nombre: "Otros", color: Colors.grey),
    Categoria(id: "10", nombre: "Otros", color: Colors.purple),
    Categoria(id: "11", nombre: "Otros", color: Colors.green),
    Categoria(id: "12", nombre: "Otros", color: Colors.blue),
    Categoria(id: "13", nombre: "Otros", color: Colors.greenAccent),
    Categoria(id: "14", nombre: "Otros", color: Colors.cyanAccent),
    Categoria(id: "15", nombre: "Otros", color: Colors.limeAccent),
    Categoria(id: "16", nombre: "Otros", color: Colors.teal),
    Categoria(id: "17", nombre: "Otros", color: Colors.brown),
  ];
    //* Mostrar el formulario de agregar balance
  void _mostrarFormularioBalance(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorAplicacion.primario,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: FormularioAgregarCategoria(),
          ),
        );
      },
    );
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
                  crossAxisCount: 2, // 👈 2 columnas
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3 / 1,
                ),
                itemCount: _categorias.length,
                itemBuilder: (context, index) {
                  final categoria = _categorias[index];
                  return Card(
                    color: categoria.color,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
            bottomNavigationBar: FooterBotonAgregar(
        onTap: () {
          _mostrarFormularioBalance(context);
        },
      ),
    );
  }
}
