import 'dart:convert';

import 'package:asu/sepatu/pages/admin/update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class View_User extends StatefulWidget {
  const View_User({Key? key}) : super(key: key);

  @override
  State<View_User> createState() => _View_UserState();
}

class _View_UserState extends State<View_User> {
  List userdata = [];

  Future<void> deleterecord(String id) async {
    try {
      String uri = "https://dntest123.000webhostapp.com/delete_data.php";

      var res = await http.post(Uri.parse(uri), body: {"id": id});
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("record deleted");
        getrecord();
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getrecord() async {
    String uri = "https://dntest123.000webhostapp.com/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        userdata = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View User"),
      ),
      body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Update_User(
                        userdata[index]["username"],
                        userdata[index]["email"],
                        userdata[index]["password"],
                        userdata[index]["status"]
                      )));
                },
                title: Text(userdata[index]["username"]),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(userdata[index]["email"]),
                      ],
                    ),
                    Row(
                      children: [
                        Text(userdata[index]["password"])
                      ],
                    ),
                    Row(
                      children: [Text(userdata[index]["status"])],
                    )
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleterecord(userdata[index]["id"]);
                  },
                ),
              ),
            );
          }),
    );
  }
}
