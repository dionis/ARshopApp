import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../components/Header.dart';
import '../../components/Image_Picker.dart';
import '../../components/Size_Config.dart';
import '../../components/Theme_Helper.dart';
import '../../models/User.dart';
import '../../server/Auth_Api.dart';
import '../pages/Principal.dart';

class ActualizarPage extends StatefulWidget {
  const ActualizarPage({super.key, required this.userToEdit});

  final User userToEdit;

  @override
  State<ActualizarPage> createState() => _ActualizarPageState();
}

bool showPassword1 = false;
bool showPassword2 = false;

String firsName = '';
String lastName = '';
String email = '';
String direccion = '';
String telefono = '';
String imagenUrl = '';
File? imagen;

class _ActualizarPageState extends State<ActualizarPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: defaultsize! * 0.5),
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
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ImagePickerWidget(
                          imageFile: imagen,
                          onImageSelected: (File? file) {
                            setState(() {
                              imagen = file;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            initialValue: firsName,
                            decoration: ThemeHelper().textInputDecoration(
                                "Nombre", "Entre su nombre"),
                            onChanged: (newValue) {
                              firsName = newValue;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            initialValue: lastName,
                            onChanged: (newValue) {
                              lastName = newValue;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Apellidos", "Entre sus apellidos"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            initialValue: email,
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail", "Entre su email"),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (newValue) {
                              email = newValue;
                            },
                            validator: (val) {
                              if ((val!.isNotEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Entre un Email valido";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            initialValue: telefono,
                            decoration: ThemeHelper().textInputDecoration(
                                "Numero de Télefono",
                                "Entre su Numero de Télefono"),
                            keyboardType: TextInputType.phone,
                            onChanged: (newValue) {
                              telefono = newValue;
                            },
                            validator: (val) {
                              if ((val!.isNotEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Entre un Numero de Télefono valido";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                          child: TextFormField(
                            initialValue: direccion,
                            onChanged: (newValue) {
                              direccion = newValue;
                            },
                            decoration: ThemeHelper().textInputDecoration(
                                "Dirección", "Entre su Direccion"),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Actualizar".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var authRes = await actualizarUser(
                                  widget.userToEdit,
                                  email,
                                  firsName,
                                  lastName,
                                  direccion,
                                  telefono,
                                  imagen,
                                );
                                if (authRes.runtimeType == String) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authRes),
                                    ),
                                  );
                                } else if (authRes.runtimeType == User) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Principal()),
                                      (Route<dynamic> route) => false);
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    firsName = widget.userToEdit.first_name!;
    lastName = widget.userToEdit.last_name!;
    email = widget.userToEdit.email!;
    telefono = widget.userToEdit.telefono!;
    direccion = widget.userToEdit.direccion!;
  }
}
