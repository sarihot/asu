import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class View_Image extends StatefulWidget {
  const View_Image({super.key});

  @override
  State<View_Image> createState() => _View_ImageState();
}

class _View_ImageState extends State<View_Image> {
  List record = [];

  Future<void> imagefromdb() async {
    try {
      String uri = "https://dntest123.000webhostapp.com/upload_image/view_image.php";
      var response = await http.get(Uri.parse(uri));
        setState(() {
          record = jsonDecode(response.body);
        });
      
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    imagefromdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Product "),
      ),
      body: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: record.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(child: Expanded(
                    child: Image.network("https://dntest123.000webhostapp.com/upload_image/" +
                    record[index]["image_path"]),
                  ),
                  ),
                  Container(
                    child: Text(record[index]["caption"]),
                  )

                  ],
              ),
            );
          }),
    );
  }
}
