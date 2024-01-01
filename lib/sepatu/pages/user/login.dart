import 'dart:convert';
import 'package:asu/main.dart';
import 'package:asu/sepatu/pages/admin/admin.dart';
import 'package:asu/sepatu/pages/user/forget_password.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final blueColor = const Color(0xff5e52f3);
  final yellowColor = const Color(0xfffdd835);
  late String username, password, status, email, image;
  late TapGestureRecognizer _tapGestureRecognizer;
  late bool _showSignIn;
  String alert = "Silahkan Login";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final statusController = TextEditingController();
  final imagesController = TextEditingController();
  bool visible = false;

  void prosesLogin() async {
    final response = await http.post(
        Uri.parse("https://dntest123.000webhostapp.com/loginAdminUser.php"),
        body: {
          "username": nameController.text,
          "password": passController.text
        });

    var dataUser = json.decode(response.body);
    if (dataUser.length < 1) {
      setState(() {
        alert = "Data User Tidak Ada";
      });
    } else {
      setState(() {
        username = dataUser[0]['username'];
        password = dataUser[0]['password'];
        status = dataUser[0]['status'];
        email = dataUser[0]['email'];
        image = dataUser[0]['image'];
      });

      if (status == 'admin') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AdminPage(username: username, email: email, image: image)));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: ''),
            ));
      }
    }
    return dataUser;
  }

  Future register() async {
    setState(() {
      visible = true;
    });
    String name = nameController.text;
    String email = emailController.text;
    String pass = passController.text;
    String status = statusController.text;
    String images = imagesController.text;

    var url = Uri.parse('https://dntest123.000webhostapp.com/register.php');
    var data = {
      'username': name,
      'email': email,
      'password': pass,
      'status': status,
      "image": images
    };
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text(message), actions: [
            FloatingActionButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ]);
        });
  }

  @override
  void initState() {
    super.initState();
    _showSignIn = true;
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _showSignIn = !_showSignIn;
        });
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundTopCircle(),
          buildBackgroundBottomCircle(),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 50, bottom: 40),
                child: Column(
                  children: [
                    Text(
                      _showSignIn ? "SIGN IN" : "Create Account",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    buildAvatarContainer(),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      height: _showSignIn ? 240 : 320,
                      margin: EdgeInsets.only(top: _showSignIn ? 40 : 30),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
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
                        child: _showSignIn
                            ? buildSigninTextField()
                            : buildSignupTextField(),
                      ),
                    ),
                    _showSignIn ? buildSigninButton() : buildSignupButton()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildSigninButton() {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForgetPassword()));
            },
            child: Text(
              "Forget Password ?",
              style: TextStyle(
                color: blueColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                elevation: 10),
            onPressed: prosesLogin,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.yellow,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
                text: "Don't have an account ?",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Create an account",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: blueColor,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ],
      ),
    );
  }

  Container buildSignupButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: yellowColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                elevation: 10),
            onPressed: register,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "SUBMIT",
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
          const SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
                text: "Already have an account ?",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: "Sign In",
                      recognizer: _tapGestureRecognizer,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: blueColor,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ],
      ),
    );
  }

  Column buildSigninTextField() {
    return Column(
      children: [
        buildTextField(nameController, "Username", "username", false),
        const SizedBox(
          height: 30,
        ),
        buildTextField(passController, "PASSWORD", "******", true),
      ],
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
        const SizedBox(
          height: 30,
        ),
        buildTextField(statusController, "Status", "admin/user", false),
        buildTextField(imagesController, "image", "-", false)
      ],
    );
  }

  buildTextField(TextEditingController controller, String labelText,
      String placeholder, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(color: blueColor, fontSize: 12),
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
    );
  }

  Container buildAvatarContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          color: _showSignIn ? yellowColor : Colors.grey[800],
          borderRadius: BorderRadius.circular(65),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 20,
            )
          ]),
      child: Center(
        child: Stack(
          children: [
            Positioned(
                left: 1.0,
                top: 3.0,
                child: Icon(
                  Icons.person_outline,
                  size: 60,
                  color: Colors.black.withOpacity(.1),
                )),
            const Icon(
              Icons.person_outline,
              size: 60,
              color: Colors.white,
            ),
          ],
        ),
      ),
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
            color: blueColor.withOpacity(0.15),
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
                color: _showSignIn ? Colors.grey[800] : blueColor,
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.width)),
          ),
        ),
      ),
    );
  }
}
