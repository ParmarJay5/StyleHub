// import 'package:StyleHub/Seller/sellerLogin.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PendingScreen extends StatefulWidget {
//   const PendingScreen({Key? key}) : super(key: key);
//
//   @override
//   _PendingScreenState createState() => _PendingScreenState();
// }
//
// class _PendingScreenState extends State<PendingScreen> {
//   bool _approvalReceived = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Check for approval status when the screen is initialized
//     _checkApprovalStatus();
//   }
//
//   Future<void> _checkApprovalStatus() async {
//     // Retrieve the current user's document from Firestore
//     final userDoc = await FirebaseFirestore.instance
//         .collection('Sellers')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .get();
//
//     // Check if the status is 'approved'
//     if (userDoc.exists) {
//       final status = userDoc['status'];
//       if (status == 'approved') {
//         // If approved, set the approvalReceived to true
//         setState(() {
//           _approvalReceived = true;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_approvalReceived) {
//       // If approval is received, navigate to the login screen
//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => SellerLogin()),
//         );
//       });
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pending Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Waiting for approval...',
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(height: 20),
//             CircularProgressIndicator(), // Show a loading indicator
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:StyleHub/Seller/sellerLogin.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  void initState() {
    super.initState();
    _startListeningToStatusChanges();
  }

  void _startListeningToStatusChanges() async {
    FirebaseFirestore.instance
        .collection('Sellers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((snapshot) {
      final status = snapshot.data()?['status'];

      if (status == 'approved') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SellerLogin()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Waiting for approval...',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Show a loading indicator
          ],
        ),
      ),
    );
  }
}
