import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/Constants.dart';
import '../models/Producto.dart';
import '../models/User.dart';

var productoEndpoint = Uri.parse('$baseUrl/producto');

// Agregar un Producto al Carrito
Future<bool> createCarrito(User user, int productoId, int userId) async {
  var uri = Uri.parse('$productoEndpoint/createCarrito/');

  var res = await http.post(
    uri,
    headers: {
      'Authorization': 'Token ${user.token}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'producto_id': productoId,
    }),
  );
  if (res.statusCode == 200 || res.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<List<Producto>> getListProductosCarrito(User user, int idU) async {
  var uri = Uri.parse('$productoEndpoint/getListCarrito/$idU/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });
  if (res.statusCode == 200) {
    List<Producto> productoC = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    return productoC;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Eliminar un Producto del Carrito
Future<bool> deleteCarrito(User user, int productoId, int idUser) async {
  var uri = Uri.parse('$productoEndpoint/deleteCarrito/$productoId/');
  var res = await http.delete(
    uri,
    headers: {
      'Authorization': 'Token ${user.token}',
      // 'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (res.statusCode == 200 || res.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}

// Buscar Producto en Carrito
Future<bool> buscarProductoCarrito(
    User user, int productoId, int userId) async {
  var uri =
      Uri.parse('$productoEndpoint/buscarProductoCarrito/$userId/$productoId/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });
  if (res.statusCode == 200) {
    bool isCarrito = json.decode(res.body);
    if (isCarrito) {
      return true;
    }
    return false;
  } else {
    return false;
  }
}
