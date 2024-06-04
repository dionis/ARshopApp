import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/Constants.dart';
import '../../models/Producto.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.onRemove,
    required this.onAdd,
    required this.item,
    required this.onDelete,
    required this.press,
    // required this.pressSelect,
  });
  final Producto item;
  final Function() onRemove;
  final Function() onAdd;
  final Function() onDelete;
  final Function() press;
  // final Function() pressSelect;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: kcontentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    item.imagenUrl,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nombre.length > 25
                          ? mostrarnombreslargos(item.nombre)
                          : item.nombre,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${item.nombre.length} '),
                    const SizedBox(height: 5),
                    Text(
                      item.categoria.nombre,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Cantidad: ${item.cantidadDisponible}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${item.precio}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kcontentColor,
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.shade200,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onRemove,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.remove_outline,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.cantidadProd.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: onAdd,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.add_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String mostrarnombreslargos(String nombre) {
  int mitad = (nombre.length / 2).round();

  int ultimoEspacio = nombre.lastIndexOf(" ", mitad);

  if (ultimoEspacio == -1) {
    ultimoEspacio = nombre.indexOf(" ", mitad);
  }

  String mitad1 = nombre.substring(0, ultimoEspacio);
  String mitad2 = nombre.substring(ultimoEspacio);

  return '$mitad1 \n $mitad2';
}
