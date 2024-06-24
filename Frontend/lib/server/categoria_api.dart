import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/constants.dart';
import '../models/categoria.dart';

var categoriaEndpoint = Uri.parse('$baseUrl/categoria');

// Mostrar Todas las Categorias
Future<List<Categoria>> geListOfCategoria() async {
  var uri = Uri.parse('$categoriaEndpoint/getListOfCategoria/');

  var res = await http.get(
    uri,
  );

  if (res.statusCode == 200) {
    List<Categoria> categorias = (json.decode(res.body) as List)
        .map((data) => Categoria.fromJson(data))
        .toList();

    for (var categoria in categorias) {
      categoria.nombre = utf8.decode(categoria.nombre.codeUnits);
    }

    return categorias;
  } else {
    throw Exception('Fallo al cargar');
  }
}
