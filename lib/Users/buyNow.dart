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



//
//
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../homeScreens/homeScreen.dart';
// import 'Favorite/Order/orderModel.dart';
// import 'Settings/paymentModel.dart'; // Replace with your actual project path
//
// class BuyScreen extends StatefulWidget {
//   final String? itemWanted;
//   final List<String>? image;
//
//   const BuyScreen({Key? key, this.itemWanted, this.image}) : super(key: key);
//
//   @override
//   State<BuyScreen> createState() => _BuyScreenState();
// }
//
// class _BuyScreenState extends State<BuyScreen> {
//   TextEditingController email = TextEditingController();
//   TextEditingController address = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController zipcode = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController total = TextEditingController();
//   TextEditingController _cardNumberController = TextEditingController();
//   TextEditingController _expDateController = TextEditingController();
//   TextEditingController cvv = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String groupValue = "cash on delivery";
//
//   @override
//   void initState() {
//     super.initState();
//     _formKey = GlobalKey<FormState>(); // Initialize formKey
//     // Initialize email field with current user's email if available
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       email.text = user.email!;
//       fetchUserData();
//     }
//   }
//
//
//
//   void moveToOrderCollection() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//       CollectionReference ordersCollection =
//       FirebaseFirestore.instance.collection('orders');
//
//       // Get the cart items
//       QuerySnapshot querySnapshot = await cartsCollection
//           .where('uid', isEqualTo: user.uid)
//           .get();
//
//       List<Map<String, dynamic>> orderItems = [];
//       double totalOrderPrice = 0.0;
//
//       // Loop through each cart item
//       querySnapshot.docs.forEach((doc) {
//         // Extract necessary information from the cart item
//         double productNewPrice = double.parse(doc['productNewPrice']);
//         int quantity = doc['quantity']; // No need to parse, as it's already an integer
//
// // Calculate subtotal for each item
//         double subtotal = productNewPrice * quantity;
//
//         // Add subtotal to the total order price
//         totalOrderPrice += subtotal;
//
//         Map<String, dynamic> orderItem = {
//           'productName': doc['productName'],
//           'productNewPrice': productNewPrice,
//           'quantity': quantity,
//           'subtotal': subtotal,
//           // Add any other necessary fields
//         };
//
//         // Add the item to the list of order items
//         orderItems.add(orderItem);
//       });
//
//       // Create a new order document in the orders collection
//       DocumentReference newOrderRef = await ordersCollection.add({
//         'userId': user.uid,
//         'items': orderItems,
//         'totalPrice': totalOrderPrice,
//         'timestamp': Timestamp.now(), // Add timestamp for ordering
//         // Add any other necessary fields
//       });
//
//       // Clear the cart after moving the items
//       querySnapshot.docs.forEach((doc) {
//         doc.reference.delete();
//       });
//
//       print('Order placed successfully with ID: ${newOrderRef.id}');
//     } catch (e) {
//       print('Error moving items to order collection: $e');
//     }
//   }
//
//   Future<void> fetchUserData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(user.uid)
//           .get();
//
//       if (userDoc.exists) {
//         setState(() {
//           phone.text = userDoc['phone'] ?? '';
//           address.text = userDoc['address'] ?? '';
//           city.text = userDoc['city'] ?? '';
//           state.text = userDoc['state'] ?? '';
//           zipcode.text = userDoc['zipCode'] ?? '';
//         });
//       }
//     } catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }
//
//   Future<void> fetchtotalData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('carts')
//           .doc(user.uid)
//           .get();
//
//       if (userDoc.exists) {
//         setState(() {
//           total.text = userDoc['totalPrice'] ?? '';
//
//         });
//       }
//     } catch (e) {
//       print('Error fetching total data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Payment"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.emailAddress,
//               style: TextStyle(color: Colors.black),
//               enabled: false,
//               controller: email,
//             ),
//             SizedBox(height: 10,),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "Mobile No.",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.phone,
//               maxLength: 10,
//               validator: (value) {
//                 RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');
//                 if (value!.isEmpty) {
//                   return 'Mobile No. is required';
//                 } else if (value.length < 10 || mobileRegex.hasMatch(value)) {
//                   return 'Enter a valid Mobile No.';
//                 }
//                 return null;
//               },
//               controller: phone,
//             ),
//             SizedBox(height: 10,),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "Address",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.text,
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "Address is required";
//                 }
//                 return null;
//               },
//               controller: address,
//             ),
//             SizedBox(height: 10,),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "City",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.text,
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "City is required";
//                 }
//                 return null;
//               },
//               controller: city,
//             ),
//             SizedBox(height: 10,),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "State",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.text,
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "State is required";
//                 }
//                 return null;
//               },
//               controller: state,
//             ),
//             SizedBox(height: 10,),
//             TextFormField(
//               decoration: const InputDecoration(
//                 labelText: "ZipCode",
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.text,
//               validator: (val) {
//                 if (val!.isEmpty) {
//                   return "ZipCode is required";
//                 }
//                 return null;
//               },
//               controller: zipcode,
//             ),
//
//             // SizedBox(height: 10,),
//             // TextFormField(
//             //   decoration: const InputDecoration(
//             //     labelText: "Total",
//             //     border: OutlineInputBorder(),
//             //   ),
//             //   keyboardType: TextInputType.emailAddress,
//             //   style: TextStyle(color: Colors.black),
//             //   enabled: false,
//             //   controller: total,
//             // ),
//
//
//             const SizedBox(height: 20.0),
//             const Text(
//               "Payment Method",
//               style: TextStyle(
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             RadioListTile(
//               title: const Text("Cash on Delivery"),
//               value: "cash on delivery",
//               groupValue: groupValue,
//               onChanged: (value) {
//                 setState(() {
//                   groupValue = value!;
//                 });
//               },
//             ),
//             RadioListTile(
//               title: const Text("Online"),
//               value: "online",
//               groupValue: groupValue,
//               onChanged: (value) {
//                 setState(() {
//                   groupValue = value!;
//                   _showPaymentDialog();
//                 });
//               },
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 _submitOrder();
//
//               },
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.lightBlue),
//               child: const Text("DONE", style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showPaymentDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return _buildPaymentDialog();
//       },
//     );
//   }
//
//   Widget _buildPaymentDialog() {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.0),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Text(
//               'Enter Payment Details',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18.0,
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             TextFormField(
//               decoration: const InputDecoration(
//                 hintText: 'Card Number',
//               ),
//               keyboardType: TextInputType.number,
//               controller: _cardNumberController,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Card Number is required';
//                 } else if (value.length < 16) {
//                   return 'Enter a valid Card Number';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 10.0),
//             GestureDetector(
//               onTap: () {
//                 _showExpiryDatePicker();
//               },
//               child: AbsorbPointer(
//                 child: TextFormField(
//                   controller: _expDateController,
//                   keyboardType: TextInputType.datetime,
//                   decoration: const InputDecoration(
//                     hintText: 'Expiry Date (MM/YYYY)',
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Expiry Date is required';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             TextFormField(
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 hintText: 'CVV',
//               ),
//               controller: cvv,
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'CVV is required';
//                 } else if (value.length < 3) {
//                   return 'CVV can not be less than 3 digits';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 _submitOrder();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Pay Now'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showExpiryDatePicker() {
//     showMonthPicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
//     ).then((selectedDate) {
//       if (selectedDate != null) {
//         setState(() {
//           _expDateController.text = DateFormat('MM/yyyy').format(selectedDate);
//         });
//       }
//     });
//   }
//
//   void _submitOrder() {
//     if (_formKey.currentState!.validate()) {
//       if (groupValue == "online") {
//         // Perform online payment and move to orders
//         _makeOnlinePayment();
//       } else {
//         // For cash on delivery, simply move to orders
//         moveToOrderCollection();
//       }
//     }
//   }
//
//   void _makeOnlinePayment() {
//     // Perform online payment logic here
//     // For demonstration purposes, let's assume payment is successful
//     // You can integrate payment gateways or APIs for actual payment processing
//
//     // After successful payment, move to orders
//     moveToOrderCollection();
//
//     // Store payment details
//     storePaymentDetails();
//   }
//
//   void storePaymentDetails() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference paymentsCollection =
//       FirebaseFirestore.instance.collection('payments');
//
//       // Create a new payment document
//       await paymentsCollection.add({
//         'userId': user.uid,
//         'cardNumber': _cardNumberController.text,
//         'expiryDate': _expDateController.text,
//         'cvv': cvv.text,
//         'timestamp': Timestamp.now(), // Add timestamp for ordering
//         // Add any other necessary fields
//       });
//
//       print('Payment details stored successfully');
//     } catch (e) {
//       print('Error storing payment details: $e');
//     }
//   }



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
//       setState(() {
//
//       });
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
//       // Fetch cart items
//       QuerySnapshot cartSnapshot = (await FirebaseFirestore.instance.collection(
//           'carts').doc(_user!.uid).get()) as QuerySnapshot<Object?>;
//
//       double subtotal = 0.0;
//
//       // List to store product details
//       List<Map<String, dynamic>> products = [];
//
//       // Calculate subtotal and store product details
//       cartSnapshot.docs.forEach((cartItem) {
//         double price = cartItem['ProductNewPrice']; // Assuming 'price' is the field representing the item's price
//         int quantity = cartItem['quantity']; // Assuming 'quantity' is the field representing the item's quantity
//         subtotal += price * quantity;
//
//         // Add product details to the list
//         products.add({
//           'productName': cartItem['productName'],
//           'quantity': quantity,
//           'ProductNewPrice': price,
//         });
//       });
//
//       // Remove data from carts collection
//       await FirebaseFirestore.instance.collection('carts')
//           .doc(_user!.uid)
//           .delete();
//
//       // Add order to orders collection with product details and subtotal
//       await FirebaseFirestore.instance.collection('orders').add({
//         'uid': _user!.uid,
//         'email': _emailController.text,  // Fixed here
//         'address': _addressController.text,  // Fixed here
//         'city': _cityController.text,  // Fixed here
//         'state': _stateController.text,  // Fixed here
//         'zipCode': _zipCodeController.text,  // Fixed here
//         'phone': _phoneController.text,  // Fixed here
//         'products': products,
//         'subtotal': subtotal,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Add payment details to payments collection
//       await FirebaseFirestore.instance.collection('payments').add({
//         'uid': _user!.uid,
//         'paymentMethod': _isCreditCardSelected
//             ? 'Credit Card'
//             : 'Cash on Delivery',
//         'status': 'Paid',
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Navigate to success page or show success message
//       Navigator.pushAndRemoveUntil(context,
//           MaterialPageRoute(builder: (context) => BottomNavigationHome()), (
//               route) => false);
//     }
//   }
//
// }

//main code, sir

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import other necessary files or packages

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

  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String groupValue = "cash on delivery";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>(); // Initialize formKey
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.text = user.email!;
      fetchUserData();
    }
  }

  // void initState() {
  //   super.initState();
  //   _formKey = GlobalKey<FormState>(); // Initialize formKey
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     email.text = user.email!;
  //     fetchUserData();
  //   } else {
  //     // Handle the case where currentUser is null
  //   }
  // }

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

  void moveToOrderCollection() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('carts');
      CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

      QuerySnapshot querySnapshot = await cartsCollection
          .where('uid', isEqualTo: user.uid)
          .get();

      List<Map<String, dynamic>> orderItems = [];
      double totalOrderPrice = 0.0;

      querySnapshot.docs.forEach((doc) {
        double productNewPrice = double.parse(doc['productNewPrice']);
        int quantity = doc['quantity'];

        double subtotal = productNewPrice * quantity;

        totalOrderPrice += subtotal;

        Map<String, dynamic> orderItem = {
          'productName': doc['productName'],
          'productNewPrice': productNewPrice,
          'quantity': quantity,
          'subtotal': subtotal,
        };

        orderItems.add(orderItem);
      });

      DocumentReference newOrderRef = await ordersCollection.add({
        'uid': user.uid,
        'items': orderItems,
        'totalPrice': totalOrderPrice,
        'timestamp': Timestamp.now(),
      });

      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });

      print('Order placed successfully with ID: ${newOrderRef.id}');
    } catch (e) {
      print('Error moving items to order collection: $e');
    }
  }

  void _submitOrder() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (groupValue == "online") {
        _showPaymentDialog(); // Show payment dialog for online payment
      } else {
        moveToOrderCollection(); // Move to order collection for cash on delivery
      }
    }
  }



  void _makeOnlinePayment() {
    moveToOrderCollection();
    storePaymentDetails();
  }

  void storePaymentDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference paymentsCollection =
      FirebaseFirestore.instance.collection('payments');

      await paymentsCollection.add({
        'uid': user.uid,
        'cardNumber': _cardNumberController.text,
        'expiryDate': _expDateController.text,
        'cvv': cvv.text,
        'timestamp': Timestamp.now(),
      });

      print('Payment details stored successfully');
    } catch (e) {
      print('Error storing payment details: $e');
    }
  }


  void fetchUserData() async {
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              enabled: false,
              controller: email,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Mobile No.",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: (value) {
                RegExp mobileRegex = RegExp(r'^[6-9]\d{9}$');
                if (value!.isEmpty) {
                  return 'Mobile No. is required';
                } else if (value.length < 10 || mobileRegex.hasMatch(value)) {
                  return 'Enter a valid Mobile No.';
                }
                return null;
              },
              controller: phone,
            ),
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

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildPaymentDialog();
      },
    );
  }

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
                _showPaymentDialog();
                // _submitOrder();
                Navigator.of(context).pop();
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }


}
//
//
//
//   void _submitOrder() async {
//     if (FirebaseAuth.instance.currentUser != null && _formKey.currentState != null && _formKey.currentState!.validate()) {
//       int random = Random().nextInt(1000);
//       int timeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
//       String orderId = "$random$timeInMilliseconds";
//
//       orderModel order = orderModel(
//         orderId: orderId,
//         uid: FirebaseAuth.instance.currentUser!.uid,
//         productName: widget.itemWanted ?? "productName",
//         image: widget.image?.isNotEmpty == true ? widget.image![0] : '',
//         paymentMethod: groupValue,
//         status: "Order Confirm",
//         totalPrice: 0,
//       );
//
//       PaymentModel payment = PaymentModel(
//         orderId: orderId,
//         email: email.text,
//         phone: phone.text,
//         address: address.text,
//         city: city.text,
//         state: state.text,
//         zipcode: zipcode.text,
//         paymentMethod: groupValue,
//         cardNumber: _cardNumberController.text,
//         expiryDate: _expDateController.text,
//         cvv: cvv.text,
//       );
//
//       // await FirebaseFirestore.instance.collection('orders').doc(orderId).set(
//       //   order.toMap(),
//       // );
//
//       await FirebaseFirestore.instance.collection('payments').doc(orderId).set(
//         payment.toMap(),
//       );
//
//       // You may uncomment this part if you want to navigate to the home screen
//       // Navigator.pushAndRemoveUntil(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => BottomNavigationHome()),
//       //       (route) => false,
//       // );
//     }
//   }
//
