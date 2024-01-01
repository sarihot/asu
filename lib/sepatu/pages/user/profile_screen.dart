import 'dart:io';
import 'package:asu/sepatu/pages/user/chat_screen.dart';
import 'package:asu/sepatu/pages/user/login.dart';
import 'package:asu/sepatu/pages/user/my_account.dart';
import 'package:asu/sepatu/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          ProfilePic(),
          const SizedBox(
            height: 30,
          ),
          
          ProfileMenu(
            text: 'My Account',
            icon: const Icon(Icons.account_circle),
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyAccount(
                            id: '',
                          )));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenu(
            text: 'Notification',
            icon: const Icon(Icons.notifications_active),
            press: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenu(
            text: 'Settting',
            icon: const Icon(Icons.settings),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenu(
            text: 'Help Center',
            icon: const Icon(Icons.account_circle_outlined),
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatScreen()));
            },
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenu(
            text: 'Logout',
            icon: const Icon(Icons.logout),
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.red[400]),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.red[400],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfilePic extends StatelessWidget {
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();

  SignUpController signUpController = Get.find();

  ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Obx(() => CircleAvatar(
                  backgroundImage: signUpController.isProficPicPathSet.value ==
                          true
                      ? FileImage(File(signUpController.profilePicPath.value))
                          as ImageProvider
                      : const AssetImage("images/gm.png"))),
              Positioned(
                right: 12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => bottomSheet(context));
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.red[400],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Column(
        children: [
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Gallery",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
              const SizedBox(
                width: 80,
              ),
              InkWell(
                child: const Column(
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.camera);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedImage =
        await imagePicker.pickImage(source: source, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    signUpController.setProfileImagePath(pickedFile!.path);

    Get.back();

    // print(pickedFile);
  }
}

class SignUpController extends GetxController {
  var isProficPicPathSet = false.obs;
  var profilePicPath = "".obs;

  void setProfileImagePath(String path) {
    profilePicPath.value = path;
    isProficPicPathSet.value = true;
  }
}
