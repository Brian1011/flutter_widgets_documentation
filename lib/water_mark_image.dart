import 'dart:io';
import 'dart:typed_data';

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
              Container(
                  height: 400, width: 400, child: Image.file(_originalImage!)),
            TextButton(
                child: const Text("Apply Watermark Over Image"),
                onPressed: () async {
                  try {
                    ui.Image? originalImage =
                        ui.decodeImage(_originalImage!.readAsBytesSync());

                    // for adding text over image
                    // Draw some text using 24pt arial font
                    // 100 is position from x-axis, 120 is position from y-axis
                    ui.drawString(originalImage!, ui.arial_24, 0, 0, 'Think');

                    // Store the watermarked image to a File
                    List<int> wmImage = ui.encodePng(originalImage);
                    setState(() {
                      _watermarkedImage =
                          File.fromRawPath(Uint8List.fromList(wmImage));
                    });
                    print("done");
                  } catch (e) {
                    print('************ERROR');
                    print(e.toString());
                  }
                }),
            if (_watermarkedImage != null)
              Container(
                  height: 300,
                  width: 300,
                  child: Column(
                    children: [
                      Image.file(_watermarkedImage!),
                    ],
                  )),
            TextButton(
                child: const Text("Watermark version 2"),
                onPressed: () async {
                  try {
                    // Create an image
                    ui.Image image = ui.Image(320, 240);

                    // Fill it with a solid color (blue)
                    ui.fill(image, ui.getColor(0, 0, 255));

                    // Draw some text using 24pt arial font
                    ui.drawString(image, ui.arial_24, 0, 0, 'Hello World');

                    // Draw a line
                    ui.drawLine(image, 0, 0, 320, 240, ui.getColor(255, 0, 0),
                        thickness: 3);

                    // Blur the image
                    ui.gaussianBlur(image, 10);

                    var tempDir = await getExternalStorageDirectory();

                    // Save the image to disk as a PNG
                    File(tempDir!.path + '/test.png')
                        .writeAsBytesSync(ui.encodePng(image));
                    _watermarkedImage = File(tempDir.path + '/test.png');

                    setState(() {});
                  } catch (e) {
                    print('************ERROR');
                    print(e.toString());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
