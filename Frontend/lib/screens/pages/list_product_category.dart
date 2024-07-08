import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/constants.dart';
import '../../components/size_config.dart';
import '../../models/categoria.dart';
import '../../server/producto_api.dart';
import '../components/recommand_product.dart';

class ListProductsCategoria extends StatelessWidget {
  const ListProductsCategoria({
    super.key,
    required this.categoria,
  });
  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 55,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5, top: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Ionicons.chevron_back,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(categoria.nombre,
            style: TextStyle(
                fontFamily: 'Gugi',
                fontSize: defaultsize! * 2,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: kprimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: geListOfProductoCategoria(categoria),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return RecommandProduct(
                      productos: snapshot.data!,
                    );
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: defaultsize * 25),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: 120,
                              color: Colors.grey[300],
                            ),
                            const Text(
                              'No hay productos disponibles por el momento.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: Image.asset('assets/ripple.gif'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
