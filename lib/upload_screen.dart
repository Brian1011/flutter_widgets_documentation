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
  // list of multipart files
  List<MultipartFile> processedImages = [];
  pickMultipleImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      // Pick multiple images
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        documentImages = images;
        processedImages = [];
        for (var element in images) {
          print('*********IMAGE PATH');
          print(element.path);

          // add to multipart file
          /* processedImages.add(MultipartFile(
              File(element.path).readAsBytes().asStream(),
              File(element.path).lengthSync(),
              filename: element.path.split("/").last));*/

          processedImages.add(await MultipartFile.fromFile(element.path));
        }
      }
    } catch (e) {
      print('***********IMAGES ERROR ${e}');
    }
  }

  sendToApi() async {
    Response response;
    var dio = Dio();

    // create data variable
    var data = {'data_field_1': 'one', 'fileName': processedImages};

    // convert data to form data
    var newData = FormData.fromMap(data);

    // call the api with the data
    await dio
        .post('http://192.168.100.213:8000/api/multiple-image-upload',
            data: newData)
        .then((dataResponse) {
      print(dataResponse);
    }).catchError((error) {
      print('******************ERROR');
      print(error);
    });
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
                    ))),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: IconButton(
                    onPressed: sendToApi,
                    icon: const Icon(
                      Icons.send,
                      size: 40,
                    ))),
          ],
        ),
      ),
    );
  }
}
