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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const SellerDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Text(
                "Welcome...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            const Center(
              child: Text(
                "Your success is our priority.\nLet's thrive together!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 60),
            SellerDetails(),
            const SizedBox(height: 70),
            const Center(
              child: Text(
                "StyleHub",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const Center(
              child: Text(
                "stylehhub@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
            const Center(
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
          const DrawerHeader(
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
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SellerProfileScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Products'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProductScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => OrderListScreenSeller()),
              );
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const page()),
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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('Seller document does not exist');
        } else {
          final sellerSnapshot = snapshot.data!;
          return Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Seller Details :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Store Name: ${sellerSnapshot['username']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${sellerSnapshot['email']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Store Address: ${sellerSnapshot['storeAddress']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Contact Number: ${sellerSnapshot['contactNo']}',
                    style: const TextStyle(fontSize: 16),
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
