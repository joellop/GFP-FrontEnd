import 'package:flutter/material.dart';
import 'package:gfp/theme/paleta_colores.dart';
import 'package:gfp/widgets/cuadro_seleccion_fecha.dart';
import 'package:gfp/widgets/formulario_balance_modal.dart';
import 'package:gfp/widgets/menu_lateral.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  PantallaInicioState createState() => PantallaInicioState();
}

class PantallaInicioState extends State<PantallaInicio> {
  int _mesSeleccionado = DateTime.now().month;
  int _anioSeleccionado = DateTime.now().year;

  final List<String> _meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre"
  ];

  /// **Selecciona un mes**
  void _seleccionarMes(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ColorAplicacion.secundario,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Seleccionar Mes",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  itemCount: _meses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _meses[index],
                        style: TextStyle(color: ColorAplicacion.blanco),
                      ),
                      onTap: () {
                        setState(() {
                          _mesSeleccionado = index + 1;
                        });
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
  }

  /// **Selecciona un año**
  void _seleccionarAnio(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorAplicacion.secundario,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Seleccionar Año",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        setState(() {
                          _anioSeleccionado = anio;
                        });
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
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorAplicacion.primario,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Bordes redondeados
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
                  valor: _meses[_mesSeleccionado - 1],
                  onTap: () => _seleccionarMes(context),
                ),
                const SizedBox(width: 20),
                CuadroSeleccionWidget(
                  titulo: "Año",
                  valor: "$_anioSeleccionado",
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
                    minimumSize: Size(50, 10)
                  ),
                  child: Icon(Icons.add,
                      color: ColorAplicacion.blanco, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
