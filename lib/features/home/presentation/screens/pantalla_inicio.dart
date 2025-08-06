import 'package:flutter/material.dart';
import 'package:gfp/core/theme/paleta_colores.dart';
import 'package:gfp/core/widgets/cuadro_seleccion_fecha.dart';
import 'package:gfp/core/widgets/footer_boton_agregar.dart';
import 'package:gfp/core/widgets/formulario_balance_modal.dart';
import 'package:gfp/core/widgets/menu_lateral.dart';
import 'package:gfp/features/home/application/providers/inicio_provider.dart';
import 'package:provider/provider.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  PantallaInicioState createState() => PantallaInicioState();
}

class PantallaInicioState extends State<PantallaInicio> {
  //* Selecciona un mes
  void _seleccionarMes(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ColorAplicacion.secundario,
      context: context,
      builder: (context) {
        return Consumer<InicioProvider>(
          builder: (_, provider, __) {
            return Container(
              padding: EdgeInsets.all(16),
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Seleccionar Mes",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.meses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            provider.meses[index],
                            style: TextStyle(color: ColorAplicacion.blanco),
                          ),
                          onTap: () {
                            provider.seleccionarMes(index + 1);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //* Selecciona un año
  void _seleccionarAnio(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorAplicacion.secundario,
      builder: (context) {
        return Consumer<InicioProvider>(builder: (_, provider, __) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Seleccionar Año",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: 30, // 30 años disponibles
                    itemBuilder: (context, index) {
                      int anio = DateTime.now().year - index;
                      return ListTile(
                        title: Text(
                          "$anio",
                          style: TextStyle(color: ColorAplicacion.blanco),
                        ),
                        onTap: () {
                          provider.seleccionarAnio(anio);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  //* Mostrar el formulario de agregar balance
  void _mostrarFormulario(BuildContext context) {
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
            child: FormularioBalanceModal(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final inicioProvider = context.watch<InicioProvider>();
    final meses = inicioProvider.meses;
    return Scaffold(
      appBar: AppBar(),
      drawer: MenuLateral(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bienvenido", style: TextStyle(fontSize: 32)),
            const Text("Joel", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CuadroSeleccionWidget(
                  titulo: "Mes",
                  valor: meses[inicioProvider.mesSeleccionado - 1],
                  onTap: () => _seleccionarMes(context),
                ),
                const SizedBox(width: 20),
                CuadroSeleccionWidget(
                  titulo: "Año",
                  valor: "${inicioProvider.anioSeleccionado}",
                  onTap: () => _seleccionarAnio(context),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _mostrarFormulario(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorAplicacion.celeste,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.all(0),
                      minimumSize: Size(50, 10)),
                  child:
                      Icon(Icons.add, color: ColorAplicacion.blanco, size: 20),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorAplicacion.secundario,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Balance fijo:",
                          style: TextStyle(
                            color: ColorAplicacion.blanco,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "\$50,000.00", // Puedes reemplazar por una variable si lo deseas
                          style: TextStyle(
                            color: ColorAplicacion.blanco,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: ColorAplicacion.secundario,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Balance volatil:",
                          style: TextStyle(
                            color: ColorAplicacion.blanco,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          "\$50,000.00", // Puedes reemplazar por una variable si lo deseas
                          style: TextStyle(
                            color: ColorAplicacion.blanco,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorAplicacion.secundario,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Porcentajes",
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorAplicacion.blanco,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 80,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        "60%",
                        style: TextStyle(
                            fontSize: 13,
                            color: ColorAplicacion.blanco,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 80,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        "30%",
                        style: TextStyle(
                            fontSize: 13,
                            color: ColorAplicacion.blanco,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 80,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.center,
                      child: Text(
                        "10%",
                        style: TextStyle(
                            fontSize: 13,
                            color: ColorAplicacion.blanco,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorAplicacion.secundario,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Saldos restantes",
                    style: TextStyle(
                        fontSize: 20,
                        color: ColorAplicacion.blanco,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Cosas importantes:",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                "\$50,000.00", // Puedes reemplazar por una variable si lo deseas
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "60%",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Cosas innecesarias:",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                "\$50,000.00", // Puedes reemplazar por una variable si lo deseas
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "30%",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorAplicacion.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Ahorro:",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1),
                              Text(
                                "\$50,000.00", // Puedes reemplazar por una variable si lo deseas
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                "10%",
                                style: TextStyle(
                                  color: ColorAplicacion.blanco,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: FooterBotonAgregar(
        onTap: () {
          _mostrarFormulario(context);
        },
      ),
    );
  }
}
