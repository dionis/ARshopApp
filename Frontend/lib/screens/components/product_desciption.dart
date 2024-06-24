import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/constants.dart';
import '../../models/producto.dart';
import '../pages/entidad_info.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.producto});
  final Producto producto;

  final bool _pinned = true;

  final bool _snap = false;

  final bool _floating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Ionicons.chevron_back,
                  color: Colors.black,
                ),
              ),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: kSecondaryColor,
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                producto.nombre,
                style: const TextStyle(color: Colors.black),
              ),
              background: Image.network(
                producto.imagenUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Descripción',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Hecho por:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
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
                          child: Text(
                            producto.entidad.nombre,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: kprimaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16 * 2, 16, 16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(producto.descripcion),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Medidas',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Alto: ${producto.alto}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Ancho: ${producto.ancho}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Largo: ${producto.largo}'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
