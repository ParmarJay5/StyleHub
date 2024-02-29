import 'package:StyleHub/Users/Carts/cartScreen.dart';
import 'package:StyleHub/Users/Favorite/Order/placeOrderScreen.dart';
import 'package:StyleHub/Users/Settings/lightanddarkmode.dart';
import 'package:StyleHub/homeScreens/Profile/userPersonalDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:StyleHub/image.dart';
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildProfileItem(
              context,
              icon: Icons.person,
              label: "Personal Info",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserProfile()));

              },
            ),
            buildProfileItem(
              context,
              icon: Icons.shopping_cart,
              label: "Cart Details",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage()));

              },
            ),
            buildProfileItem(
              context,
              icon: Icons.receipt,
              label: "Order Details",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderListScreen()));
              },
            ),
            buildProfileItem(
              context,
              icon: Icons.settings,
              label: "Settings",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LDScreen()));

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
                        builder: (context) => const UserLogin(),
                      ),
                          (route) => false);
                }
              },
            ),
            SizedBox(height: 210),
            Center(child: Text("StyleHub",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)),
            Center(child: Text("stylehhub@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.grey),)),
            Center(child: Text("(+91)9664802800",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.grey),)),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileItem(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon),
      title: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
