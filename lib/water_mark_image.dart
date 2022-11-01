import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WaterMarkImage extends StatefulWidget {
  const WaterMarkImage({Key? key}) : super(key: key);

  @override
  State<WaterMarkImage> createState() => _WaterMarkImageState();
}

class _WaterMarkImageState extends State<WaterMarkImage> {
  List<XFile>? documentImages = [];
  late File _originalImage;
  final picker = ImagePicker();
  // list of multipart files
  List<MultipartFile> processedImages = [];
  pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _originalImage = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watermark Image"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Center(
                child: IconButton(
                    onPressed: pickImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 40,
                    ))),
            const SizedBox(
              height: 10,
            ),
            if (_originalImage != null)
              Container(
                  height: 400, width: 400, child: Image.file(_originalImage))
          ],
        ),
      ),
    );
  }
}
