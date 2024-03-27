// import 'package:StyleHub/Users/Carts/addressModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../../widget/snackbar.dart';
// import '../homeScreens/homeScreen.dart';
// import 'Favorite/Order/orderConfirmMSG.dart';
// class PaymentOptionsScreen extends StatefulWidget {
//   @override
//   _PaymentOptionsScreenState createState() => _PaymentOptionsScreenState();
// }
//
// class _PaymentOptionsScreenState extends State<PaymentOptionsScreen> {
//   bool _isOnlinePaymentSelected = false;
//   List<AddressItem> addressItem = [];
//   AddressItem selectedAddress =
//   AddressItem(Address: '', FullName: '', PhoneNumber: '', id: '');
//   late Razorpay _razorpay;
//   double totalAmount = 0;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     print("Payment Successful: ${response.paymentId}");
//     // Navigate to OrderConfirmationScreen
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => OrderConfirmScreen(),
//       ),
//     );
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackbarMessage(
//         iconData: Icons.error_outline_rounded,
//         title: 'Oops. An Error Occurred',
//         subtitle: 'Please try after some time.',
//         backgroundColor: Theme.of(context).colorScheme.errorContainer,
//         context: context,
//       ),
//     );
//   }
//
//
//   void _openRazorpay() {
//     final options = {
//       'key': 'rzp_test_nLQYAWuOKvzENb',
//       'amount': 1000 , // Example: 10000 for ₹100
//       'name': 'StyleHub',
//       'description': 'Product Purchase',
//       'prefill': {
//         'contact': selectedAddress.PhoneNumber.toString(),
//         'email': FirebaseAuth.instance.currentUser!.email
//             .toString(),
//         'external': {
//           'wallets': ['paytm']
//         }
//       }
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print('Error in opening Razorpay: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Payment Option'),
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
//                       Text('Select Payment Option:'),
//                       ListTile(
//                         title: Text('Cash on Delivery'),
//                         leading: Radio(
//                           value: false,
//                           groupValue: _isOnlinePaymentSelected,
//                           onChanged: (value) {
//                             setState(() {
//                               _isOnlinePaymentSelected = false;
//                             });
//                           },
//                         ),
//                       ),
//                       ListTile(
//                         title: Text('Online Payment'),
//                         leading: Radio(
//                           value: true,
//                           groupValue: _isOnlinePaymentSelected,
//                           onChanged: (value) {
//                             setState(() {
//                               _isOnlinePaymentSelected = true;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (!_isOnlinePaymentSelected) {
//                     // Call moveToOrderCollection function with 'COD' as payment method
//                     moveToOrderCollection('COD');
//                     // Navigate to OrderConfirmationScreen
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => OrderConfirmScreen(),
//                       ),
//                     );
//                   } else {
//                     // If online payment is selected, open Razorpay
//                     _openRazorpay();
//                   }
//                 },
//                 child: Text('Pay'),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// void moveToOrderCollection(String paymentMethod) async {
//   try {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return;
//     }
//
//     CollectionReference cartsCollection = FirebaseFirestore.instance
//         .collection('carts');
//     CollectionReference ordersCollection = FirebaseFirestore.instance
//         .collection('orders');
//     CollectionReference usersCollection = FirebaseFirestore.instance
//         .collection('Users');
//     CollectionReference paymentsCollection = FirebaseFirestore.instance
//         .collection('payments');
//
//     // Get the cart items
//     QuerySnapshot querySnapshot = await cartsCollection.where(
//         'uid', isEqualTo: user.uid).get();
//
//     List<Map<String, dynamic>> orderItems = [];
//     double totalOrderPrice = 0.0;
//
//     // Fetch user details from the Users collection
//     DocumentSnapshot userSnapshot = await usersCollection.doc(user.uid).get();
//     Map<String, dynamic>? userData = userSnapshot.data() as Map<
//         String,
//         dynamic>?;
//
//     // Check if user data exists
//     if (userData == null) {
//       print('User data not found.');
//       return;
//     }
//
//     // Loop through each cart item
//     querySnapshot.docs.forEach((doc) {
//       // Extract necessary information from the cart item
//       double productNewPrice = double.parse(doc['productNewPrice']);
//       int quantity = doc['quantity']; // No need to parse, as it's already an integer
//
//       // Calculate subtotal for each item
//       double subtotal = productNewPrice * quantity;
//
//       // Add subtotal to the total order price
//       totalOrderPrice += subtotal;
//
//       Map<String, dynamic> orderItem = {
//         'productName': doc['productName'],
//         'productNewPrice': productNewPrice,
//         'quantity': quantity,
//         'subtotal': subtotal,
//         // Add any other necessary fields
//       };
//
//       // Add the item to the list of order items
//       orderItems.add(orderItem);
//     });
//
//     // Determine the payment method based on the user selection
//     // String paymentMethod = _isCreditCardSelected
//     //     ? 'Online'
//     //     : 'Cash on Delivery';
//
//
//
//     // Store payment data in the Payments collection
//     await paymentsCollection.doc(user.uid).set({
//       'paymentMethod': paymentMethod,
//       'timestamp': Timestamp.now(),
//       // Add any other necessary fields
//     });
//
//     // Create a new order document in the orders collection
//     DocumentReference newOrderRef = await ordersCollection.add({
//       'uid': user.uid,
//       'items': orderItems,
//       'totalPrice': totalOrderPrice,
//       'timestamp': Timestamp.now(), // Add timestamp for ordering
//       'address': userData['address'],
//       'city': userData['city'],
//       'state': userData['state'],
//       'zipCode': userData['zipCode'],
//       'phone': userData['phone'],
//       'paymentMethod': paymentMethod,
//       'status': 'Pending', // Set the initial status of the order
//       // Add any other necessary fields
//     });
//
//     // Clear the cart after moving the items
//     querySnapshot.docs.forEach((doc) {
//       doc.reference.delete();
//     });
//
//     print('Order placed successfully with ID: ${newOrderRef.id}');
//   } catch (e) {
//     print('Error moving items to order collection: $e');
//   }
//   //
//   // Navigator.pushAndRemoveUntil(
//   //   context,
//   //   MaterialPageRoute(builder: (context) => BottomNavigationHome()),
//   //       (route) => false,
//   // );
// }
//

// import 'package:StyleHub/Users/OrderTracking%20seller/OrderTrackingScreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//
//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }
//
// class _PaymentScreenState extends State<PaymentScreen> {
//   String _paymentMethod = 'Cash on Delivery';
//   double _subtotal = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _calculateSubtotal();
//   }
//
//   void _calculateSubtotal() async {
//     String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
//     QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//         .collection('carts')
//         .where('uid', isEqualTo: currentUserUID)
//         .get();
//
//     double subtotal = 0.0;
//     cartSnapshot.docs.forEach((doc) {
//       double totalprice = double.parse(doc['totalprice']);
//       subtotal += totalprice;
//     });
//
//     setState(() {
//       _subtotal = subtotal;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),
//             Text(
//               'Payment Method',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ListTile(
//               title: Text('Cash on Delivery'),
//               leading: Radio(
//                 value: 'Cash on Delivery',
//                 groupValue: _paymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     _paymentMethod = value.toString();
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: Text('Online Payment'),
//               leading: Radio(
//                 value: 'Online Payment',
//                 groupValue: _paymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     _paymentMethod = value.toString();
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Subtotal: $_subtotal',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             // ElevatedButton(
//             //   onPressed: () async {
//             //     try {
//             //       // Fetch the user's shopping cart items
//             //       String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
//             //       QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//             //           .collection('carts')
//             //           .where('uid', isEqualTo: currentUserUID)
//             //           .get();
//             //
//             //       // Extract product details from the shopping cart
//             //       List<Map<String, dynamic>> products = [];
//             //       cartSnapshot.docs.forEach((doc) {
//             //         Map<String, dynamic> productData = {
//             //           'productName': doc['productName'],
//             //           'productPrice': doc['productPrice'],
//             //           'quantity': doc['quantity'],
//             //           'totalprice': doc['totalprice'],
//             //         };
//             //         products.add(productData);
//             //       });
//             //
//             //       // Add the order to the Orders collection
//             //       await FirebaseFirestore.instance.collection('orders').add({
//             //         'paymentMethod': _paymentMethod,
//             //         'products': products,
//             //         'subtotal': _subtotal,
//             //         'timestamp': Timestamp.now(),
//             //         'uid': currentUserUID,
//             //
//             //       });
//             //
//             //       // Handle success
//             //     } catch (error) {
//             //       // Handle error
//             //       print('Error placing order: $error');
//             //     }
//             //   },
//             //   child: Text('Place Order'),
//             // ),
//
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   // Fetch the user's shopping cart items
//                   String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
//                   QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
//                       .collection('carts')
//                       .where('uid', isEqualTo: currentUserUID)
//                       .get();
//
//                   // Extract product details from the shopping cart
//                   List<Map<String, dynamic>> products = [];
//                   cartSnapshot.docs.forEach((doc) {
//                     Map<String, dynamic> productData = {
//                       'productName': doc['productName'],
//                       'productPrice': doc['productPrice'],
//                       'quantity': doc['quantity'],
//                       'totalprice': doc['totalprice'],
//                     };
//                     products.add(productData);
//                   });
//
//                   // Add the order to the Orders collection
//                   DocumentReference orderRef = await FirebaseFirestore.instance.collection('orders').add({
//                     'paymentMethod': _paymentMethod,
//                     'products': products,
//                     'subtotal': _subtotal,
//                     'timestamp': Timestamp.now(),
//                     'uid': currentUserUID,
//                   });
//
//                   // Remove the items from the cart collection
//                   cartSnapshot.docs.forEach((doc) async {
//                     await doc.reference.delete();
//                   });
//
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => OrderTrackingScreen(orderId: orderRef.id)),
//                   // );
//                   //
//                   // Handle success
//                 } catch (error) {
//                   // Handle error
//                   print('Error placing order: $error');
//                 }
//               },
//               child: Text('Place Order'),
//             ),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:StyleHub/Users/Favorite/Order/orderConfirmMSG.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _paymentMethod = 'Cash on Delivery';
  double _subtotal = 0.0;
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _calculateSubtotal();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _calculateSubtotal() async {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
        .collection('carts')
        .where('uid', isEqualTo: currentUserUID)
        .get();

    double subtotal = 0.0;
    cartSnapshot.docs.forEach((doc) {
      double totalprice = double.parse(doc['totalprice']);
      subtotal += totalprice;
    });

    setState(() {
      _subtotal = subtotal;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    // Navigate to OrderTrackingScreen or any other screen as needed
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Error: ${response.message} - ${response.code}");
  }

  void _openRazorpay() {
    final options = {
      'key': 'rzp_test_nLQYAWuOKvzENb',
      'amount': (_subtotal * 100),
      'name': 'StyleHub',
      'description': 'Product Purchase',
      'prefill': {
        'contact': '9664802800',
        'email': 'CUSTOMER_EMAIL',
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error in opening Razorpay: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Cash on Delivery'),
              leading: Radio(
                value: 'Cash on Delivery',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value.toString();
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Online Payment'),
              leading: Radio(
                value: 'Online Payment',
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value.toString();
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Subtotal: $_subtotal',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                if (_paymentMethod == 'Online Payment') {
                  _openRazorpay();
                } else {
                  // Place order logic for Cash on Delivery
                }

                try {
                  // Fetch the user's shopping cart items
                  String currentUserUID =
                      FirebaseAuth.instance.currentUser!.uid;
                  QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
                      .collection('carts')
                      .where('uid', isEqualTo: currentUserUID)
                      .get();

                  // Extract product details from the shopping cart
                  List<Map<String, dynamic>> products = [];
                  cartSnapshot.docs.forEach((doc) {
                    Map<String, dynamic> productData = {
                      'productName': doc['productName'],
                      'productPrice': doc['productPrice'],
                      'quantity': doc['quantity'],
                      'totalprice': doc['totalprice'],
                    };
                    products.add(productData);
                  });

                  // Add the order to the Orders collection
                  DocumentReference orderRef = await FirebaseFirestore.instance
                      .collection('orders')
                      .add({
                    'paymentMethod': _paymentMethod,
                    'products': products,
                    'subtotal': _subtotal,
                    'status': '',
                    'timestamp': Timestamp.now(),
                    'uid': currentUserUID,
                  });

                  // Remove the items from the cart collection
                  cartSnapshot.docs.forEach((doc) async {
                    await doc.reference.delete();
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrderConfirmScreen()),
                  );

                  // Handle success
                } catch (error) {
                  // Handle error
                  print('Error placing order: $error');
                }
              },style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),),
              child: Text('Place Order',style: TextStyle(color: Colors.white),),
            ),


          ],
        ),
      ),
    );
  }
}










// ElevatedButton(
//   onPressed: () {
//     if (_paymentMethod == 'Online Payment') {
//       _openRazorpay();
//     } else {
//       // Place order logic for Cash on Delivery
//     }
//   },
//   child: Text('Pay'),
// ),
