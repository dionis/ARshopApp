// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:arshop_sin_auth/models/Producto.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
// import 'package:flutter/services.dart';
// import 'package:vector_math/vector_math_64.dart';
// import 'dart:math';

// class ARModelViewer extends StatefulWidget {
//   ARModelViewer({Key? key, required this.producto}) : super(key: key);
//   final Producto producto;
//   @override
//   _ARModelViewerState createState() => _ARModelViewerState();
// }

// class _ARModelViewerState extends State<ARModelViewer> {
//   ARSessionManager? arSessionManager;
//   ARObjectManager? arObjectManager;
//   ARAnchorManager? arAnchorManager;

//   List<ARNode> nodes = [];
//   List<ARAnchor> anchors = [];

//   @override
//   void dispose() {
//     super.dispose();
//     arSessionManager!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Object Transformation Gestures'),
//         ),
//         body: Container(
//             child: Stack(children: [
//           ARView(
//             onARViewCreated: onARViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
//           ),
//           Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: onRemoveEverything,
//                       child: Text("Remove Everything")),
//                 ]),
//           )
//         ])));
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;

//     this.arSessionManager!.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           showWorldOrigin: true,
//           handlePans: true,
//           handleRotation: true,
//         );
//     this.arObjectManager!.onInitialize();

//     this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager!.onPanStart = onPanStarted;
//     this.arObjectManager!.onPanChange = onPanChanged;
//     this.arObjectManager!.onPanEnd = onPanEnded;
//     this.arObjectManager!.onRotationStart = onRotationStarted;
//     this.arObjectManager!.onRotationChange = onRotationChanged;
//     this.arObjectManager!.onRotationEnd = onRotationEnded;
//   }

//   Future<void> onRemoveEverything() async {
//     /*nodes.forEach((node) {
//       this.arObjectManager.removeNode(node);
//     });*/
//     anchors.forEach((anchor) {
//       this.arAnchorManager!.removeAnchor(anchor);
//     });
//     anchors = [];
//   }

//   Future<void> onPlaneOrPointTapped(
//       List<ARHitTestResult> hitTestResults) async {
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
//     if (singleHitTestResult != null) {
//       var newAnchor =
//           ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
//       bool? didAddAnchor = await this.arAnchorManager!.addAnchor(newAnchor);
//       if (didAddAnchor!) {
//         this.anchors.add(newAnchor);
//         // Add note to anchor
//         var newNode = ARNode(
//             type: NodeType.webGLB,
//             uri: widget.producto.modelo3dUrl,
//             scale: Vector3(2, 2, 2),
//             position: Vector3(0.0, 0.0, 0.0),
//             rotation: Vector4(1.0, 0.0, 0.0, 0.0));
//         bool? didAddNodeToAnchor = await this
//             .arObjectManager!
//             .addNode(newNode, planeAnchor: newAnchor);
//         if (didAddNodeToAnchor!) {
//           this.nodes.add(newNode);
//         } else {
//           this.arSessionManager!.onError("Adding Node to Anchor failed");
//         }
//       } else {
//         this.arSessionManager!.onError("Adding Anchor failed");
//       }
//     }
//   }

//   onPanStarted(String nodeName) {
//     print("Started panning node " + nodeName);
//   }

//   onPanChanged(String nodeName) {
//     print("Continued panning node " + nodeName);
//   }

//   onPanEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended panning node " + nodeName);
//     final pannedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     //pannedNode.transform = newTransform;
//   }

//   onRotationStarted(String nodeName) {
//     print("Started rotating node " + nodeName);
//   }

//   onRotationChanged(String nodeName) {
//     print("Continued rotating node " + nodeName);
//   }

//   onRotationEnded(String nodeName, Matrix4 newTransform) {
//     print("Ended rotating node " + nodeName);
//     final rotatedNode =
//         this.nodes.firstWhere((element) => element.name == nodeName);

//     /*
//     * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
//     * (e.g. if you intend to share the nodes through the cloud)
//     */
//     //rotatedNode.transform = newTransform;
//   }
// }

// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:arshop_sin_auth/models/Producto.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart';

// class ARModelViewer extends StatefulWidget {
//   const ARModelViewer({super.key, required this.producto});
//   final Producto producto;
//   @override
//   State<ARModelViewer> createState() => _ARModelViewerState();
// }

// class _ARModelViewerState extends State<ARModelViewer> {
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;
//   ARNode? modelo3DNode;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Objeto 3D')),
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
//       type: NodeType.webGLB,
//       uri: widget.producto.modelo3dUrl,
//       scale: Vector3(0.2, 0.2, 0.2),
//       position: Vector3(0.0, 0.0, 0.0),
//       rotation: Vector4(1.0, 0.0, 0.0, 0.0),
//     );

//     arObjectManager.addNode(newNode);
//   }
// }

import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../models/producto.dart';

class ARModelViewer extends StatefulWidget {
  const ARModelViewer({
    super.key,
    required this.producto,
  });
  final Producto producto;

  @override
  State<ARModelViewer> createState() => _ARModelViewerState();
}

class _ARModelViewerState extends State<ARModelViewer> {
  // ArScale arScale = ArScale();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.producto.nombre,
        ),
      ),
      body: ModelViewer(
        src: widget.producto.modelo3dUrl,
        alt: widget.producto.nombre,
        ar: true,
        autoRotate: true,
        cameraControls: true,
        arPlacement: ArPlacement.floor,
        scale:
            '${widget.producto.largo} ${widget.producto.ancho} ${widget.producto.alto}',
      ),
    );
  }
}


        // 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
        // 'http://10.30.118.222:5000/web/Fox.glb',

// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:arshop_sin_auth/models/Producto.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vec;

// class Mostrar3D extends StatefulWidget {
//   const Mostrar3D({super.key, required this.producto});
//   final Producto producto;

//   @override
//   State<Mostrar3D> createState() => _Mostrar3DState();
// }

// class _Mostrar3DState extends State<Mostrar3D> {
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;
//   ARNode? modelo3DNode;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Modelo 3D en AR"),
//       ),
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

//     // Inicializa la sesión AR y el objeto AR
//     arSessionManager.onInitialize();
//     arObjectManager.onInitialize();

//     // Carga el modelo 3D (por ejemplo, desde un archivo local)
//     cargarModelo3D();
//   }

//   Future<void> cargarModelo3D() async {
//     if (modelo3DNode != null) {
//       arObjectManager.removeNode(modelo3DNode!);
//       modelo3DNode = null;
//     } else {
//       const rutaModelo3D = 'assets/Chicken_01.gltf';

//       final newNode = ARNode(
//         // type: NodeType.webGLB,
//         type: NodeType.localGLTF2,
//         uri: rutaModelo3D,
//         // uri: widget.producto.modelo3dUrl,
//         scale: vec.Vector3(0.1, 0.1, 0.1),
//         position: vec.Vector3(0.0, 0.0, -1.0),
//         rotation: vec.Vector4(0.0, 0.0, 0.0, 1.0),
//       );

//       final seAgregoNodo = await arObjectManager.addNode(newNode);
//       modelo3DNode = seAgregoNodo != null ? newNode : null;
//     }
//   }
// }

// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class Mostrar3D extends StatefulWidget {
//   const Mostrar3D({super.key});

//   @override
//   State<Mostrar3D> createState() => _Mostrar3DState();
// }

// class _Mostrar3DState extends State<Mostrar3D> {
//   late ArCoreController arCoreController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hello World'),
//       ),
//       body: ArCoreView(
//         onArCoreViewCreated: _onArCoreViewCreated,
//       ),
//     );
//   }

//   void _onArCoreViewCreated(ArCoreController controller) {
//     arCoreController = controller;

//     _addSphere(arCoreController);
//     _addCylindre(arCoreController);
//     _addCube(arCoreController);
//   }

