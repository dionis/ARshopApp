import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/constants.dart';
import '../models/categoria.dart';
import '../models/producto.dart';

var productoEndpoint = Uri.parse('$baseUrl/producto');

// Mostrar Todos los Productos
Future<List<Producto>> geListOfProducto() async {
  var uri = Uri.parse('$productoEndpoint/getListOfProducto/');

  var res = await http.get(uri);

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Mostrar Todos los Productos por Categorias
Future<List<Producto>> geListOfProductoCategoria(Categoria categoria) async {
  var uri = Uri.parse(
      '$productoEndpoint/geListOfProducto_x_Categoria/${categoria.id}/');

  var res = await http.get(uri);

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Buscar un Producto
Future<List<Producto>> buscarProducto(String productonombre) async {
  var uri = Uri.parse('$productoEndpoint/buscarProducto/$productonombre/');

  var res = await http.get(uri);

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}
