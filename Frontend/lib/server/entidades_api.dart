import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:arshop_sin_auth/models/entidad.dart';

import '../components/constants.dart';
import '../models/producto.dart';

var entidadEndpoint = Uri.parse('$baseUrl/producto');

Future<List<Entidad>> geListOfEntidades() async {
  var uri = Uri.parse('$entidadEndpoint/getListOfEntidades/');

  var res = await http.get(
    uri,
  );

  if (res.statusCode == 200) {
    List<Entidad> entidades = (json.decode(res.body) as List)
        .map((data) => Entidad.fromJson(data))
        .toList();

    for (var entidad in entidades) {
      entidad.nombre = utf8.decode(entidad.nombre.codeUnits);
      entidad.descripcion = utf8.decode(entidad.descripcion.codeUnits);
      entidad.direccion = utf8.decode(entidad.direccion.codeUnits);
    }
    return entidades;
  } else {
    return [];
  }
}

Future<List<Producto>> getListOfProductoEntidad(Entidad entidad) async {
  var uri =
      Uri.parse('$entidadEndpoint/geListOfProducto_x_Entidad/${entidad.id}/');

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
