// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:prueba/models/Producto.dart';
// import 'package:vector_math/vector_math_64.dart';

// class ARObjectView extends StatefulWidget {
//   @override
//   _ARObjectViewState createState() => _ARObjectViewState();
// }

// class _ARObjectViewState extends State<ARObjectView> {
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;
//   late Producto producto;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Objeto 3D')),
//       body: ARView(
//         onARViewCreated: onARViewCreated,
//       ),
//     );
//   }

//   void onARViewCreated(
//     ARSessionManager sessionManager,
//     ARObjectManager objectManager,
//     ARAnchorManager anchorManager,
//     ARLocationManager locationManager,
//   ) {
//     arSessionManager = sessionManager;
//     arObjectManager = objectManager;

//     // Carga el modelo 3D local (por ejemplo, Chicken_01.gltf)
//     final newNode = ARNode(
//       type: NodeType.localGLTF2,
//       uri: producto.modelo3dUrl,
//       scale: Vector3(0.2, 0.2, 0.2),
//       position: Vector3(0.0, 0.0, 0.0),
//       rotation: Vector4(1.0, 0.0, 0.0, 0.0),
//     );

//     arObjectManager.addNode(newNode);
//   }
// }
