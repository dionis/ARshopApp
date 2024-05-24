import 'package:flutter/material.dart';
import 'package:prueba/components/Constants.dart';

import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../server/Carrito_Api.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.producto,
    required this.user,
    required this.press,
  });

  final Producto producto;
  final User user;
  final VoidCallback press;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isCarrito = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadCarritoStatus();
  }

  Future<void> _loadCarritoStatus() async {
    bool carritoStatus = await buscarProductoCarrito(
      widget.user,
      widget.producto.id,
      widget.user.id!,
    );

    setState(() {
      isCarrito = carritoStatus;
    });
  }

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
                alignment: Alignment.topRight,
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(defaultsize / 2),
                    child: Icon(
                      isCarrito
                          ? Icons.shopping_cart_rounded
                          : Icons.shopping_cart_outlined,
                      color: kprimaryColor,
                      size: defaultsize * 3,
                    ),
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
                      widget.producto.nombre.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Disponibles: ${widget.producto.cantidadDisponible}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
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
