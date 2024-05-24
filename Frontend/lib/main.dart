import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'components/Constants.dart';
import 'components/SettingSharendPrefences.dart';
import 'models/Carrito_Cubit.dart';
import 'models/User.dart';
import 'models/User_Cubit.dart';
import 'screens/pages/Principal.dart';
import 'screens/sessions/Login.dart';
import 'server/Auth_Api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> inicialToken() async {
    const storage = FlutterSecureStorage();
    SecureStorage secureStorage = SecureStorage();
    bool constainaccesstoken = await storage.containsKey(key: 'access_token');
    bool constainaccessuser = await storage.containsKey(key: 'access_user');

    if (constainaccesstoken && constainaccessuser) {
      String accessToken = await secureStorage.readSecureData('access_token');
      //String useraaa = await secureStorage.readSecureData('access_token');
      //String userMapa = jsonEncode('{}');
      return accessToken;
    } else {
      await storage.write(key: 'access_token', value: 'notToken');
      await storage.write(key: 'access_user', value: '{}');
      return 'not Token';
    }
  }

  // Future<bool> writeListPrefe() async {
  //   SPreferencesAllData? prefs = SPreferencesAllData();
  //   List<Map> listPrefeee = [];
  //   if (Provider.of<ListPedidosProvider>(context, listen: false)
  //       .getPedidos
  //       .isNotEmpty) {
  //     for (var element
  //         in Provider.of<ListPedidosProvider>(context, listen: false)
  //             .getPedidos) {
  //       listPrefeee.add(element.toMap());
  //     }
  //     bool save =
  //         await prefs.setStringAllKey(keyPrefer, jsonEncode(listPrefeee));
  //     if (save) return true;
  //     return false;
  //   } else {
  //     //aqui la lista esta vacia pq todos los elementos fueron borrados
  //     bool save = await prefs.setStringAllKey(keyPrefer, '');
  //     if (save) return true;
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarritoProvider(),
        ),
      ],
      child: MaterialApp(
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
        home: FutureBuilder<String?>(
          future: inicialToken(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var token = snapshot.data;
              if (token != null) {
                return FutureBuilder<User?>(
                  future: getUser(token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        User user = snapshot.data!;
                        user.token = token;
                        context.read<UserProvider>().setUser(user);
                        return const Principal();
                      } else {
                        return const Login();
                      }
                    } else {
                      return const Login();
                    }
                  },
                );
              } else {
                return const Login();
              }
            } else if (snapshot.hasError) {
              return const Login();
            } else {
              return const Login();
            }
          },
        ),
      ),
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
