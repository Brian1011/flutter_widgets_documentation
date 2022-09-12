import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();

  pickMultipleImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick multiple images
      final List<XFile>? images = await _picker.pickMultiImage();
      images?.forEach((element) {
        print(element.path);
      });
    } catch (e) {
      print('***********ERROR');
    }
  }

  sendToApi() {}
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMAGES"),
      ),
      body: Container(
        child: Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo))
          ],
        ),
      ),
    );
  }
}
