import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController caption = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;
  ImagePicker imagePicker = ImagePicker();

  Future<void> uploadimage() async {
    try {
      String uri = "https://dntest123.000webhostapp.com/upload_image/upload.php";
      var res = await http.post(Uri.parse(uri), body: {
        "caption": caption.text,
        "data": imagedata,
        "name": imagename
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("uploaded");
      } else
        print("some issue");
    } catch (e) {
      print(e);
    }
  }

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagepath = File(getimage!.path);
      imagename = getimage.path.split('/').last;
      imagedata = base64Encode(imagepath!.readAsBytesSync());
      print(imagepath);
      print(imagename);
      print(imagedata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("upload image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: caption,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter The Caption")),
            ),
            SizedBox(
              height: 20,
            ),
            imagepath != null
                ? Image.file(imagepath!)
                : Text("Image Not Choose Yet"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: Text("Change Image"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  uploadimage();
                });
              },
              child: Text("Upload"),
            ),
          ],
        ),
      ),
    );
  }
}
