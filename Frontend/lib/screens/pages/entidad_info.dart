import 'dart:convert';

import 'package:arshop_sin_auth/models/entidad.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class EntidadInfo extends StatelessWidget {
  const EntidadInfo({super.key, required this.entidad, required this.pantalla});
  final bool pantalla;
  final Entidad entidad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entidad.nombre),
        centerTitle: true,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Image.network(
                entidad.logo,
                width: 200,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 10),
                  Text(
                    entidad.telefono,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () => _launchURL(entidad.paginaOficial),
                      child: Text(entidad.paginaOficial))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entidad.direccion,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16 * 2, 16, 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  pantalla
                      ? utf8.decode(
                          entidad.descripcion.codeUnits,
                        )
                      : entidad.descripcion,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Error al cargar la página';
    }
  }
}
