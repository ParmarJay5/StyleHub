//
//
//
//
// import 'package:StyleHub/Seller/Products/productModel.dart';
// import 'package:StyleHub/homeScreens/homeScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class BuyScreen extends StatefulWidget {
//   @override
//   _BuyScreenState createState() => _BuyScreenState();
// }
//
// class _BuyScreenState extends State<BuyScreen> {
//   String? _paymentMethod;
//   String? _selectedUPI;
//   // final _formKey = GlobalKey<FormState>();
//   String? _cardNumber;
//   String? _expiryDate;
//   String? _cvv;
//
//   late Future<Map<String, dynamic>> _userDataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _userDataFuture = _fetchUserData();
//   }
//
//   Future<Map<String, dynamic>> _fetchUserData() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User not logged in');
//     }
//     final snapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
//     if (!snapshot.exists) {
//       throw Exception('User data not found');
//     }
//     return snapshot.data() as Map<String, dynamic>;
//   }
//   // Launches the respective UPI app
//   Future<void> _launchUPIApp(String app) async {
//     String url = 'upi://pay?pa=$app@ybl&pn=ReceiverName&mc=1234&tid=XYZ&tn=Description&am=100&cu=INR';
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   // Form key for form validation
//   final _formKey = GlobalKey<FormState>();
//
// // This is a placeholder method, replace it with your actual implementation
//   Future<productModel> getProductDetails(String productId) async {
//     try {
//       // Perform a database or network query to fetch product details based on productId
//       // For demonstration purposes, let's assume you're fetching data from Firestore
//
//       // Reference to the Firestore collection containing product details
//       var productRef = FirebaseFirestore.instance.collection('products');
//
//       // Fetch the product document from Firestore
//       var snapshot = await productRef.doc(productId).get();
//
//       // Check if the document exists
//       if (snapshot.exists) {
//         // Map the document data to a ProductModel object
//         return productModel(
//           id: snapshot.id,
//           productName: snapshot['productName'],
//           productNewPrice: snapshot['productNewPrice'],
//           image: snapshot['image'],
//           productPrice: snapshot['productPrice'],
//           productColor: snapshot['productColor'],
//           productDescription: snapshot['productDescription'],
//
//           // Add more properties as needed
//         );
//       } else {
//         // Handle case where the product with the given ID does not exist
//         throw Exception('Product not found');
//       }
//     } catch (e) {
//       // Handle errors such as database errors or network errors
//       print('Error fetching product details: $e');
//       rethrow; // Rethrow the error to handle it elsewhere if needed
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile & Payment'),
//       ),
//       body: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     RadioListTile<String>(
//                       title: Text('UPI'),
//                       value: 'UPI',
//                       groupValue: _paymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           _paymentMethod = value;
//                         });
//                       },
//                     ),
//                     if (_paymentMethod == 'UPI') ...[
//                       ListTile(
//                         title: Text('GPay'),
//                         leading: Radio(
//                           value: 'GPay',
//                           groupValue: _selectedUPI,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedUPI = value;
//                             });
//                           },
//                         ),
//                         onTap: () {
//                           _launchUPIApp('example@upi'); // Replace 'example@upi' with your UPI ID
//                         },
//                       ),
//                       ListTile(
//                         title: Text('PhonePe'),
//                         leading: Radio(
//                           value: 'PhonePe',
//                           groupValue: _selectedUPI,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedUPI = value;
//                             });
//                           },
//                         ),
//                         onTap: () {
//                           _launchUPIApp('phonepe'); // Replace 'phonepe' with your PhonePe UPI ID
//                         },
//                       ),
//                       ListTile(
//                         title: Text('Paytm'),
//                         leading: Radio(
//                           value: 'Paytm',
//                           groupValue: _selectedUPI,
//                           onChanged: (value) {
//                             setState(() {
//                               _selectedUPI = value;
//                             });
//                           },
//                         ),
//                         onTap: () {
//                           _launchUPIApp('paytm'); // Replace 'paytm' with your Paytm UPI ID
//                         },
//                       ),
//                     ],
//                     RadioListTile<String>(
//                       title: Text('Credit Card'),
//                       value: 'Credit Card',
//                       groupValue: _paymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           _paymentMethod = value;
//                         });
//                       },
//                     ),
//                     if (_paymentMethod == 'Credit Card') ...[
//                       TextFormField(
//                         decoration: InputDecoration(labelText: 'Card Number'),
//                         keyboardType: TextInputType.number,
//                         maxLength: 16,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter card number';
//                           }
//                           if (value.length != 16) {
//                             return 'Card number must be 16 digits';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _cardNumber = value;
//                         },
//                       ),
//                       TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Expiry Date',
//                           suffixIcon: IconButton(
//                             icon: Icon(Icons.calendar_today),
//                             onPressed: () async {
//                               final selectedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(DateTime.now().year + 10), // Limit to 10 years from now
//                                 builder: (BuildContext context, Widget? child) {
//                                   return Theme(
//                                     data: ThemeData.light().copyWith(
//                                       colorScheme: ColorScheme.light().copyWith(
//                                         primary: Colors.blue, // Change the calendar header color
//                                       ),
//                                     ),
//                                     child: child!,
//                                   );
//                                 },
//                               );
//                               if (selectedDate != null) {
//                                 setState(() {
//                                   // Format the selected date as needed
//                                   _expiryDate = selectedDate.toString();
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         keyboardType: TextInputType.datetime,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter expiry date';
//                           }
//                           // Add validation for expiry date format if needed
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _expiryDate = value;
//                         },
//                       ),
//
//                       TextFormField(
//                         decoration: InputDecoration(labelText: 'CVV'),
//                         keyboardType: TextInputType.number,
//                         maxLength: 3,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Please enter CVV';
//                           }
//                           if (value.length != 3) {
//                             return 'CVV must be 3 digits';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _cvv = value;
//                         },
//                       ),
//                     ],
//                     RadioListTile<String>(
//                       title: Text('Cash on Delivery (COD)'),
//                       value: 'COD',
//                       groupValue: _paymentMethod,
//                       onChanged: (value) {
//                         setState(() {
//                           _paymentMethod = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () async {
//                         // Perform form validation
//                         if (_formKey.currentState!.validate()) {
//                                 productModel product = getProductDetails('productId') as productModel; // Replace getProductDetails() with your method to fetch product details
//
//
//     // Form is valid, proceed with payment
//                           if (_paymentMethod != null) {
//                             if (_paymentMethod == 'UPI' && _selectedUPI == null) {
//                               print('Please select a UPI option');
//                             } else if (_paymentMethod == 'COD') {
//                               // Place order with cash on delivery
//                               print('Order placed with cash on delivery');
//                               // Store order data in Firebase
//                               await FirebaseFirestore.instance.collection('orders').add({
//                                 'paymentMethod': _paymentMethod,
//                                 'status': 'Pending',
//                                 'productName': product.productName,
//                                 'image': product.image,
//                                 'productPrice': product.productPrice,
//                                 // 'quantity': product.,
//                                 'total': product.total,
//                                 // Assuming initial status is pending
//                               });
//                             } else {
//                               print('Selected payment method: $_paymentMethod');
//                               if (_paymentMethod == 'UPI') {
//                                 print('Selected UPI option: $_selectedUPI');
//                               }
//                               // Store order data in Firebase
//                               await FirebaseFirestore.instance.collection('orders').add({
//                                 'paymentMethod': _paymentMethod,
//                                 'status': 'Pending', // Assuming initial status is pending
//                               });
//                               // Store payment data in Firebase
//                               await FirebaseFirestore.instance.collection('payments').add({
//                                 'paymentMethod': _paymentMethod,
//                                 'amount': 100, // Replace with actual payment amount
//                                 // Add more payment details as needed
//                               });
//                             }
//                           } else {
//                             print('Please select a payment method');
//                           }
//
//                           // Navigate to home screen
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => BottomNavigationHome()),
//                           );
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                       child: Text('Proceed to Pay',style: TextStyle(color: Colors.lightBlue),),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       );
//   }
// }
//
// //
// //
// //
// //
// //
// // //
// // // ElevatedButton(
// // // onPressed: () async {
// // // // Perform form validation
// // // if (_formKey.currentState!.validate()) {
// // // productModel product = getProductDetails(); // Replace getProductDetails() with your method to fetch product details
// // //
// // //
// // // // Form is valid, proceed with payment
// // // if (_paymentMethod != null) {
// // // if (_paymentMethod == 'UPI' && _selectedUPI == null) {
// // // print('Please select a UPI option');
// // // } else if (_paymentMethod == 'COD') {
// // // // Place order with cash on delivery
// // // print('Order placed with cash on delivery');
// // // // Store order data in Firebase
// // // await FirebaseFirestore.instance.collection('orders').add({
// // // 'paymentMethod': _paymentMethod,
// // // 'status': 'Pending',
// // // 'productName': product.productName,
// // // 'image': product.image,
// // // 'productPrice': product.productPrice,
// // // // 'quantity': product.quantity,
// // // 'total': product.total,
// // // // Assuming initial status is pending
// // // });
// // // } else {
// // // print('Selected payment method: $_paymentMethod');
// // // if (_paymentMethod == 'UPI') {
// // // print('Selected UPI option: $_selectedUPI');
// // // }
// // // // Store order data in Firebase
// // // await FirebaseFirestore.instance.collection('orders').add({
// // // 'paymentMethod': _paymentMethod,
// // // 'status': 'Pending', // Assuming initial status is pending
// // // });
// // // // Store payment data in Firebase
// // // await FirebaseFirestore.instance.collection('payments').add({
// // // 'paymentMethod': _paymentMethod,
// // // 'amount': 100, // Replace with actual payment amount
// // // // Add more payment details as needed
// // // });
// // // }
// // // } else {
// // // print('Please select a payment method');
// // // }
// // //
// // // // Navigate to home screen
// // // Navigator.pushReplacement(
// // // context,
// // // MaterialPageRoute(builder: (context) => BottomNavigationHome()),
// // // );
// // // }
// // // },
// // // style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
// // // child: Text('Proceed to Pay',style: TextStyle(color: Colors.lightBlue),),
// // // ),




