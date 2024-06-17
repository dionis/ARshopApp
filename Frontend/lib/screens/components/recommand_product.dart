import 'package:flutter/material.dart';
import '../../components/size_config.dart';
import '../../models/producto.dart';
import '../pages/product_info.dart';
import 'product_card.dart';

class RecommandProduct extends StatelessWidget {
  const RecommandProduct({
    super.key,
    required this.productos,
  });

  final List<Producto> productos;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(defaultsize! * 2),
      child: GridView.builder(
        itemCount: productos.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              SizeConfig.orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.693,
        ),
        itemBuilder: (context, index) => ProductCard(
          producto: productos[index],
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductInfo(
                  producto: productos[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
