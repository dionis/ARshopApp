import 'package:arshop_sin_auth/components/constants.dart';
import 'package:arshop_sin_auth/models/producto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/size_config.dart';
import 'entidad_info.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key, required this.producto});
  final Producto producto;
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductAppbar(
                producto: widget.producto,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: 250,
                  child: ModelViewer(
                    src: widget.producto.modelo3dUrl,
                    alt: widget.producto.nombre,
                    ar: true,
                    arPlacement: ArPlacement.floor,
                    autoRotate: true,
                    cameraControls: true,
                    // arScale: ,
                  ),
                ),
                //       Image.network(widget.producto.imagenUrl),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProdutInfoOficial(producto: widget.producto),
                    const SizedBox(height: 20),
                    ProductDescription(producto: widget.producto),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.producto});
  final Producto producto;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kprimaryColor,
          ),
          alignment: Alignment.center,
          child: const Text(
            'Descripción',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          producto.descripcion,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Medidas',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Alto: ${producto.alto} m'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Ancho: ${producto.ancho} m'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Largo: ${producto.largo} m'),
        ),
      ],
    );
  }
}

class ProdutInfoOficial extends StatelessWidget {
  const ProdutInfoOficial({super.key, required this.producto});
  final Producto producto;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          producto.nombre,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${producto.precio}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      producto.categoria.nombre,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Distribuidor: ',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextSpan(
                      text: producto.entidad.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kprimaryColor.withOpacity(0.8),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntidadInfo(
                                pantalla: true,
                                entidad: producto.entidad,
                              ),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProductAppbar extends StatefulWidget {
  const ProductAppbar({
    super.key,
    required this.producto,
  });
  final Producto producto;

  @override
  State<ProductAppbar> createState() => _ProductAppbarState();
}

class _ProductAppbarState extends State<ProductAppbar> {
  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(Ionicons.chevron_back),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    backgroundColor: Colors.white,
                    children: [
                      SizedBox(
                        height: defaultsize! * 20,
                        width: defaultsize * 20,
                        child: Center(
                          child: QrImageView(
                            version: QrVersions.auto,
                            data:
                                'Categoria: ${widget.producto.categoria.nombre} \n\n Nombre: ${widget.producto.nombre} \n\n Precio: ${widget.producto.precio} \n\n Descripcion: ${widget.producto.descripcion}',
                            eyeStyle: const QrEyeStyle(
                                color: kprimaryColor,
                                eyeShape: QrEyeShape.square),
                            embeddedImage: const AssetImage(
                                'assets/icons/ic_launcher.png'),
                            embeddedImageStyle:
                                const QrEmbeddedImageStyle(size: Size(60, 60)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(Ionicons.qr_code_outline),
          ),
        ],
      ),
    );
  }
}
