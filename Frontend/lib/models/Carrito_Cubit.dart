import 'package:flutter/material.dart';

import 'Producto.dart';

class CarritoProvider extends ChangeNotifier {
  late List<Producto> _productos = [];

  List<Producto> get getProductos => _productos;

  setProductos(List<Producto> newList) {
    _productos = newList;
    notifyListeners();
  }

  void setProductoItem(int index, bool active) {
    _productos[index].isSelected = active;
  }
}
