import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  File? _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void makeImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: _image == null
                      ? const Center(child: Text("Изображение не выбрано"))
                      : Image.file(_image!)),
              ElevatedButton(
                onPressed: () {
                  makeImage();
                },
                child: const Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    Text("Сделать фото")
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: const Row(
                  children: [
                    Icon(Icons.photo_library),
                    SizedBox(width: 10),
                    Text("Выбрать фото")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
