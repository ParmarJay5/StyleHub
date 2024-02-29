import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../page.dart';
import 'Products/productScreen.dart';
import 'sellerOrderScreen.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({Key? key}) : super(key: key);

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Check if the seller's details are already stored
  //   _checkSellerDetails();
  // }
  //
  // Future<void> _checkSellerDetails() async {
  //   try {
  //     // Retrieve the current user's document from Firestore
  //     final userDoc = await FirebaseFirestore.instance
  //         .collection('Sellers')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //
  //     // If the document exists and contains necessary details, navigate to profile screen
  //     if (userDoc.exists && userDoc['storeAddress'] != null && userDoc['contactNo'] != null) {
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => SellerProfileScreen()),
  //       );
  //     }
  //   } catch (error) {
  //     print('Error checking seller details: $error');
  //     // Handle error as needed
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SellerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                "Welcome...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                "Your success is our priority.\nLet's thrive together!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 60),
            SellerDetails(),
            SizedBox(height: 70),
            Center(
              child: Text(
                "StyleHub",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                "stylehhub@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                "(+91)9664802800",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SellerDrawer extends StatelessWidget {
  const SellerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
              ],
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SellerProfileScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Products'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SellerOrderScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => page()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SellerDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _fetchSellerData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('Seller document does not exist');
        } else {
          final sellerSnapshot = snapshot.data!;
          return Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seller Details :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Store Name: ${sellerSnapshot['username']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${sellerSnapshot['email']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Store Address: ${sellerSnapshot['storeAddress']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Contact Number: ${sellerSnapshot['contactNo']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<DocumentSnapshot> _fetchSellerData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final sellerSnapshot = await FirebaseFirestore.instance
        .collection('Sellers')
        .doc(user.uid)
        .get();

    if (!sellerSnapshot.exists) {
      throw Exception('Seller document does not exist for user ${user.uid}');
    }

    return sellerSnapshot;
  }
}
