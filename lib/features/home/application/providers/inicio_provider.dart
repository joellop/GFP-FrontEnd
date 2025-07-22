import 'package:flutter/material.dart';

class InicioProvider with ChangeNotifier {
  int _mesSeleccionado = DateTime.now().month;
  int _anioSeleccionado = DateTime.now().year;

  final List<String> _meses = [
    "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
    "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
  ];

  int get mesSeleccionado => _mesSeleccionado;
  int get anioSeleccionado => _anioSeleccionado;
  List<String> get meses => _meses;

  void seleccionarMes(int mes) {
    _mesSeleccionado = mes;
    notifyListeners();
  }

  void seleccionarAnio(int anio) {
    _anioSeleccionado = anio;
    notifyListeners();
  }
}
