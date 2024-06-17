import 'package:flutter/material.dart';

import '../../models/categoria.dart';
import '../pages/list_product_category.dart';
import 'category_card.dart';

class ListCategorias extends StatelessWidget {
  const ListCategorias({
    super.key,
    required this.categorias,
  });

  final List<Categoria> categorias;

  @override
  Widget build(BuildContext context) {
    final categoriaTodos =
        categorias.indexWhere((element) => element.nombre == 'Todos');
    if (categoriaTodos != -1) {
      final category = categorias.removeAt(categoriaTodos);
      categorias.insert(0, category);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          categorias.length,
          (index) => CategoryCard(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListProductsCategoria(
                    categoria: categorias[index],
                  ),
                ),
              );
            },
            categoria: categorias[index],
          ),
        ),
      ),
    );
  }
}
