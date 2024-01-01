import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Update_User extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String status;
  const Update_User(this.username, this.email, this.password, this.status,
      {super.key});

  @override
  State<Update_User> createState() => _Update_UserState();
}

class _Update_UserState extends State<Update_User> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController status = TextEditingController();

  Future<void> update() async {
    try {
      String uri = "https://dntest123.000webhostapp.com/update_data.php";

      var res = await http.post(Uri.parse(uri), body: {
        "username": username.text,
        "email": email.text,
        "password": password.text,
        "status": status.text
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("updated" );
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    username.text = widget.username;
    email.text = widget.email;
    password.text = widget.password;
    status.text = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Record")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: username,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter Username")),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter Email")),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter Password")),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: status,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text("Enter Status")),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                update();
              },
              child: const Text("update"),
            ),
          )
        ],
      ),
    );
  }
}
