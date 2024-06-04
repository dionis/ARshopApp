import 'dart:convert';
import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import '../components/Constants.dart';
import '../models/User.dart';

// Inicio de Login
Future<dynamic> userAuth(String email, String password) async {
  Map dataU = {
    "email": email,
    "password": password,
  };
  var url = Uri.parse('$baseUrl/user/auth/login/');

  var res = await http.post(url, body: dataU);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['key'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    User? user = await getUser(token);

    return user;
  } else {
    Map json = jsonDecode(res.body);
    // print(res.body);
    if (json.containsKey('email')) {
      return utf8.decode(json['email'][0].codeUnits);
    }
    if (json.containsKey('password')) {
      return utf8.decode(json['password'][0].codeUnits);
    }
    if (json.containsKey('password2')) {
      return utf8.decode(json['password2'][0].codeUnits);
    }
    if (json.containsKey('non_field_errors')) {
      if (json['non_field_errors'][0] ==
          'El correo electrÃ³nico no ha sido verificado.') {
        print(json['non_field_errors'][0]);

        return true;
      }
      return utf8.decode(json['non_field_errors'][0].codeUnits);
    }
  }
}
// Fin de Login

// Inicio de Register
Future<dynamic> registerUser(
  String email,
  String password1,
  String password2,
  String firstName,
  String lastName,
  String direccion,
  String telefono,
  File? imagen,
) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('$baseUrl/user/auth/registration/'));
  request.fields['email'] = email;
  request.fields['password1'] = password1;
  request.fields['password2'] = password2;
  request.fields['first_name'] = firstName;
  request.fields['last_name'] = lastName;
  request.fields['direccion'] = direccion;
  request.fields['telefono'] = telefono;

  if (imagen != null) {
    var stream = http.ByteStream(imagen.openRead());
    var length = await imagen.length();
    var multipartFile =
        http.MultipartFile('imagenU', stream, length, filename: imagen.path);

    request.files.add(multipartFile);
  }

  var res = await request.send();
  if (res.statusCode == 200 || res.statusCode == 201) {
    String resBody = await res.stream.bytesToString();
    print(resBody);

    Map json = jsonDecode(resBody);
    if (json.containsKey('key')) {
      String token = json['key'];
      var box = await Hive.openBox(tokenBox);
      box.put('token', token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
    if (json.containsKey('detail')) {
      String resBody = await res.stream.bytesToString();
      Map json = jsonDecode(resBody);
      return true;
    }
  } else if (res.statusCode == 400) {
    String resBody = await res.stream.bytesToString();
    print(resBody);
    Map json = jsonDecode(resBody);
    if (json.containsKey('email')) {
      return json['email'][0];
    }
    if (json.containsKey('password1')) {
      return json['password1'][0];
    }
    if (json.containsKey('non_field_errors')) {
      return json['non_field_errors'][0];
    }
    if (json.containsKey('email_already_exists')) {
      return json['email_already_exists'][0];
    }
  } else {
    return null;
  }
}
// Fin de Register

Future<dynamic> confirmEmail(String codigoConf) async {
  var url = Uri.parse('$baseUrl/user/auth/confirm-email/');
  var res = await http.post(url, body: codigoConf);

  if (res.statusCode == 200 || res.statusCode == 201) {
    return true;
  } else if (res.statusCode == 400) {
    return false;
  }
}

Future<User?> getUser(String token) async {
  var url = Uri.parse('$baseUrl/user/auth/user/');
  var res = await http.get(url, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    User user = User.fromJson(json);
    user.token = token;
    return user;
  } else {
    return null;
  }
}

Future<dynamic> actualizarUser(
  User user,
  String email,
  String firstName,
  String lastName,
  String direccion,
  String telefono,
  File? imagen,
) async {
  var headers = {
    'Authorization': 'Token ${user.token}',
    'Content-Type': 'application/json',
  };
  var request =
      http.MultipartRequest('PUT', Uri.parse('$baseUrl/user/auth/user/'));

  request.fields['email'] = email;
  request.fields['first_name'] = firstName;
  request.fields['last_name'] = lastName;
  request.fields['direccion'] = direccion;
  request.fields['telefono'] = telefono;
  request.headers.addAll(headers);

  if (imagen != null) {
    var stream = http.ByteStream(imagen.openRead());
    var length = await imagen.length();
    var multipartFile =
        http.MultipartFile('imagenU', stream, length, filename: imagen.path);

    request.files.add(multipartFile);
  }
  var res = await request.send();

  if (res.statusCode == 200 || res.statusCode == 201) {
    String resBody = await res.stream.bytesToString();
    Map json = jsonDecode(resBody);
    return User.fromJson(json);
  } else if (res.statusCode == 400) {
    String resBody = await res.stream.bytesToString();
    Map json = jsonDecode(resBody);
    if (json.containsKey('email')) {
      return 'El correo electrónico ingresado no es válido.';
    }
  } else {
    return null;
  }
}

Future<User?> logOut(String token) async {
  var url = Uri.parse('$baseUrl/user/auth/logout/');
  var res = await http.post(url, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 200 || res.statusCode == 201) {
    return null;
  }
  return null;
}
