import 'package:arshop_sin_auth/models/entidad.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/constants.dart';
import '../../components/size_config.dart';
import '../../server/entidades_api.dart';
import '../components/recommand_product.dart';

class ListProductsEntidad extends StatelessWidget {
  const ListProductsEntidad({
    super.key,
    required this.entidad,
  });
  final Entidad entidad;

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
        title: Text(entidad.nombre,
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
              future: getListOfProductoEntidad(entidad),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? RecommandProduct(
                        productos: snapshot.data!,
                      )
                    : Center(
                        child: Image.asset('assets/ripple.gif'),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
