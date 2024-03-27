//
// import 'package:StyleHub/homeScreens/homeScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class BuyScreen extends StatefulWidget {
//   @override
//   _BuyScreenState createState() => _BuyScreenState();
// }
//
// class _BuyScreenState extends State<BuyScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _zipCodeController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//
//   User? _user;
//   bool _isCreditCardSelected = false;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserData();
//     setState(() {
//
//     });
//   }
//
//
//   Future<void> fetchUserData() async {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       setState(() {
//         _user = currentUser;
//       });
//
//       DocumentSnapshot<Map<String, dynamic>> userDoc =
//       await FirebaseFirestore.instance.collection('Users').doc(currentUser.uid).get();
//       Map<String, dynamic>? userData = userDoc.data();
//
//       if (userData != null) {
//         setState(() {
//           _emailController.text = userData['email'];
//           _addressController.text = userData['address'];
//           _cityController.text = userData['city'];
//           _stateController.text = userData['state'];
//           _zipCodeController.text = userData['zipCode'];
//           _phoneController.text = userData['phone'];
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('User Information:'),
//                       TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(labelText: 'Email'),
//                       ),
//                       TextFormField(
//                         controller: _addressController,
//                         decoration: InputDecoration(labelText: 'Address'),
//                       ),
//                       TextFormField(
//                         controller: _cityController,
//                         decoration: InputDecoration(labelText: 'City'),
//                       ),
//                       TextFormField(
//                         controller: _stateController,
//                         decoration: InputDecoration(labelText: 'State'),
//                       ),
//                       TextFormField(
//                         controller: _zipCodeController,
//                         decoration: InputDecoration(labelText: 'Zip Code'),
//                       ),
//                       TextFormField(
//                         controller: _phoneController,
//                         decoration: InputDecoration(labelText: 'Phone'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // FutureBuilder<double>(
//                       //   future: fetchSubtotal(),
//                       //   builder: (context, snapshot) {
//                       //     if (snapshot.connectionState == ConnectionState.waiting) {
//                       //       return CircularProgressIndicator();
//                       //     } else if (snapshot.hasError) {
//                       //       return Text('Error: ${snapshot.error}');
//                       //     } else {
//                       //       return Text('Subtotal: \ ${fetchSubtotal()}',
//                       //           style: TextStyle(fontWeight: FontWeight.bold));
//                       //     }
//                       //   },
//                       // ),
//                       SizedBox(height: 20,),
//                       Text('Select Payment Option:'),
//                       // Text("$_subtotal"),
//                       ListTile(
//                         title: Text('Cash on Delivery'),
//                         leading: Radio(
//                           value: false,
//                           groupValue: _isCreditCardSelected,
//                           onChanged: (value) {
//                             setState(() {
//                               _isCreditCardSelected = value as bool;
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text('Credit Card'),
//                         leading: Radio(
//                           value: true,
//                           groupValue: _isCreditCardSelected,
//                           onChanged: (value) {
//                             setState(() {
//                               _isCreditCardSelected = value as bool;
//                             });
//                           },
//                         ),
//                       ),
//                       if (_isCreditCardSelected)
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 10),
//                             Text('Credit Card Details:'),
//                             TextFormField(
//                               decoration: InputDecoration(labelText: 'Card Number'),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value!.length != 16) {
//                                   return 'Please enter a valid 16-digit card number';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             TextFormField(
//                               decoration: InputDecoration(labelText: 'Expiration Date'),
//                               keyboardType: TextInputType.datetime,
//                               validator: (value) {
//                                 // Implement validation for expiration date if needed
//                                 return null;
//                               },
//                             ),
//                             TextFormField(
//                               decoration: InputDecoration(labelText: 'CVV'),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value!.length != 3) {
//                                   return 'Please enter a valid 3-digit CVV';
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//
//
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   pay();
//                 },
//                 child: Text('Pay'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> pay() async {
//     // Implement logic to handle payment
//     if (_user != null) {
//       try {
//         // Fetch cart document
//         DocumentSnapshot<Map<String, dynamic>> cartSnapshot =
//         await FirebaseFirestore.instance.collection('carts').doc(_user!.uid).get();
//
//         if (cartSnapshot.exists) {
//           double subtotal = 0.0;
//
//           // List to store product details
//           List<Map<String, dynamic>> products = [];
//
//           // Calculate subtotal and store product details
//           (cartSnapshot.data()!['items'] as List<dynamic>).forEach((cartItem) {
//             double price = cartItem['ProductNewPrice'];
//             int quantity = cartItem['quantity'];
//             subtotal += price * quantity;
//
//             // Add product details to the list
//             products.add({
//               'productName': cartItem['productName'],
//               'quantity': quantity,
//               'ProductNewPrice': price,
//             });
//           });
//
//           // Remove data from carts collection
//           await FirebaseFirestore.instance.collection('carts').doc(_user!.uid).delete();
//
//           // Add order to orders collection with product details and subtotal
//           await FirebaseFirestore.instance.collection('orders').add({
//             'uid': _user!.uid,
//             'email': _emailController.text,
//             'address': _addressController.text,
//             'city': _cityController.text,
//             'state': _stateController.text,
//             'zipCode': _zipCodeController.text,
//             'phone': _phoneController.text,
//             'products': products,
//             'subtotal': subtotal,
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//
//           // Add payment details to payments collection
//           await FirebaseFirestore.instance.collection('payments').add({
//             'uid': _user!.uid,
//             'paymentMethod': _isCreditCardSelected ? 'Credit Card' : 'Cash on Delivery',
//             'status': 'Paid',
//             'timestamp': FieldValue.serverTimestamp(),
//           });
//
//           // Navigate to success page or show success message
//           Navigator.pushAndRemoveUntil(context,
//               MaterialPageRoute(builder: (context) => BottomNavigationHome()), (route) => false);
//         } else {
//           // If cart document does not exist, display a message to the user
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Your cart is empty. Add items before making a payment.'),
//             ),
//           );
//
//           // Redirect the user to the shopping page or product catalog
//          // Replace with your shopping page route
//         }
//       } catch (e) {
//         print('Error paying: $e');
//       }
//     }
//   }
//
//
//
// }

import 'package:StyleHub/Users/payment.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _additionalField1Controller = TextEditingController();
  final TextEditingController _additionalField2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // Fetch user data from Firebase Authentication and Firestore
  Future<void> _fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .get();
      Map<String, dynamic>? userData = userDoc.data();

      if (userData != null) {
        setState(() {
          _emailController.text = userData['email'];
          _phoneController.text = userData['phone'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'User Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // Delivery Address Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Delivery Address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    icon: Icon(Icons.location_on),
                    label: Text('Use My Current Location'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _additionalField1Controller,
              decoration: InputDecoration(
                labelText: 'House No. Building Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _additionalField2Controller,
              decoration: InputDecoration(
                labelText: 'Road Name, Area, Colony',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Nearby Famous Shop/Mall/Landmark',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _zipCodeController,
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),


            // Proceed to Payment Button
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentScreen()));
                  },style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,shape: LinearBorder.bottom()),
                  child: Text('Proceed to Payment',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to get current location
  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _additionalField1Controller.text =place.street.toString() ?? '';
        _additionalField2Controller.text =place.name.toString() ?? '';
        _addressController.text = place.locality ?? '';
        _cityController.text = place.locality ?? '';
        _stateController.text = place.administrativeArea ?? '';
        _zipCodeController.text = place.postalCode ?? '';
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
