import 'package:arshop_sin_auth/models/entidad.dart';

import 'categoria.dart';

class Producto {
  int id;
  Categoria categoria;
  String nombre;
  String descripcion;
  double precio;
  String imagenUrl;
  String modelo3dUrl;
  // String paginaComprar;
  Entidad entidad;
  double ancho;
  double alto;
  double largo;
  String unidad;

  Producto(
    this.id,
    this.categoria,
    this.nombre,
    this.descripcion,
    this.precio,
    this.imagenUrl,
    this.modelo3dUrl,
    // this.paginaComprar,
    this.entidad,
    this.ancho,
    this.alto,
    this.largo,
    this.unidad,
  );

  factory Producto.fromJson(Map json) {
    return Producto(
      json['id'],
      Categoria.fromJson(json['categoria']),
      json['nombre'],
      json['descripcion'],
      json['precio'],
      json['imagenP'],
      json['modelo_3d'],
      // json['paginaComprar'],
      Entidad.fromJson(json['entidad']),
      json['ancho'],
      json['alto'],
      json['largo'],
      json['unidadM'],
    );
  }
}
