import 'package:StyleHub/Seller/sellerSplashScreen.dart';
import 'package:StyleHub/Users/userSplashScreen.dart';
import 'package:StyleHub/image.dart';
import 'package:flutter/material.dart';

class page extends StatefulWidget {
  const page({super.key});

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                )),
                const Text(
                  "Welcome to Style Hub of possibilities where we awaits to assist and enhance your user experience.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  logo,
                  width: 450,
                  height: 350,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SellerSplashScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Seller",
                          style: TextStyle(color: Colors.lightBlueAccent),
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UserSplashScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text(
                          "User",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
