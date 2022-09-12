import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<XFile>? documentImages = [];
  pickMultipleImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick multiple images
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        documentImages = images;
        for (var element in images) {
          print('*********IMAGE PATH');
          print(element.path);
        }
      }
    } catch (e) {
      print('***********ERROR ${e}');
    }
  }

  sendToApi() async {
    Response response;
    var dio = Dio();
    var data = {'data_field_1': 'one', 'images': documentImages};
    response = await dio.post('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMAGES"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Center(
                child: IconButton(
                    onPressed: pickMultipleImages,
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 40,
                    )))
          ],
        ),
      ),
    );
  }
}
