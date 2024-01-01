import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:toast/toast.dart';
import '../../widget/credential.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController user = TextEditingController();

  bool verifybutton = false;
  var verifylink;

  Future checkUser() async {
    var url = Uri.parse('https://dntest123.000webhostapp.com/check.php');
    var response = await http.post(url, body: {
      "username": user.text,
    });
    var link = jsonDecode(response.body);
    if (link == "INVALIDUSER") {
      showToast("This user is not in our database",
          duration: 6, gravity: Toast.center);
    } else {
      setState(() {
        sendMail();
        verifylink = link;
        verifybutton = true;
      });
      showToast("Click Verify Button to Reset Password",
          duration: 4, gravity: Toast.center);
    }
    print(link);
  }

  int newPass = 0;
  Future resetPassword(String verifylink) async {
    var url = Uri.parse(verifylink);
    var response = await http.post(url);
    var link = jsonDecode(response.body);
    setState(() {
      newPass = link;
      verifybutton = false;
    });
    print(link);
    showToast("Your Password Has Been Reset : $newPass",
        duration: 4, gravity: Toast.center);
  }

  sendMail() async {
    String username = EMAIL;
    String password = PASS;

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username)
      ..recipients.add('sitorusyosua06@gmail.com')
      ..subject =
          'Password Recover link from APP Shopping ubsi : ${DateTime.now()}'
      ..html =
          "<h3>Thanks for with localhost. Please click this Link To Reset your Password</h3>\n<p> <a href='$verifylink'>Click me to Reset</></p>";
    try {
      final SendReport = await send(message, smtpServer);
      print('Message Sent: ' + SendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password Recover"),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: user,
              decoration: InputDecoration(hintText: "User Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.red,
              onPressed: () {
                checkUser();
              },
              child: Text("Recover Password"),
            ),
          ),
          verifybutton
              ? MaterialButton(
                  color: Colors.amber,
                  onPressed: () {
                    resetPassword(verifylink);
                  },
                  child: Text("Verify"),
                )
              : Container(),
          newPass == 0 ? Container() : Text('New Password is: $newPass')
        ],
      )),
    );
  }

  showToast(String msg, {required int duration, required int gravity}) {
    Toast.show(msg, textStyle: context, duration: duration, gravity: gravity);
  }
}
