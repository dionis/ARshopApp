import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/constants.dart';
import '../../server/entidades_api.dart';
import '../components/cart_tile_entidad.dart';
import 'entidad_info.dart';
import 'list_product_x_entidad.dart';

class ListEntidades extends StatelessWidget {
  const ListEntidades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kcontentColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kcontentColor,
          title: const Text(
            'Empresas',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              icon: const Icon(
                Ionicons.chevron_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: geListOfEntidades(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) => CartTile(
                  item: snapshot.data![index],
                  pressLong: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntidadInfo(
                          pantalla: false,
                          entidad: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListProductsEntidad(
                          entidad: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: snapshot.data!.length,
              );
            } else {
              return Center(
                child: Image.asset('assets/ripple.gif'),
              );
            }
          },
        ));
  }
}
