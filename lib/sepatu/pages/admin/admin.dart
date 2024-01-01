import 'package:asu/sepatu/pages/admin/admin_profile.dart';
import 'package:asu/sepatu/pages/admin/upload.dart';
import 'package:asu/sepatu/pages/admin/view_image.dart';
import 'package:asu/sepatu/pages/admin/view_user.dart';
import 'package:asu/sepatu/pages/user/login.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage(
      {super.key,
      required this.username,
      required this.email,
      required this.image});
  final String username, email, image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADMIN PAGE"),
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("$username",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              accountEmail: Text("$email"),
              currentAccountPicture: CircleAvatar(
                child: Image.network(
                  "https://dntest123.000webhostapp.com/upload_image/" + image,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Admin_Profile(
                            username: username, email: email, image: image)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Keluar"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(30),
        crossAxisCount: 2,
        children: <Widget>[
          MyMenu(
            title: "Add Product",
            icon: Icons.shopping_cart,
            warna: Colors.red,
            onTapcallback: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UploadPage()));
            },
          ),
          MyMenu(
            title: "User",
            icon: Icons.account_circle_outlined,
            warna: Colors.blue,
            onTapcallback: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => View_User()));
            },
          ),
          MyMenu(
            title: "Admin",
            icon: Icons.admin_panel_settings_outlined,
            warna: Colors.red,
            onTapcallback: () {},
          ),
          MyMenu(
            title: "Product",
            icon: Icons.shopping_cart,
            warna: Colors.red,
            onTapcallback: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => View_Image()));
            },
          ),
          MyMenu(
            title: "Logout",
            icon: Icons.logout,
            warna: Colors.green,
            onTapcallback: () {},
          ),
        ],
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  const MyMenu(
      {Key? key,
      required this.title,
      required this.icon,
      required this.warna,
      required this.onTapcallback})
      : super(key: key);

  final String title;
  final IconData icon;
  final MaterialColor warna;
  final VoidCallback onTapcallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTapcallback,
        splashColor: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 70, color: warna),
            Text(
              title,
              style: const TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
