import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ui;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class WaterMarkImage extends StatefulWidget {
  const WaterMarkImage({Key? key}) : super(key: key);

  @override
  State<WaterMarkImage> createState() => _WaterMarkImageState();
}

class _WaterMarkImageState extends State<WaterMarkImage> {
  List<XFile>? documentImages = [];
  File? _originalImage;
  File? _watermarkedImage;
  final picker = ImagePicker();
  // list of multipart files
  List<MultipartFile> processedImages = [];
  pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _originalImage = File(pickedFile!.path);
    });
  }

  addWaterMarkToImage() async {
    try {
      //clear old image
      _watermarkedImage = null;
      // create a new image from the image picked from gallery
      ui.Image? originalImage =
          ui.decodeImage(_originalImage!.readAsBytesSync());

      // for adding text over image
      // Draw some text using 24pt arial font
      // 100 is position from x-axis, 120 is position from y-axis
      print(originalImage?.width.toString());
      print(originalImage?.width.round().toString());
      print("think one".length);
      ui.drawString(
          originalImage!,
          ui.arial_48,
          (originalImage.width.round() - 400),
          (originalImage.height.round() - 50),
          'Think one');

      // Store the watermarked image to a File
      List<int> wmImage = ui.encodePng(originalImage);

      // create temporary directory on storage
      var tempDir = await getExternalStorageDirectory();

      // generate random name
      Random _random = Random();
      String randomFileName = _random.nextInt(10000).toString();

      // store new image on filename
      File(tempDir!.path + '/$randomFileName.png')
          .writeAsBytesSync(ui.encodePng(originalImage));

      setState(() {
        _watermarkedImage = File(tempDir.path + '/$randomFileName.png');
      });
      print("done");
    } catch (e) {
      print(e.toString());
    }
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
        child: ListView(
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
              SizedBox(
                  height: 400, width: 400, child: Image.file(_originalImage!)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: OutlinedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size.fromHeight(40)),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text("Apply Watermark Over Image"),
                  onPressed: addWaterMarkToImage),
            ),
            if (_watermarkedImage != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.file(_watermarkedImage!),
              ),
          ],
        ),
      ),
    );
  }
}
