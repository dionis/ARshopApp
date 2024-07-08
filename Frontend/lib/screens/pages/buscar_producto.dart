import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/constants.dart';
import '../../components/size_config.dart';
import '../../models/producto.dart';
import '../../server/producto_api.dart';
import '../components/product_card.dart';
import '../components/recommand_product.dart';
import 'product_info.dart';

class BuscarProducto extends StatefulWidget {
  const BuscarProducto({super.key});

  @override
  State<BuscarProducto> createState() => _BuscarProductoState();
}

class _BuscarProductoState extends State<BuscarProducto> {
  final TextEditingController _controller = TextEditingController();

  bool _isSearching = false;

  List<Producto> productosResult = [];

  void searchProuct(String producto) async {
    if (producto.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      try {
        List<Producto> results = await buscarProducto(producto);
        setState(() {
          productosResult = results;
          if (productosResult.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Producto no encontrado'),
              ),
            );
          }
        });
      } catch (e) {
        setState(() {
          _isSearching = false;
        });
      }
    } else {
      setState(() {
        productosResult.clear();
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: defaultsize! * 2.5),
              height: size.height * 0.18,
              // 130,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: defaultsize * 0.5),
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
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: defaultsize,
                      right: defaultsize,
                      bottom: defaultsize,
                    ),
                    height: size.height * 0.14,
                    // 100,
                    decoration: const BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: defaultsize * 3),
                          child: Text('Encuentra cualquier cosa',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Gugi',
                                fontSize: defaultsize * 2.3,
                              )),
                        ),
                        const Spacer(),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: defaultsize * 3),
                            child: ClipOval(
                                child: Image.asset(
                              "assets/icons/ic_launcher.png",
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: defaultsize * 2),
                      margin: EdgeInsets.symmetric(horizontal: defaultsize * 2),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: kprimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Buscar',
                                hintStyle: TextStyle(
                                  color: kprimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onChanged: (value) {
                                searchProuct(value);
                              },
                            ),
                          ),
                          SvgPicture.asset("assets/icons/search.svg")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !_isSearching
                ? FutureBuilder(
                    future: geListOfProducto(),
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
                : Padding(
                    padding: EdgeInsets.all(defaultsize * 2),
                    child: GridView.builder(
                      itemCount: productosResult.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            SizeConfig.orientation == Orientation.portrait
                                ? 2
                                : 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.693,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        producto: productosResult[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductInfo(
                                producto: productosResult[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
