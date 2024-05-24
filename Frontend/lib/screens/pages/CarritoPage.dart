// // // / oficial

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:untitled1/components/Constants.dart';
// import 'package:untitled1/models/Producto.dart';
// import '../../components/Size_Config.dart';
// import '../../models/User.dart';
// import '../../models/User_Cubit.dart';
// import '../../server/Carrito_Api.dart';
// import '../components/CartTileCarrito.dart';
// import 'AnimacionCarrito/CustomBiometricsPage.dart';
// import 'AnimacionCarrito/gravity.dart';
// import 'ProductInfo.dart';

// class CarritoPage extends StatefulWidget {
//   const CarritoPage({
//     super.key,
//   });
//   @override
//   State<CarritoPage> createState() => _CarritoPageState();
// }

// List<Producto> productos = [];
// late User user;
// List<Producto> selectedProduct = [];
// bool selectAll = false;
// final gravityController = GravityController();

// class _CarritoPageState extends State<CarritoPage> {
//   Future<List<Producto>> cargarDatos() async {
//     user = context.read<UserProvider>().getUser;
//     getListProductosCarrito(user, user.id!).then((value) {
//       //context.read<CarritoProvider>().setProductos(value);
//       setState(() {
//         productos = value;
//       });
//     });

//     return productos;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     user = context.read<UserProvider>().getUser;

