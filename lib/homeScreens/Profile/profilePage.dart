import 'package:StyleHub/Users/Carts/cartScreen.dart';
import 'package:StyleHub/Users/Favorite/Order/placeOrderScreen.dart';
import 'package:StyleHub/Users/Settings/lightanddarkmode.dart';
import 'package:StyleHub/homeScreens/Profile/userPersonalDetails.dart';
import 'package:StyleHub/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:StyleHub/userLogin.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 20),
            // Image.asset(
            //   img,
            //   height: 100,
            //   width: 100,
            // ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildProfileItem(
              context,
              icon: Icons.person,
              label: "Personal Info",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserProfile()));
              },
            ),
            buildProfileItem(
              context,
              icon: Icons.shopping_cart,
              label: "Cart Details",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddToCartScreen()));
              },
            ),
            buildProfileItem(
              context,
              icon: Icons.receipt,
              label: "Order Details",
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OrderListScreen()));
              },
            ),
            buildProfileItem(
              context,
              icon: Icons.settings,
              label: "Settings",
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) =>  SettingScreen()));
              },
            ),
            buildProfileItem(
              context,
              icon: Icons.logout,
              label: "Logout",
              onPressed: () {
                FirebaseAuth.instance.signOut();
                {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const page(),
                      ),
                      (route) => false);
                }
              },
            ),
            const SizedBox(height: 210),
            const Center(
                child: Text(
              "StyleHub",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            )),
            const Center(
                child: Text(
              "stylehhub@gmail.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey),
            )),
            const Center(
                child: Text(
              "(+91)9664802800",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
