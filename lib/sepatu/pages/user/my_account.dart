import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAccount extends StatefulWidget {
  MyAccount({super.key, required this.id});
  String id;

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://dntest123.000webhostapp.com/detail.php?id='$widget.id'"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          nameController = TextEditingController(text: data['username']);
          emailController = TextEditingController(text: data['email']);
          passController = TextEditingController(text: data['password']);
        });
      }
    } catch (e) {
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse("https://dntest123.000webhostapp.com/edit.php"),
        body: {
          "id": widget.id,
          "username": nameController.text,
          "email": emailController.text,
          "password": passController.text,
        },
      ).then((value) {
        var data = jsonDecode(value.body);
        print(data["meassage"]);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundTopCircle(),
          buildBackgroundBottomCircle(),
          SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 40),
            child: Column(
              children: [
                const SizedBox(
                  height: 130,
                ),
                const Text(
                  "Change User Information",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  height: 320,
                  margin: const EdgeInsets.only(top: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ]),
                  child: SingleChildScrollView(
                    child: buildSignupTextField(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 2,
                        ),
                        buildEditButton(),
                        const SizedBox(
                          width: 25,
                        ),
                        buildDeleteButton(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildTextField(TextEditingController controller, String labelText,
      String placeholder, bool isPassword) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(color: Colors.blue, fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: placeholder,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Color.fromARGB(255, 160, 150, 150),
                ))),
          )
        ],
      ),
    );
  }

  Column buildSignupTextField() {
    return Column(
      children: [
        buildTextField(nameController, "Username", "tes123", false),
        const SizedBox(
          height: 30,
        ),
        buildTextField(
            emailController, "Email Address", "example@gmail.com", false),
        const SizedBox(
          height: 30,
        ),
        buildTextField(passController, "Password", "*******", true),
      ],
    );
  }

  Positioned buildBackgroundBottomCircle() {
    return Positioned(
      top: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.width,
      right: MediaQuery.of(context).size.width / 2,
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(0.15),
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width)),
      ),
    );
  }

  Positioned buildBackgroundTopCircle() {
    return Positioned(
      child: Transform.translate(
        offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.3),
        child: Transform.scale(
          scale: 1.35,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.width)),
          ),
        ),
      ),
    );
  }

  Container buildEditButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              elevation: 10),
          onPressed: () => {_onUpdate(context)},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "EDIT",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.black,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Container buildDeleteButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              elevation: 10),
          onPressed: () {},
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "DELETE",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.black,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
