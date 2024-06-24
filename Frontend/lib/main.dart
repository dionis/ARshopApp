import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'components/constants.dart';
import 'screens/pages/principal.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ARShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kcontentColor,
        primaryColor: kprimaryColor,
        hintColor: kprimaryColor.withOpacity(0.4),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Intel",
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: kTextColor, fontFamily: 'Intel'),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: HexColor('#8AD2AE')),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 255, 255, 255),
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: const Principal(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

// import 'package:flutter/material.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(),
//         body: ModelViewer(
//           src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
//           alt: "A 3D model of an astronaut",
//           ar: true,
//           autoRotate: true,
//           cameraControls: true,
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:flutter/services.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';

// import 'screens/Mostrar3d/examples/debugoptionsexample.dart';
// import 'screens/Mostrar3d/examples/objectgesturesexample.dart';
// import 'screens/Mostrar3d/examples/objectsonplanesexample.dart';
// import 'screens/Mostrar3d/examples/screenshotexample.dart';
// import 'screens/components/ARModelViewer.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String _platformVersion = 'Unknown';
//   static const String _title = 'AR Plugin Demo';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await ArFlutterPlugin.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _platformVersion = platformVersion;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(_title),
//         ),
//         body: Column(children: [
//           Text('Running on: $_platformVersion\n'),
//           Expanded(
//             child: ExampleList(),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class ExampleList extends StatelessWidget {
//   ExampleList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final examples = [
//       Example(
//           'Debug Options',
//           'Visualize feature points, planes and world coordinate system',
//           () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => DebugOptionsWidget()))),
//       // Example(
//       //   'Local & Online Objects',
//       //   'Place 3D objects from Flutter assets and the web into the scene',
//       //   // () => Navigator.push(
//       //   //   context,
//       //   //   MaterialPageRoute(
//       //   //     builder: (context) => LocalAndWebObjectsWidget(),
//       //   //   ),
//       //   // ),
//       // ),
//       Example(
//           'Anchors & Objects on Planes',
//           'Place 3D objects on detected planes using anchors',
//           () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => ObjectsOnPlanesWidget()))),
//       Example(
//           'Object Transformation Gestures',
//           'Rotate and Pan Objects',
//           () => Navigator.push(context,
//               MaterialPageRoute(builder: (context) => ObjectGesturesWidget()))),
//       Example(
//         'Screenshots',
//         'Place 3D objects on planes and take screenshots',
//         () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ScreenshotWidget(),
//           ),
//         ),
//       ),
//       Example(
//         'Mi prueba',
//         'Place 3D objects on planes and take screenshots',
//         () { 
          
//           Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ARModelViewer(producto: ,),
//           ),
//         );}
//       ),

//       // Example(
//       //   'Cloud Anchors',
//       //   'Place and retrieve 3D objects using the Google Cloud Anchor API',
//       //   // () => Navigator.push(
//       //   //   context,
//       //   //   MaterialPageRoute(
//       //   //     builder: (context) => CloudAnchorWidget(),
//       //   //   ),
//       //   // ),
//       // ),
//       // Example(
//       //   'External Model Management',
//       //   'Similar to Cloud Anchors example, but uses external database to choose from available 3D models',
//       //   // () => Navigator.push(
//       //   //   context,
//       //   //   MaterialPageRoute(
//       //   //     builder: (context) => ExternalModelManagementWidget(),
//       //   //   ),
//       //   // ),
//       // ),
//     ];
//     return ListView(
//       children:
//           examples.map((example) => ExampleCard(example: example)).toList(),
//     );
//   }
// }

// class ExampleCard extends StatelessWidget {
//   ExampleCard({Key? key, required this.example}) : super(key: key);
//   final Example example;

//   @override
//   build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         splashColor: Colors.blue.withAlpha(30),
//         onTap: () {
//           example.onTap();
//         },
//         child: ListTile(
//           title: Text(example.name),
//           subtitle: Text(example.description),
//         ),
//       ),
//     );
//   }
// }

// class Example {
//   const Example(this.name, this.description, this.onTap);
//   final String name;
//   final String description;
//   final Function onTap;
// }