import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../homeScreens/homeScreen.dart';
import 'Favorite/Order/orderModel.dart';
import 'Settings/paymentModel.dart'; // Replace with your actual project path

class BuyScreen extends StatefulWidget {
  final String? itemWanted;
  final List<String>? image;

  const BuyScreen({Key? key, this.itemWanted, this.image}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expDateController = TextEditingController();
  TextEditingController cvv = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String groupValue = "cash on delivery";

  @override
  void initState() {
    super.initState();
    // Initialize email field with current user's email if available
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.text = user.email!;
      fetchUserData();
    }
  }


  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          phone.text = userDoc['phone'] ?? '';
          address.text = userDoc['address'] ?? '';
          city.text = userDoc['city'] ?? '';
          state.text = userDoc['state'] ?? '';
          zipcode.text = userDoc['zipCode'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field (Non-editable)
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              enabled: false,
              // Set enabled to false to make it non-editable
              controller: email,
            ),
            // Phone Field
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Mobile No.",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              // enabled: false,
              maxLength: 10,
              validator: (value) {
                RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');
                if (value!.isEmpty) {
                  return 'Mobile No. is required';
                } else if (value.length < 10 || !mobileRegex.hasMatch(value)) {
                  return 'Enter a valid Mobile No.';
                }
                return null;
              },
              controller: phone,
            ),
            // Address Field
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Address is required";
                }
                return null;
              },
              controller: address,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "City is required";
                }
                return null;
              },
              controller: city,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "State is required";
                }
                return null;
              },
              controller: state,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "ZipCode",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              validator: (val) {
                if (val!.isEmpty) {
                  return "ZipCode is required";
                }
                return null;
              },
              controller: zipcode,
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Payment Method",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Cash on Delivery Radio
            RadioListTile(
              title: const Text("Cash on Delivery"),
              value: "cash on delivery",
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value!;
                });
              },
            ),
            // Online Payment Radio
            RadioListTile(
              title: const Text("Online"),
              value: "online",
              groupValue: groupValue,
              onChanged: (value) {
                setState(() {
                  groupValue = value!;
                  _showPaymentDialog();
                });
              },
            ),
            const SizedBox(height: 16.0),
            // Submit Button
            ElevatedButton(
              onPressed: () {
                _submitOrder();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue),
              child: const Text("DONE", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show payment dialog
  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildPaymentDialog();
      },
    );
  }

  // Method to build payment dialog
  Widget _buildPaymentDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enter Payment Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Card Number',
              ),
              keyboardType: TextInputType.number,
              controller: _cardNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Card Number is required';
                } else if (value.length < 16) {
                  return 'Enter a valid Card Number';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                _showExpiryDatePicker();
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _expDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    hintText: 'Expiry Date (MM/YYYY)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Expiry Date is required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'CVV',
              ),
              controller: cvv,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'CVV is required';
                } else if (value.length < 3) {
                  return 'CVV can not be less than 3 digits';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _submitOrder();
                Navigator.of(context).pop();
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show expiry date picker
  void _showExpiryDatePicker() {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _expDateController.text = DateFormat('MM/yyyy').format(selectedDate);
        });
      }
    });
  }

  // Method to submit order
  void _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with order submission

      // Generate a random order ID
      int random = Random().nextInt(1000);
      int timeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
      String orderId = "$random$timeInMilliseconds";

      // Create an order model
      orderModel order = orderModel(
        orderId: orderId,
        uid: FirebaseAuth.instance.currentUser!.uid,
        productName: widget.itemWanted ?? "productName",
        image: widget.image?.isNotEmpty == true ? widget.image![0] : '',
        paymentMethod: groupValue,
        status: "Order Confirm",
        totalPrice: 0,
      );

      // Create a payment model
      PaymentModel payment = PaymentModel(
        orderId: orderId,
        email: email.text,
        phone: phone.text,
        address: address.text,
        city: city.text,
        state: state.text,
        zipcode: zipcode.text,
        paymentMethod: groupValue,
        cardNumber: _cardNumberController.text,
        expiryDate: _expDateController.text,
        cvv: cvv.text,
      );

      // Save order to Firestore
      await FirebaseFirestore.instance.collection('orders').doc(orderId).set(
        order.toMap(),
      );

      // Save payment details to Firestore
      await FirebaseFirestore.instance.collection('payments').doc(orderId).set(
        payment.toMap(),
      );

      // Navigate to home screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationHome()),
            (route) => false,
      );
    }
  }

}

//
//   // Method to remove item from cart
//   Future<void> _removeItemFromCart() async {
//     // Implement logic to remove item from cart collection
//     // For example:
//     // await FirebaseFirestore.instance.collection('carts').doc(itemId).delete();
//   }
// }
