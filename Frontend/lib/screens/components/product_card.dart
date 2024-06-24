import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/size_config.dart';
import '../../models/producto.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.producto,
    required this.press,
  });

  final Producto producto;
  final VoidCallback press;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        margin: EdgeInsets.only(
          left: defaultsize!,
          top: defaultsize / 2,
          bottom: defaultsize * 2.5,
        ),
        width: size.width * 0.4,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                width: double.infinity,
                height: defaultsize * 15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.producto.imagenUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kprimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      recibirnombre(widget.producto.nombre.toUpperCase()),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.producto.categoria.nombre.toUpperCase(),
                        style: TextStyle(
                          color: kprimaryColor.withOpacity(0.5),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${widget.producto.precio}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kprimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String recibirnombre(String nombre) {
  return nombre.length > 14 ? '${nombre.substring(0, 12)}...' : nombre;
}