//   void _addSphere(ArCoreController controller) {
//     final material = ArCoreMaterial(color: Color.fromARGB(120, 66, 134, 244));
//     final sphere = ArCoreSphere(
//       materials: [material],
//       radius: 0.1,
//     );
//     final node = ArCoreNode(
//       shape: sphere,
//       position: vector.Vector3(0, 0, -1.5),
//     );
//     controller.addArCoreNode(node);
//   }

//   void _addCylindre(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Colors.red,
//       reflectance: 1.0,
//     );
//     final cylindre = ArCoreCylinder(
//       materials: [material],
//       radius: 0.5,
//       height: 0.3,
//     );
//     final node = ArCoreNode(
//       shape: cylindre,
//       position: vector.Vector3(0.0, -0.5, -2.0),
//       rotation: vector.Vector4(0, 0, 0, 2.0),
//     );
//     controller.addArCoreNode(node);
//   }

//   void _addCube(ArCoreController controller) {
//     final material = ArCoreMaterial(
//       color: Color.fromARGB(120, 66, 134, 244),
//       metallic: 1.0,
//     );
//     final cube = ArCoreCube(
//       materials: [material],
//       size: vector.Vector3(0.5, 0.5, 0.5),
//     );
//     final node = ArCoreNode(
//       shape: cube,
//       position: vector.Vector3(-0.5, 0.5, -3.5),
//     );
//     controller.addArCoreNode(node);
//   }

//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }
// }

// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/widgets/ar_view.dart';
// import 'package:arshop_sin_auth/models/Producto.dart';
// import 'package:flutter/material.dart';

// class Mostrar3D extends StatefulWidget {
//   const Mostrar3D({super.key, required this.producto});
//   final Producto producto;

//   @override
//   State<Mostrar3D> createState() => _Mostrar3DState();
// }

// class _Mostrar3DState extends State<Mostrar3D> {
//   late ARSessionManager arSessionManager;

//   late ARObjectManager arObjectManager;

//   ARNode? localObject;

//   ARNode? webObject;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.producto.nombre,
//         ),
//       ),
//       body: Column(
//         children: [
//           // ARView(onARViewCreated: onARViewCreated),
//           ElevatedButton(
//             onPressed: onLocalObjectButtonPressed,
//             child: const Text('Local'),
//           ),
//           ElevatedButton(
//             onPressed: onWebObjectButtonPressed,
//             child: const Text('Web'),
//           ),
//         ],
//       ),
//     );
//   }

//   void onARViewCreated(
//     ARSessionManager sessionManager,
//     ARObjectManager objectManager,
//     ARAnchorManager arAnchorManager,
//     ARLocationManager arLocationManager,
//   ) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;

//     this.arSessionManager.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: 'assets/triangle.png',
//           showWorldOrigin: true,
//           handleTaps: false,
//         );

//     this.arObjectManager.onInitialize();
//   }

//   void onLocalObjectButtonPressed() async {
//     if (localObject != null) {
//       arObjectManager.removeNode(localObject!);
//       localObject = null;
//     } else {
//       var newNode =
//           ARNode(type: NodeType.localGLTF2, uri: 'assets/Chicken_01.gltf');

//       bool? didAddLocalNode = await arObjectManager.addNode(newNode);
//       if (didAddLocalNode!) {
//         localObject = newNode;
//       } else {
//         localObject = null;
//       }
//     }
//   }

//   void onWebObjectButtonPressed() async {
//     if (webObject != null) {
//       arObjectManager.removeNode(webObject!);
//       webObject = null;
//     } else {
//       var newNode = ARNode(
//         type: NodeType.webGLB,
//         uri:
//             'https://github.com/KhronosGroup/glTF-Sample-Models/tree/d7a3cc8e51d7c573771ae77a57f16b0662a905c6/2.0/Fox/glTF-Binary/Fox.glb',
//       );

//       bool? didAddLocalNode = await arObjectManager.addNode(newNode);
//       if (didAddLocalNode!) {
//         webObject = newNode;
//       } else {
//         webObject = null;
//       }
//     }
//   }
// }
