import 'package:flutter/material.dart';

class Admin_Profile extends StatelessWidget {
  const Admin_Profile(
      {super.key,
      required this.username,
      required this.email,
      required this.image});
  final String username, email, image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Admin")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.network(
                  "https://dntest123.000webhostapp.com/upload_image/" + image,
                ),
                minRadius: 50,
                maxRadius: 75,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Text("Username"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(12)),
                child: Text("$username",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30)),
              ),
            ],
          ),
          Row(
            children: [
              Text("Email"),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12)),
                child: Text("$email",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30)),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Edit"))
        ],
      ),
    );
  }
}