//     double? defaultsize = SizeConfig.defaultSize;
//     return Scaffold(
//       backgroundColor: kcontentColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: kcontentColor,
//         title: const Text(
//           'Carrito',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         leadingWidth: 60,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 5),
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//             ),
//             icon: const Icon(
//               Ionicons.chevron_back,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: productos.isNotEmpty
//           ? ListView.builder(
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CheckboxListTile(
//                         checkboxShape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         value: selectAll,
//                         title: const Text(
//                           'Seleccionar todo',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Color(
//                               0xFF475269,
//                             ),
//                           ),
//                         ),
//                         activeColor: kprimaryColor,
//                         controlAffinity: ListTileControlAffinity.leading,
//                         onChanged: (value) {
//                           setState(() {
//                             selectAll = value!;
//                             for (var element in productos) {
//                               element.isSelected = value;
//                             }
//                           });
//                         },
//                       ),
//                       SizedBox(
//                         height: defaultsize! * 30,
//                         width: double.infinity,
//                         child: ListView.separated(
//                           padding: const EdgeInsets.all(20),
//                           itemBuilder: (context, index) => CheckboxListTile(
//                             // dense: false,

//                             checkboxShape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6)),
//                             contentPadding: const EdgeInsets.only(left: -1),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             value: productos[index].isSelected,
//                             activeColor: kprimaryColor,

//                             onChanged: (value) {
//                               setState(() {
//                                 productos[index].isSelected = value!;

//                                 final check = productos
//                                     .every((element) => element.isSelected);
//                                 selectAll = check;
//                               });
//                             },
//                             title: CartTile(
//                               press: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductInfo(
//                                       producto: productos[index],
//                                       user: user,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               item: productos[index],
//                               onRemove: () {
//                                 if (productos[index].cantidadProd != 1) {
//                                   setState(() {
//                                     productos[index].cantidadProd--;
//                                   });
//                                 }
//                               },
//                               onAdd: () {
//                                 if (productos[index].cantidadProd <
//                                     productos[index].cantidadDisponible) {
//                                   setState(() {
//                                     productos[index].cantidadProd++;
//                                   });
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'No hay más productos disponibles hasta el momento'),
//                                     ),
//                                   );
//                                 }
//                               },
//                               onDelete: () async {
//                                 var a = await deleteCarrito(
//                                   user,
//                                   productos[index].id,
//                                   user.id!,
//                                 );
//                                 if (a == true) {
//                                   setState(() {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           'Producto eliminado del carrito satisfactoriamente',
//                                         ),
//                                       ),
//                                     );
//                                   });
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Error al eliminar producto del carrito',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 20),
//                           itemCount: productos.length,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0xFF475269).withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Productos a Comprar:',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 Text(
//                                   productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .isEmpty
//                                       ? '0'
//                                       : '\$${productos.where((element) => element.isSelected).map<double>((e) => e.cantidadProd.toDouble()).reduce((value1, value2) => value1 + value2)}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             const Divider(),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Subtotal',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 Text(
//                                   productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .isEmpty
//                                       ? '0'
//                                       : '\$${calcSubtotal(productos.where((element) => element.isSelected).toList(), productos.where((element) => element.isSelected).toList()[index])}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Visibility(
//                               visible: productos
//                                       .where((element) => element.isSelected)
//                                       .isNotEmpty
//                                   ? true
//                                   : false,
//                               child: const Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Divider(),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Envio',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                       Text(
//                                         '100',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Visibility(
//                               visible: productos
//                                       .where((element) => element.isSelected)
//                                       .isNotEmpty
//                                   ? mostrarDescuento(
//                                       productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .toList(),
//                                       productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .toList()[index])
//                                   : false,
//                               child: const Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Divider(),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Descuento',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                       Text(
//                                         '200',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             const Divider(),
//                             const SizedBox(height: 10),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Total',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .isEmpty
//                                       ? '0'
//                                       : '\$${calcTotal(productos.where((element) => element.isSelected).toList(), productos.where((element) => element.isSelected).toList()[index])}',
//                                   style: const TextStyle(
//                                     color: kprimaryColor,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(left: 15, top: 20),
//                             alignment: Alignment.centerLeft,
//                             child: const Text(
//                               'Completar detalles del Pedido',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(
//                                   0xFF475269,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 15),
//                             padding: const EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       const Color(0xFF475269).withOpacity(0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   'Nombre del Propietario',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextFormField(
//                                   initialValue:
//                                       "${user.first_name} ${user.last_name}",
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText: "Entre su nombre",
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Direccion de envio',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextFormField(
//                                   initialValue: user.direccion,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText: 'Entre la direccion de envio',
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Número de Teléfono',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextFormField(
//                                   initialValue: user.telefono,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText: "Entre su Numero de Télefono",
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             margin:
//                                 EdgeInsets.all(SizeConfig.defaultSize! * 1.5),
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 padding: EdgeInsets.all(
//                                     SizeConfig.defaultSize! * 1.5),
//                                 backgroundColor: kprimaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Comprar',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: SizeConfig.defaultSize! * 1.6,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               onPressed: () {
//                                 if (selectAll == true ||
//                                     productos[index].isSelected == true) {
//                                   const transitionDuration =
//                                       Duration(milliseconds: 400);

//                                   Navigator.of(context).push(
//                                     PageRouteBuilder(
//                                       transitionDuration: transitionDuration,
//                                       reverseTransitionDuration:
//                                           transitionDuration,
//                                       pageBuilder: (_, animation, ___) {
//                                         return FadeTransition(
//                                           opacity: animation,
//                                           // child: const BiometricsPage(), Uses Lottie
//                                           child: const CustomBiometricsPage(),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Primero debe seleccionar un producto para poder realizar la compra',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//             )
//           : SizedBox(
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.info,
//                       size: 120,
//                       color: Colors.grey[300],
//                     ),
//                     const Text(
//                       'Su carrito de compras está vacio, para poder agregar productos al mismo simplemente selecciona el icono de Carrito, en el producto que desee.',
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// mostrarDescuento(List<Producto> productos, Producto itemcarrito) {
//   double subtotal = calcSubtotal(productos, itemcarrito);
//   if (subtotal >= 1000) {
//     return true;
//   } else {
//     return false;
//   }
// }

// double calcSubtotal(List<Producto> productos, Producto itemcarrito) {
//   return productos.length > 1
//       ? productos
//           .map<double>((e) => e.cantidadProd * e.precio)
//           .reduce((value1, value2) => value1 + value2)
//       : itemcarrito.precio * itemcarrito.cantidadProd;
// }

// double calcTotal(List<Producto> productos, Producto itemcarrito) {
//   double total = 0;
//   double subtotal = calcSubtotal(productos, itemcarrito);
//   double envio = 100;
//   double descuento = 200;

//   if (subtotal >= 1000) {
//     total = (subtotal + envio) - descuento;
//     return total;
//   } else {
//     total = subtotal + envio;
//     return total;
//   }
// }

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Carrito_Cubit.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../../server/Carrito_Api.dart';
import '../components/CartTileCarrito.dart';
import 'AnimacionCarrito/CustomBiometricsPage.dart';
import 'ProductInfo.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});
  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

bool selectAll = false;

class _CarritoPageState extends State<CarritoPage> {
  late Future<List<Producto>> futereProductos;
  late User user;
  // late List<Producto> listproducProv;
  @override
  void initState() {
    super.initState();
    user = context.read<UserProvider>().getUser;
    futereProductos = getListProductosCarrito(user, user.id!).then((value) {
      context.read<CarritoProvider>().setProductos(value);
      // listproducProv.setProductos(value);
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // user = context.read<UserProvider>().getUser;
    final listproducProv = context.watch<CarritoProvider>();

    double? defaultsize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kcontentColor,
        title: const Text(
          'Carrito',
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
      body: FutureBuilder<List<Producto>>(
        future: futereProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (listproducProv.getProductos.isEmpty) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        size: 120,
                        color: Colors.grey[300],
                      ),
                      const Text(
                        'Su carrito de compras está vacio, para poder agregar productos al mismo simplemente selecciona el icono de Carrito, en el producto que desee.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CheckboxListTile(
                        key: ValueKey(listproducProv.getProductos[index].id),
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        value: selectAll,
                        title: const Text(
                          'Seleccionar todo',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(
                              0xFF475269,
                            ),
                          ),
                        ),
                        activeColor: kprimaryColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() {
                            selectAll = value!;
                            for (var element in listproducProv.getProductos) {
                              element.isSelected = value;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: defaultsize! * 30,
                        width: double.infinity,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) => CheckboxListTile(
                            // dense: false,

                            checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            contentPadding: const EdgeInsets.only(left: -1),
                            controlAffinity: ListTileControlAffinity.leading,
                            value:
                                listproducProv.getProductos[index].isSelected,
                            activeColor: kprimaryColor,

                            onChanged: (value) {
                              setState(() {
                                listproducProv.getProductos[index].isSelected =
                                    value!;

                                final check = listproducProv.getProductos
                                    .every((element) => element.isSelected);
                                selectAll = check;
                              });
                            },
                            title: CartTile(
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductInfo(
                                      producto:
                                          listproducProv.getProductos[index],
                                      user: user,
                                    ),
                                  ),
                                );
                              },
                              item: listproducProv.getProductos[index],
                              onRemove: () {
                                if (listproducProv
                                        .getProductos[index].cantidadProd !=
                                    1) {
                                  setState(() {
                                    listproducProv
                                        .getProductos[index].cantidadProd--;
                                  });
                                }
                              },
                              onAdd: () {
                                if (listproducProv
                                        .getProductos[index].cantidadProd <
                                    listproducProv.getProductos[index]
                                        .cantidadDisponible) {
                                  setState(() {
                                    listproducProv
                                        .getProductos[index].cantidadProd++;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'No hay más productos disponibles hasta el momento'),
                                    ),
                                  );
                                }
                              },
                              onDelete: () async {
                                var a = await deleteCarrito(
                                  user,
                                  listproducProv.getProductos[index].id,
                                  user.id!,
                                );
                                if (a == true) {
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Producto eliminado del carrito satisfactoriamente',
                                        ),
                                      ),
                                    );
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Error al eliminar producto del carrito',
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: listproducProv.getProductos.length,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF475269).withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Productos a Comprar:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  listproducProv.getProductos
                                          .where(
                                              (element) => element.isSelected)
                                          .isEmpty
                                      ? '0'
                                      : '\$${listproducProv.getProductos.where((element) => element.isSelected).map<double>((e) => e.cantidadProd.toDouble()).reduce((value1, value2) => value1 + value2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Subtotal',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  listproducProv.getProductos
                                          .where(
                                              (element) => element.isSelected)
                                          .isEmpty
                                      ? '0'
                                      : '\$${calcSubtotal(listproducProv.getProductos.where((element) => element.isSelected).toList(), listproducProv.getProductos.where((element) => element.isSelected).toList()[index])}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: listproducProv.getProductos
                                      .where((element) => element.isSelected)
                                      .isNotEmpty
                                  ? true
                                  : false,
                              child: const Column(
                                children: [
                                  SizedBox(height: 10),
                                  Divider(),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Envio',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        '100',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: listproducProv.getProductos
                                      .where((element) => element.isSelected)
                                      .isNotEmpty
                                  ? mostrarDescuento(
                                      listproducProv.getProductos
                                          .where(
                                              (element) => element.isSelected)
                                          .toList(),
                                      listproducProv.getProductos
                                          .where(
                                              (element) => element.isSelected)
                                          .toList()[index])
                                  : false,
                              child: const Column(
                                children: [
                                  SizedBox(height: 10),
                                  Divider(),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Descuento',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        '200',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  listproducProv.getProductos
                                          .where(
                                              (element) => element.isSelected)
                                          .isEmpty
                                      ? '0'
                                      : '\$${calcTotal(listproducProv.getProductos.where((element) => element.isSelected).toList(), listproducProv.getProductos.where((element) => element.isSelected).toList()[index])}',
                                  style: const TextStyle(
                                    color: kprimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 20),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Completar detalles del Pedido',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(
                                  0xFF475269,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF475269).withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Nombre del Propietario',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue:
                                      "${user.first_name} ${user.last_name}",
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    filled: true,
                                    fillColor: kcontentColor,
                                    hintText: "Entre su nombre",
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Direccion de envio',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: user.direccion,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    filled: true,
                                    fillColor: kcontentColor,
                                    hintText: 'Entre la direccion de envio',
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Número de Teléfono',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kTextColor,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  initialValue: user.telefono,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 15,
                                    ),
                                    filled: true,
                                    fillColor: kcontentColor,
                                    hintText: "Entre su Numero de Télefono",
                                    hintStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin:
                                EdgeInsets.all(SizeConfig.defaultSize! * 1.5),
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(
                                    SizeConfig.defaultSize! * 1.5),
                                backgroundColor: kprimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Comprar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.defaultSize! * 1.6,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                if (selectAll == true ||
                                    listproducProv
                                            .getProductos[index].isSelected ==
                                        true) {
                                  const transitionDuration =
                                      Duration(milliseconds: 400);

                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: transitionDuration,
                                      reverseTransitionDuration:
                                          transitionDuration,
                                      pageBuilder: (_, animation, ___) {
                                        return FadeTransition(
                                          opacity: animation,
                                          // child: const BiometricsPage(), Uses Lottie
                                          child: const CustomBiometricsPage(),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Primero debe seleccionar un producto para poder realizar la compra',
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Image.asset('assets/ripple.gif'),
          );
        },
      ),
    );
  }
}

mostrarDescuento(List<Producto> productos, Producto producto) {
  double subtotal = calcSubtotal(productos, producto);
  if (subtotal >= 1000) {
    return true;
  } else {
    return false;
  }
}

double calcSubtotal(List<Producto> productos, Producto producto) {
  return productos.length > 1
      ? productos
          .map<double>((e) => e.cantidadProd * e.precio)
          .reduce((value1, value2) => value1 + value2)
      : producto.precio * producto.cantidadProd;
}

double calcTotal(List<Producto> productos, Producto producto) {
  double total = 0;
  double subtotal = calcSubtotal(productos, producto);
  double envio = 100;
  double descuento = 200;

  if (subtotal >= 1000) {
    total = (subtotal + envio) - descuento;
    return total;
  } else {
    total = subtotal + envio;
    return total;
  }
}
