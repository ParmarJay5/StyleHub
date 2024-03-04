import 'package:StyleHub/Seller/Products/addProductScreen.dart';
import 'package:StyleHub/Seller/Products/productScreen.dart';
import 'package:StyleHub/Seller/sellerProfileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerDetailScreen extends StatefulWidget {
  const SellerDetailScreen({Key? key}) : super(key: key);

  @override
  _SellerDetailScreenState createState() => _SellerDetailScreenState();
}

class _SellerDetailScreenState extends State<SellerDetailScreen> {
  final TextEditingController _storeAddressController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();

  String _storeName = '';

  @override
  void initState() {
    super.initState();
    // Fetch the store name from Firestore when the screen initializes
    _fetchStoreName();
  }

  Future<void> _fetchStoreName() async {
    // Retrieve the current user's document from Firestore
    final userDoc = await FirebaseFirestore.instance
        .collection('Sellers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Get the store name from the document
    if (userDoc.exists) {
      setState(() {
        _storeName = userDoc['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Store Name: $_storeName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _storeAddressController,
              decoration: const InputDecoration(
                labelText: 'Store Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _contactNoController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save/store the seller's details to Firestore
                  _saveSellerDetails();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                child: const Text('Save',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSellerDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection('Sellers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'storeAddress': _storeAddressController.text,
        'contactNo': _contactNoController.text,
      });

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SellerProfileScreen()));

    } catch (error) {
      print('Error saving seller details: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save seller details. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
