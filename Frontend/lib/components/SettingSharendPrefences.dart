import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// const tokenKey = 'NOTEPADTOKEN';

class SecureStorage {
  //final FlutterSecureStorage storage = const FlutterSecureStorage();

  final storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    // bool resp = false;
    await storage.write(key: key, value: value);
    // .then((value) {
    //   resp = true;
    // });
    // return resp;
  }

  Future<String> readSecureData(String key) async {
    bool contains = await storage.containsKey(key: key);

    String? value = 'NoData';
    if (contains) {
      value = await storage.read(key: key) ?? 'NoData';
      return value;
    } else {
      return value;
    }
  }
}
