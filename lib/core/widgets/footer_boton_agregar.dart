import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';

class FooterBotonAgregar extends StatelessWidget {
  final VoidCallback onTap;

  const FooterBotonAgregar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorAplicacion.celeste,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: ColorAplicacion.blanco),
            ],
          ),
        ),
      ),
    );
  }
}
