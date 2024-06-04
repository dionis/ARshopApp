import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

typedef OnImageSelected = Function(File? imageFile);

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.imageFile,
    required this.onImageSelected,
    // required this.imagenUrl,
  });
  final File? imageFile;
  final OnImageSelected onImageSelected;
  // final String imagenUrl;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPickerOptions(context);
      },
      child: imageFile != null
          ? ClipOval(
              child: Image.file(
                imageFile!,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 5, color: Colors.white),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey.shade300,
                    size: 80.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.grey.shade700,
                    size: 25.0,
                  ),
                ),
              ],
            ),
    );
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camara'),
              onTap: () {
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeria'),
              onTap: () {
                _pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  void _pickImage(BuildContext context, source) async {
    // var image = await ImagePicker().pickImage(source: source);
    // onImageSelected(image as );
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final img = File(image.path);
      onImageSelected(img);
    } on PlatformException catch (e) {
      print('Fallo al cagar la imagen: $e');
    }
  }
}


  // Future _pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final img = File(image.path);
  //     setState(() {
  //       _image = img;
  //       Navigator.pop(context);
  //     });
  //   } on PlatformException catch (e) {
  //     print('Fallo al cagar la imagen: $e');
  //   }
  // }