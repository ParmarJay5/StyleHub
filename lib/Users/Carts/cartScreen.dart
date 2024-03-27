// // import 'package:StyleHub/Users/buyNow.dart';
// // import 'package:flutter/material.dart';
// //
// // class CartPage extends StatefulWidget {
// //   final List<Map<String, dynamic>> cartItems;
// //
// //   const CartPage({Key? key, required this.cartItems}) : super(key: key);
// //
// //   @override
// //   _CartPageState createState() => _CartPageState();
// // }
// //
// // class _CartPageState extends State<CartPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     double total = 0.0;
// //
// //     // Calculate total price of all items in the cart
// //     for (var item in widget.cartItems) {
// //       // Ensure that 'productNewPrice' is parsed to a double
// //       total +=
// //           double.parse(item['productNewPrice'].toString()) * item['quantity'];
// //     }
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Cart'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: widget.cartItems.length,
// //         itemBuilder: (context, index) {
// //           var item = widget.cartItems[index];
// //           return Card(
// //             child: ListTile(
// //               title: Text(item['productName']),
// //               subtitle: Text('Price: \$${item['productNewPrice']}'),
// //               trailing: Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   IconButton(
// //                     onPressed: () {
// //                       setState(() {
// //                         if (item['quantity'] > 1) {
// //                           item['quantity']--;
// //                         }
// //                       });
// //                     },
// //                     icon: Icon(Icons.remove),
// //                   ),
// //                   Text(item['quantity'].toString()),
// //                   IconButton(
// //                     onPressed: () {
// //                       setState(() {
// //                         item['quantity']++;
// //                       });
// //                     },
// //                     icon: Icon(Icons.add),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //       bottomNavigationBar: BottomAppBar(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 'Total: \$${total.toStringAsFixed(2)}',
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(width: 80,
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyScreen()));
// //                     // Implement buy action
// //                   },
// //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
// //                   child: Text('Buy',style: TextStyle(color: Colors.white),),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// //
//
// //main
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
// import 'package:StyleHub/Seller/Products/productModel.dart';
// import 'package:StyleHub/Users/buyNow.dart';
// import '../../homeScreens/homeScreen.dart';
// import '../buy now.dart'; // Import the BottomNavigationHome screen
//
// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   late List<Map<String, dynamic>> cartItems = [];
//   double totalPrice = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCartData();
//   }
//
//   // Future<void> fetchCartData() async {
//   //   try {
//   //     User? user = FirebaseAuth.instance.currentUser;
//   //     if (user == null) {
//   //       return;
//   //     }
//   //
//   //     CollectionReference cartsCollection =
//   //     FirebaseFirestore.instance.collection('carts');
//   //
//   //     QuerySnapshot querySnapshot = await cartsCollection
//   //         .where('uid', isEqualTo: user.uid)
//   //         .get();
//   //
//   //     List<Map<String, dynamic>> fetchedCartItems = [];
//   //
//   //     querySnapshot.docs.forEach((doc) {
//   //       List<String> images =
//   //       List<String>.from(doc['image'] ?? []);
//   //
//   //       fetchedCartItems.add({
//   //         'docId': doc.id, // Store the document ID
//   //         'productName': doc['productName'] ?? '',
//   //         'productNewPrice': doc['productNewPrice'] ?? '',
//   //         'quantity': doc['quantity'] ?? '',
//   //         'image': images,
//   //         // 'productPrice' : doc['productPrice'] ?? '',
//   //         // 'allDetails' : doc['allDetails']?? '',
//   //         // 'ProductDiscount' : doc['ProductDiscount'] ?? '',
//   //         // 'productColor' : doc['productColor'] ?? '',
//   //         // 'productDescription' : doc['productDescription'] ?? '',
//   //         // 'productDetail1' : doc['productDetail1'] ?? '',
//   //         // 'productDetail2' : doc['productDetail2'] ?? '',
//   //         // 'productDetail3' : doc['productDetail3'] ?? '',
//   //         // 'productDetail4' : doc['productDetail4'] ?? '',
//   //         // 'productTitle1' : doc['productTitle1'] ?? '',
//   //         // 'productTitle2' : doc['productTitle2'] ?? '',
//   //         // 'productTitle3' : doc['productTitle3'] ?? '',
//   //         // 'productTitle4' : doc['productTitle4'] ?? '',
//   //       });
//   //     });
//   //
//   //     setState(() {
//   //       cartItems = fetchedCartItems;
//   //       totalPrice = calculateTotalPrice(cartItems);
//   //     });
//   //   } catch (e) {
//   //     print('Error fetching cart data: $e');
//   //   }
//   // }
//
//
//
//   Future<void> fetchCartData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       QuerySnapshot querySnapshot = await cartsCollection
//           .where('uid', isEqualTo: user.uid)
//           .get();
//
//       List<Map<String, dynamic>> fetchedCartItems = [];
//
//       querySnapshot.docs.forEach((doc) {
//         List<String> images = List<String>.from(doc['image'] ?? []);
//
//         fetchedCartItems.add({
//           'docId': doc.id, // Store the document ID
//           'productName': doc['productName'] ?? '',
//           'productNewPrice': doc['productNewPrice'] ?? '',
//           'quantity': doc['quantity'] ?? '',
//           'image': images,
//           // 'productPrice' : doc['productPrice'],
//           // 'allDetails' : doc['allDetails'],
//           // 'ProductDiscount' : doc['ProductDiscount'],
//           // 'productColor' : doc['productColor'],
//           // 'productDescription' : doc['productDescription'],
//           // 'productDetail1' : doc['productDetail1'],
//           // 'productDetail2' : doc['productDetail2'],
//           // 'productDetail3' : doc['productDetail3'],
//           // 'productDetail4' : doc['productDetail4'],
//           // 'productTitle1' : doc['productTitle1'],
//           // 'productTitle2' : doc['productTitle2'],
//           // 'productTitle3' : doc['productTitle3'],
//           // 'productTitle4' : doc['productTitle4']
//         });
//       });
//
//       setState(() {
//         cartItems = fetchedCartItems;
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error fetching cart data: $e');
//     }
//   }
//
//   Future<void> addToCart(String productId) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       // Check if the product already exists in the cart
//       var existingItem = cartItems.firstWhere(
//             (item) => item['productId'] == productId,
//         orElse: () => <String, dynamic>{}, // Return an empty Map if no matching item is found
//       );
//
//       if (existingItem.isNotEmpty) {
//         // Product already exists, update the quantity
//         int newQuantity = existingItem['quantity'] + 1;
//         await cartsCollection.doc(existingItem['docId']).update({
//           'quantity': newQuantity,
//         });
//
//         setState(() {
//           existingItem['quantity'] = newQuantity;
//           totalPrice = calculateTotalPrice(cartItems);
//         });
//       } else {
//         // Product does not exist, add it to the cart
//         // Perform the necessary steps to add the product to the cart
//       }
//
//
//     } catch (e) {
//       print('Error adding to cart: $e');
//     }
//   }
//
//   //
//   // Future<void> addToCart(String productId) async {
//   //   try {
//   //     User? user = FirebaseAuth.instance.currentUser;
//   //     if (user == null) {
//   //       return;
//   //     }
//   //
//   //     CollectionReference cartsCollection =
//   //     FirebaseFirestore.instance.collection('carts');
//   //
//   //     // Check if the product already exists in the cart
//   //     var existingItem = cartItems.firstWhere(
//   //           (item) => item['productId'] == productId,
//   //       orElse: () => <String, dynamic>{}, // Return an empty Map if no matching item is found
//   //     );
//   //
//   //     if (existingItem.isNotEmpty) {
//   //       // Product already exists, update the quantity
//   //       int newQuantity = existingItem['quantity'] + 1;
//   //       await cartsCollection.doc(existingItem['docId']).update({
//   //         'quantity': newQuantity,
//   //       });
//   //
//   //       setState(() {
//   //         existingItem['quantity'] = newQuantity;
//   //         totalPrice = calculateTotalPrice(cartItems);
//   //       });
//   //     } else {
//   //       // Product does not exist, add it to the cart
//   //       // Perform the necessary steps to add the product to the cart
//   //       // For example:
//   //       await cartsCollection.add({
//   //         'productId': productId,
//   //         'quantity': 1,
//   //         // Add other product details as needed
//   //       });
//   //
//   //       setState(() {
//   //         cartItems.add({
//   //           'productId': productId,
//   //           'quantity': 1,
//   //           // Add other product details as needed
//   //         });
//   //         totalPrice = calculateTotalPrice(cartItems);
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error adding to cart: $e');
//   //   }
//   // }
//
//
//   double calculateTotalPrice(List<Map<String, dynamic>> items) {
//     double total = 0.0;
//     for (var item in items) {
//       total +=
//           double.parse(item['productNewPrice'].toString()) * item['quantity'];
//     }
//     return total;
//   }
//
//   double calculateTotalPriceForItem(String docId, int quantity) {
//     // Find the item with the given docId
//     var item = cartItems.firstWhere((item) => item['docId'] == docId);
//
//     // Calculate the total price for the item
//     double price = double.parse(item['productNewPrice'].toString());
//     return price * quantity;
//   }
//
//   void updateQuantityInCart(String docId, int newQuantity) async {
//     try {
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       // Calculate the total price for the item
//       double total = calculateTotalPriceForItem(docId, newQuantity);
//
//       // Update the quantity and total price in Firestore
//       await cartsCollection.doc(docId).update({
//         'quantity': newQuantity,
//         'totalPrice': total,
//       });
//
//       setState(() {
//         // Update the quantity locally
//         cartItems.firstWhere((item) => item['docId'] == docId)['quantity'] =
//             newQuantity;
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error updating quantity in cart: $e');
//     }
//   }
//
//   void removeFromCart(String docId) async {
//     try {
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       await cartsCollection.doc(docId).delete();
//
//       setState(() {
//         // Remove the item locally
//         cartItems.removeWhere((item) => item['docId'] == docId);
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error removing item from cart: $e');
//     }
//   }
//
// //   void moveToOrderCollection() async {
// //     try {
// //       User? user = FirebaseAuth.instance.currentUser;
// //       if (user == null) {
// //         return;
// //       }
// //
// //       CollectionReference cartsCollection =
// //       FirebaseFirestore.instance.collection('carts');
// //       CollectionReference ordersCollection =
// //       FirebaseFirestore.instance.collection('orders');
// //
// //       // Get the cart items
// //       QuerySnapshot querySnapshot = await cartsCollection
// //           .where('uid', isEqualTo: user.uid)
// //           .get();
// //
// //       List<Map<String, dynamic>> orderItems = [];
// //       double totalOrderPrice = 0.0;
// //
// //       // Loop through each cart item
// //       querySnapshot.docs.forEach((doc) {
// //         // Extract necessary information from the cart item
// //         double productNewPrice = double.parse(doc['productNewPrice']);
// //         int quantity = doc['quantity']; // No need to parse, as it's already an integer
// //
// // // Calculate subtotal for each item
// //         double subtotal = productNewPrice * quantity;
// //
// //         // Add subtotal to the total order price
// //         totalOrderPrice += subtotal;
// //
// //         Map<String, dynamic> orderItem = {
// //           'productName': doc['productName'],
// //           'productNewPrice': productNewPrice,
// //           'quantity': quantity,
// //           'subtotal': subtotal,
// //           // Add any other necessary fields
// //         };
// //
// //         // Add the item to the list of order items
// //         orderItems.add(orderItem);
// //       });
// //
// //       // Create a new order document in the orders collection
// //       DocumentReference newOrderRef = await ordersCollection.add({
// //         'userId': user.uid,
// //         'items': orderItems,
// //         'totalPrice': totalOrderPrice,
// //         'timestamp': Timestamp.now(), // Add timestamp for ordering
// //         // Add any other necessary fields
// //       });
// //
// //       // Clear the cart after moving the items
// //       querySnapshot.docs.forEach((doc) {
// //         doc.reference.delete();
// //       });
// //
// //       print('Order placed successfully with ID: ${newOrderRef.id}');
// //     } catch (e) {
// //       print('Error moving items to order collection: $e');
// //     }
// //   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           var item = cartItems[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ProductDetailScreen(
//                         products: productModel(
//                           id: item['productId'] ?? '',
//                           productName: item['productName'] ?? '',
//                           productPrice: item['productPrice'] ?? '',
//                           productColor: item['productColor'] ?? '',
//                           productDescription:
//                           item['productDescription'] ?? '',
//                           productTitle1: item['productTitle1'] ?? '',
//                           productTitleDetail1:
//                           item['productDetail1'] ?? '',
//                           productTitle2: item['productTitle2'] ?? '',
//                           productTitleDetail2:
//                           item['productDetail2'] ?? '',
//                           productTitle3: item['productTitle3'] ?? '',
//                           productTitleDetail3:
//                           item['productDetail3'] ?? '',
//                           productTitle4: item['productTitle4'] ?? '',
//                           productTitleDetail4:
//                           item['productDetail4'] ?? '',
//                           allDetails: item['allDetails'] ?? '',
//                           image: List<String>.from(item['image'] ?? []),
//                           discount: item['ProductDiscount'] ?? '',
//                           quantity: item['quantity'] ?? '',
//                           total: item['total'] ?? '',
//                           productNewPrice:
//                           item['productNewPrice'] ?? '',
//                           category: item['category'] ?? '',
//                           subCategory: item['subCategory'] ?? '',
//                           // subtotal: item['subtotal'],
//                         ),
//                       )));
//             },
//             child: Card(
//               child: ListTile(
//                 title: Text(item['productName']),
//                 subtitle: Text('Price: \₹${item['productNewPrice']}'),
//                 leading: Image.network(
//                   item['image'] != null && item['image'].isNotEmpty
//                       ? item['image'][0]
//                       : '',
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         if (item['quantity'] > 1) {
//                           updateQuantityInCart(
//                               item['docId'], item['quantity'] - 1);
//                         } else {
//                           removeFromCart(item['docId']);
//                         }
//                       },
//                       icon: Icon(Icons.remove),
//                     ),
//                     Text(item['quantity'].toString()),
//                     IconButton(
//                       onPressed: () {
//                         updateQuantityInCart(
//                             item['docId'], item['quantity'] + 1);
//                       },
//                       icon: Icon(Icons.add),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total: ₹${totalPrice.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 width: 100,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Move cart data to order collection
//                     // moveToOrderCollection();
//                     // Navigate to BottomNavigationHome
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => BuyScreen()));
//
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.lightBlue,
//                   ),
//                   child: Text(
//                     'Buy',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
// //
// //
// //
// // //
// // // //error code
// // // import 'package:flutter/material.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // import '../../Seller/Products/producrDetailScreen.dart';
// // //
// // // class CartPage extends StatefulWidget {
// // //   @override
// // //   _CartPageState createState() => _CartPageState();
// // // }
// // //
// // // class _CartPageState extends State<CartPage> {
// // //   late List<Map<String, dynamic>> cartItems = [];
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchCartData();
// // //   }
// // //
// // //   Future<void> fetchCartData() async {
// // //     try {
// // //       // Get the current user
// // //       User? user = FirebaseAuth.instance.currentUser;
// // //       if (user == null) {
// // //         // User not authenticated
// // //         return;
// // //       }
// // //
// // //       // Reference to the carts collection
// // //       CollectionReference cartsCollection =
// // //       FirebaseFirestore.instance.collection('carts');
// // //
// // //       // Fetch cart data from Firestore for the current user
// // //       QuerySnapshot querySnapshot = await cartsCollection
// // //           .where('userId', isEqualTo: user.uid)
// // //           .get();
// // //
// // //       // Extract cart items from the query snapshot
// // //       Map<String, Map<String, dynamic>> cartItemsMap = {};
// // //       querySnapshot.docs.forEach((doc) {
// // //         final productId = doc['productId'];
// // //         if (!cartItemsMap.containsKey(productId)) {
// // //           // Convert the 'image' field to a list of strings
// // //           List<String> images = List<String>.from(doc['image']);
// // //           cartItemsMap[productId] = {
// // //             'productName': doc['productName'],
// // //             'productNewPrice': doc['productNewPrice'],
// // //             'quantity': doc['quantity'],
// // //             'images': images, // Store images as a list
// // //           };
// // //         } else {
// // //           // Increase the quantity if the product is already in the cart
// // //           cartItemsMap[productId]!['quantity'] += doc['quantity'];
// // //         }
// // //       });
// // //
// // //       setState(() {
// // //         cartItems = cartItemsMap.values.toList();
// // //       });
// // //     } catch (e) {
// // //       // Handle any errors here
// // //       print('Error fetching cart data: $e');
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Cart'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: cartItems.length,
// // //         itemBuilder: (context, index) {
// // //           var item = cartItems[index];
// // //           return GestureDetector(
// // //             onTap: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(
// // //                   builder: (context) => ProductDetailScreen(data: {
// // //                     'image': item['image'],
// // //                     'productName': item['productName'],
// // //                     'productNewPrice': item['productNewPrice'],
// // //                     'discount': item['discount']
// // //                   }),
// // //                 ),
// // //               );
// // //             },
// // //             child: Card(
// // //               child: ListTile(
// // //                 title: Text(item['productName']),
// // //                 subtitle: Text('Price: \$${item['productNewPrice']}'),
// // //                 leading: Image.network(
// // //                   item['images'][0], // Display the first image
// // //                   width: 50,
// // //                   height: 50,
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //                 trailing: Row(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     IconButton(
// // //                       onPressed: () {
// // //                         setState(() {
// // //                           if (item['quantity'] > 1) {
// // //                             item['quantity']--;
// // //                           }
// // //                         });
// // //                       },
// // //                       icon: Icon(Icons.remove),
// // //                     ),
// // //                     Text(item['quantity'].toString()),
// // //                     IconButton(
// // //                       onPressed: () {
// // //                         setState(() {
// // //                           item['quantity']++;
// // //                         });
// // //                       },
// // //                       icon: Icon(Icons.add),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
//
//
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // class CartPage extends StatefulWidget {
// //   @override
// //   _CartPageState createState() => _CartPageState();
// // }
// //
// // class _CartPageState extends State<CartPage> {
// //   late List<Map<String, dynamic>> _cartItems;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _cartItems = [];
// //     _fetchCartItems();
// //   }
// //
// //   Future<void> _fetchCartItems() async {
// //     final snapshot = await FirebaseFirestore.instance
// //         .collection('carts')
// //         .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
// //         .get();
// //
// //     setState(() {
// //       _cartItems = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
// //     });
// //   }
// //
// //   void _updateQuantity(int index, int newQuantity) async {
// //     if (newQuantity <= 0) {
// //       await FirebaseFirestore.instance.collection('carts').doc(_cartItems[index]['uid']).delete();
// //     } else {
// //       await FirebaseFirestore.instance.collection('carts').doc(_cartItems[index]['uid']).update({'quantity': newQuantity});
// //     }
// //     _fetchCartItems();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Cart'),
// //       ),
// //       body: _cartItems.isEmpty
// //           ? Center(
// //         child: Text('No items in cart'),
// //       )
// //           : ListView.builder(
// //         itemCount: _cartItems.length,
// //         itemBuilder: (context, index) {
// //           final cartItem = _cartItems[index];
// //           final imageUrl = cartItem['imageUrl'] as String?; // Ensure imageUrl is of type String or nullable String
// //
// //           return Card(
// //             child: ListTile(
// //               title: Text(cartItem['productName']),
// //               subtitle: Row(
// //                 children: [
// //                   IconButton(
// //                     icon: Icon(Icons.remove),
// //                     onPressed: () {
// //                       _updateQuantity(index, cartItem['quantity'] - 1);
// //                     },
// //                   ),
// //                   Text(cartItem['quantity'].toString()),
// //                   IconButton(
// //                     icon: Icon(Icons.add),
// //                     onPressed: () {
// //                       _updateQuantity(index, cartItem['quantity'] + 1);
// //                     },
// //                   ),
// //                 ],
// //               ),
// //               // Display the image here, with a default image URL if imageUrl is null
// //               leading: imageUrl != null
// //                   ? Image.network(
// //                 imageUrl,
// //                 width: 50,
// //                 height: 50,
// //                 fit: BoxFit.cover,
// //               )
// //                   : Placeholder(), // Provide a default placeholder image or widget
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }



