import 'dart:async';

import 'package:StyleHub/Seller/sellerProfileScreen.dart';
import 'package:StyleHub/Seller/sellerSignup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

class SellerSplashScreen extends StatefulWidget {
  const SellerSplashScreen({Key? key}) : super(key: key);

  @override
  _SellerSplashScreenState createState() => _SellerSplashScreenState();
}

class _SellerSplashScreenState extends State<SellerSplashScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),_checkLoggedInSeller);
    // Check if a seller is already logged in
  }

  Future<void> _checkLoggedInSeller() async {
    // Get the current user
    // User? user = _auth.currentUser;

    if (user != null) {
      // If a seller is already logged in, navigate to seller home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SellerProfileScreen()),
      );
    } else {
      // If no seller is logged in, navigate to seller signup screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SellerSignup()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // You can customize this widget as per your UI design
      ),
    );
  }
}
