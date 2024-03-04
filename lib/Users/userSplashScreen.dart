import 'dart:async';
import 'package:StyleHub/homeScreens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../userLogin.dart';

User? user = FirebaseAuth.instance.currentUser;

class UserSplashScreen extends StatefulWidget {
  const UserSplashScreen({Key? key}) : super(key: key);

  @override
  _UserSplashScreenState createState() => _UserSplashScreenState();
}

class _UserSplashScreenState extends State<UserSplashScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _checkLoggedInUser);
    // Check if a user is already logged in
  }

  Future<void> _checkLoggedInUser() async {
    // Get the current user
    // User? user = _auth.currentUser;

    if (user != null) {
      // If a user is already logged in, navigate to user home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavigationHome()),
      );
    } else {
      // If no user is logged in, navigate to user login or signup screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // You can customize this widget as per your UI design
      ),
    );
  }
}
