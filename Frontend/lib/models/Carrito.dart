import 'Producto.dart';
import 'User.dart';

class Carrito {
  int id;
  User cliente;
  List<Producto> productos;


  Carrito(
    this.id,
    this.cliente,
    this.productos,
  );

  factory Carrito.fromJson(Map json) {
    return Carrito(
      json['id'],
      User.fromJson(json['cliente']),
      (json['productos'] as List<dynamic>)
          .map((item) => Producto.fromJson(item))
          .toList(),   
    );
  }
}