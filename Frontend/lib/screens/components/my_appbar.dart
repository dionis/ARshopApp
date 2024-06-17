import 'package:arshop_sin_auth/screens/pages/list_entidades.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../pages/contactos_ayuda.dart';
import '../pages/principal.dart';
import '../pages/buscar_producto.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: kprimaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/ic_launcher.png',
                ),
                Text(
                  'ARShop',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gugi',
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text(
              "Inicio",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Principal(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Buscar",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuscarProducto(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Entidades",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.account_balance_sharp,
              color: Colors.white,
            ),
            onTap: () async {
              // List<Producto> listProduct =
              //     await getListProductosCarrito(user, user.id!);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListEntidades()),
              );
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Ayuda y Contacto",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.help,
              color: Colors.white,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactosAyuda(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
  });

  final String name, email;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
          size: 50,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
