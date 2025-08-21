import 'package:flutter/material.dart';
import 'package:gfp/core/widgets/menu_lateral.dart';

class PantallaCategorias extends StatefulWidget {
  const PantallaCategorias({super.key});

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: MenuLateral(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [Text("Categorias", style: TextStyle(fontSize: 32))],
          ),
        ));
  }
}
