import 'package:flutter/material.dart';
import 'package:gfp/widgets/menu_lateral.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MenuLateral(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bienvenido",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Joel",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