// my
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
// import 'package:StyleHub/Seller/Products/productModel.dart';
// import 'package:StyleHub/Users/buy%20now.dart';
// import 'package:StyleHub/Users/userAddress.dart';
//
// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   late List<Map<String, dynamic>> cartItems = [];
//   double totalPrice = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCartData();
//   }
//
//   Future<void> fetchCartData() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       QuerySnapshot querySnapshot = await cartsCollection
//           .where('uid', isEqualTo: user.uid)
//           .get();
//
//       List<Map<String, dynamic>> fetchedCartItems = [];
//
//       querySnapshot.docs.forEach((doc) {
//         List<String> images = List<String>.from(doc['image'] ?? []);
//
//         // Wrap the code accessing the 'quantity' field in a try-catch block
//         try {
//           fetchedCartItems.add({
//             'docId': doc.id,
//             'productName': doc['productName'] ?? '',
//             'productNewPrice': doc['productNewPrice'] ?? '',
//             'quantity': doc['quantity'] ?? '', // Access the 'quantity' field
//             'image': images,
//           });
//         } catch (e) {
//           print('Error accessing quantity field: $e');
//         }
//       });
//
//       setState(() {
//         cartItems = fetchedCartItems;
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error fetching cart data: $e');
//     }
//   }
//
//   Future<void> addToCart(String productId) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         return;
//       }
//
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       // Check if the product already exists in the cart
//       var existingItem = cartItems.firstWhere(
//             (item) => item['productId'] == productId,
//         orElse: () => <String, dynamic>{},
//       );
//
//       if (existingItem.isNotEmpty) {
//         // Product already exists, update the quantity
//         int newQuantity = existingItem['quantity'] + 1;
//         await cartsCollection.doc(existingItem['docId']).update({
//           'quantity': newQuantity,
//         });
//
//         setState(() {
//           existingItem['quantity'] = newQuantity;
//           totalPrice = calculateTotalPrice(cartItems);
//         });
//       } else {
//         // Product does not exist, add it to the cart
//         await cartsCollection.add({
//           'productId': productId,
//           'quantity': 1,
//         });
//
//         setState(() {
//           cartItems.add({
//             'productId': productId,
//             'quantity': 1,
//           });
//           totalPrice = calculateTotalPrice(cartItems);
//         });
//       }
//     } catch (e) {
//       print('Error adding to cart: $e');
//     }
//   }
//
//   double calculateTotalPrice(List<Map<String, dynamic>> items) {
//     double total = 0.0;
//     for (var item in items) {
//       total += double.parse(item['productNewPrice'].toString()) * item['quantity'];
//     }
//     return total;
//   }
//
//   double calculateTotalPriceForItem(String docId, int quantity) {
//     var item = cartItems.firstWhere((item) => item['docId'] == docId);
//     double price = double.parse(item['productNewPrice'].toString());
//     return price * quantity;
//   }
//
//   void updateQuantityInCart(String docId, int newQuantity) async {
//     try {
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       double total = calculateTotalPriceForItem(docId, newQuantity);
//
//       await cartsCollection.doc(docId).update({
//         'quantity': newQuantity,
//         'totalPrice': total,
//       });
//
//       setState(() {
//         cartItems.firstWhere((item) => item['docId'] == docId)['quantity'] = newQuantity;
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error updating quantity in cart: $e');
//     }
//   }
//
//   void removeFromCart(String docId) async {
//     try {
//       CollectionReference cartsCollection =
//       FirebaseFirestore.instance.collection('carts');
//
//       await cartsCollection.doc(docId).delete();
//
//       setState(() {
//         cartItems.removeWhere((item) => item['docId'] == docId);
//         totalPrice = calculateTotalPrice(cartItems);
//       });
//     } catch (e) {
//       print('Error removing item from cart: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool isCartEmpty = cartItems.isEmpty;
//     double totalWithDeliveryCharge = isCartEmpty ? 0.0 : totalPrice + (totalPrice > 10000 ? 0 : 50);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Cart'),
//       ),
//       body: isCartEmpty
//           ? Center(
//         child: Text(
//           'Your cart is empty!',
//           style: TextStyle(fontSize: 18),
//         ),
//       )
//           : ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           var item = cartItems[index];
//           return Card(
//             elevation: 4,
//             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             child: ListTile(
//               title: Text(
//                 item['productName'],
//                 style: TextStyle(fontSize: 18),
//               ),
//               subtitle: Text(
//                 'Price: \₹${item['productNewPrice']}',
//                 style: TextStyle(fontSize: 16),
//               ),
//               leading: Image.network(
//                 item['image'] != null && item['image'].isNotEmpty
//                     ? item['image'][0]
//                     : '',
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       if (item['quantity'] > 1) {
//                         updateQuantityInCart(item['docId'], item['quantity'] - 1);
//                       } else {
//                         removeFromCart(item['docId']);
//                       }
//                     },
//                     icon: Icon(Icons.remove),
//                   ),
//                   Text(
//                     item['quantity'].toString(),
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       updateQuantityInCart(item['docId'], item['quantity'] + 1);
//                     },
//                     icon: Icon(Icons.add),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: SafeArea(
//         child: SizedBox(
//           height: 100,
//           child: BottomAppBar(
//             elevation: 10,
//             color: Colors.grey[200],
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Total : ₹${totalWithDeliveryCharge.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       if (!isCartEmpty && totalPrice <= 10000)
//                         Text(
//                           'Delivery Charge : ₹50',
//                           style: TextStyle(
//                             fontSize: 16,
//                           ),
//                         ),
//                       if (!isCartEmpty && totalPrice > 10000)
//                         Text(
//                           'Free Delivery!',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.green,
//                           ),
//                         ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: cartItems.isNotEmpty
//                         ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BuyScreen(),
//                         ),
//                       );
//                     }
//                         : null,
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       primary: Colors.indigo,
//                     ),
//                     child: Text(
//                       'Buy',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Seller/Products/productModel.dart';
import 'checkout.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  _AddToCartScreenState createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  List<ProductModel> _cartItems = [];
  double _subtotal = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserCartProducts();
  }

  Future<void> _fetchUserCartProducts() async {
    try {
      String UID = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('carts')
          .where('uid', isEqualTo: UID)
          .get();

      List<ProductModel> products = [];
      double subtotal = 0.0;
      for (var doc in querySnapshot.docs) {
        ProductModel product = ProductModel.fromSnapshot(doc);
        try {
          // Remove commas from the price string and parse as double
          double price = double.parse(product.newPrice.replaceAll(',', ''));
          int quantity = int.parse(product.selectedqty);
          double totalPrice = price * quantity;
          // Assign the calculated total price to the product
          product.totalprice = totalPrice.toString();
          subtotal += totalPrice;
        } catch (e) {
          print('Error calculating total price: $e');
          // Handle the error or set default values
        }
        products.add(product);
      }

      setState(() {
        _cartItems = products;
        _subtotal = subtotal;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }


  void _deleteProduct(ProductModel product) async {
    try {
      await FirebaseFirestore.instance
          .collection('carts')
          .doc(product.id)
          .delete();

      // Refresh cart items after deletion
      _fetchUserCartProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  void _updateQuantity(ProductModel product, int quantity) async {
    try {
      if (quantity > 0) {
        double newTotalPrice = double.parse(product.newPrice.replaceAll(',', '')) * quantity;
        await FirebaseFirestore.instance
            .collection('carts')
            .doc(product.id)
            .update({
          'quantity': quantity.toString(),
          'totalprice': newTotalPrice.toString(),
        });
      } else {
        // If quantity becomes 0, delete the product from the cart
        await FirebaseFirestore.instance
            .collection('carts')
            .doc(product.id)
            .delete();
      }

      // Refresh cart items after updating quantity
      _fetchUserCartProducts();
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              ProductModel product = _cartItems[index];
              return GestureDetector(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product)));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0), // Added this line
                      leading: Image.network(
                        product.images![0],
                        width: 100,
                        height: 100,
                        // fit: BoxFit.cover,
                      ),
                      title: Text(product.productName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'M.R.P: ${product.newPrice}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Price: ${product.totalprice}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      int newQuantity =
                                          int.parse(product.selectedqty) - 1;
                                      if (newQuantity >= 0) {
                                        _updateQuantity(product, newQuantity);
                                      }
                                    },
                                  ),
                                  Text(product.selectedqty.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      int newQuantity =
                                          int.parse(product.selectedqty) + 1;
                                      _updateQuantity(product, newQuantity);
                                    },
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteConfirmationDialog(product);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal: $_subtotal',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => CheckOutScreen(cartItems: _cartItems),
            //       ),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))),
            //   child: const Text(
            //     'Checkout',
            //     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            //   ),
            // ),

            ElevatedButton(
              onPressed: _cartItems.isNotEmpty ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckOutScreen(cartItems: _cartItems),
                  ),
                );
              } : null, // Set onPressed to null if _cartItems is empty
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(product);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}