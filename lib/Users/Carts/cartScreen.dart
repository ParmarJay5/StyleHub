// import 'package:StyleHub/Users/buyNow.dart';
// import 'package:flutter/material.dart';
//
// class CartPage extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;
//
//   const CartPage({Key? key, required this.cartItems}) : super(key: key);
//
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     double total = 0.0;
//
//     // Calculate total price of all items in the cart
//     for (var item in widget.cartItems) {
//       // Ensure that 'productNewPrice' is parsed to a double
//       total +=
//           double.parse(item['productNewPrice'].toString()) * item['quantity'];
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.cartItems.length,
//         itemBuilder: (context, index) {
//           var item = widget.cartItems[index];
//           return Card(
//             child: ListTile(
//               title: Text(item['productName']),
//               subtitle: Text('Price: \$${item['productNewPrice']}'),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         if (item['quantity'] > 1) {
//                           item['quantity']--;
//                         }
//                       });
//                     },
//                     icon: Icon(Icons.remove),
//                   ),
//                   Text(item['quantity'].toString()),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         item['quantity']++;
//                       });
//                     },
//                     icon: Icon(Icons.add),
//                   ),
//                 ],
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
//                 'Total: \$${total.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(width: 80,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => BuyScreen()));
//                     // Implement buy action
//                   },
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
//                   child: Text('Buy',style: TextStyle(color: Colors.white),),
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

//main




import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
import 'package:StyleHub/Seller/Products/productModel.dart';
import 'package:StyleHub/Users/buyNow.dart';
import '../../homeScreens/homeScreen.dart'; // Import the BottomNavigationHome screen

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Map<String, dynamic>> cartItems = [];
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('carts');

      QuerySnapshot querySnapshot = await cartsCollection
          .where('uid', isEqualTo: user.uid)
          .get();

      List<Map<String, dynamic>> fetchedCartItems = [];

      querySnapshot.docs.forEach((doc) {
        List<String> images =
        List<String>.from(doc['image'] ?? []);

        fetchedCartItems.add({
          'docId': doc.id, // Store the document ID
          'productName': doc['productName'] ?? '',
          'productNewPrice': doc['productNewPrice'] ?? '',
          'quantity': doc['quantity'] ?? '',
          'image': images,
          // 'productPrice' : doc['productPrice'] ?? '',
          // 'allDetails' : doc['allDetails']?? '',
          // 'ProductDiscount' : doc['ProductDiscount'] ?? '',
          // 'productColor' : doc['productColor'] ?? '',
          // 'productDescription' : doc['productDescription'] ?? '',
          // 'productDetail1' : doc['productDetail1'] ?? '',
          // 'productDetail2' : doc['productDetail2'] ?? '',
          // 'productDetail3' : doc['productDetail3'] ?? '',
          // 'productDetail4' : doc['productDetail4'] ?? '',
          // 'productTitle1' : doc['productTitle1'] ?? '',
          // 'productTitle2' : doc['productTitle2'] ?? '',
          // 'productTitle3' : doc['productTitle3'] ?? '',
          // 'productTitle4' : doc['productTitle4'] ?? '',
        });
      });

      setState(() {
        cartItems = fetchedCartItems;
        totalPrice = calculateTotalPrice(cartItems);
      });
    } catch (e) {
      print('Error fetching cart data: $e');
    }
  }

  double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0.0;
    for (var item in items) {
      total +=
          double.parse(item['productNewPrice'].toString()) * item['quantity'];
    }
    return total;
  }

  double calculateTotalPriceForItem(String docId, int quantity) {
    // Find the item with the given docId
    var item = cartItems.firstWhere((item) => item['docId'] == docId);

    // Calculate the total price for the item
    double price = double.parse(item['productNewPrice'].toString());
    return price * quantity;
  }

  void updateQuantityInCart(String docId, int newQuantity) async {
    try {
      CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('carts');

      // Calculate the total price for the item
      double total = calculateTotalPriceForItem(docId, newQuantity);

      // Update the quantity and total price in Firestore
      await cartsCollection.doc(docId).update({
        'quantity': newQuantity,
        'totalPrice': total,
      });

      setState(() {
        // Update the quantity locally
        cartItems.firstWhere((item) => item['docId'] == docId)['quantity'] =
            newQuantity;
        totalPrice = calculateTotalPrice(cartItems);
      });
    } catch (e) {
      print('Error updating quantity in cart: $e');
    }
  }

  void removeFromCart(String docId) async {
    try {
      CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('carts');

      await cartsCollection.doc(docId).delete();

      setState(() {
        // Remove the item locally
        cartItems.removeWhere((item) => item['docId'] == docId);
        totalPrice = calculateTotalPrice(cartItems);
      });
    } catch (e) {
      print('Error removing item from cart: $e');
    }
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

      // Get the cart items
      QuerySnapshot querySnapshot = await cartsCollection
          .where('uid', isEqualTo: user.uid)
          .get();

      List<Map<String, dynamic>> orderItems = [];
      double totalOrderPrice = 0.0;

      // Loop through each cart item
      querySnapshot.docs.forEach((doc) {
        // Extract necessary information from the cart item
        double productNewPrice = double.parse(doc['productNewPrice']);
        int quantity = doc['quantity']; // No need to parse, as it's already an integer

// Calculate subtotal for each item
        double subtotal = productNewPrice * quantity;

        // Add subtotal to the total order price
        totalOrderPrice += subtotal;

        Map<String, dynamic> orderItem = {
          'productName': doc['productName'],
          'productNewPrice': productNewPrice,
          'quantity': quantity,
          'subtotal': subtotal,
          // Add any other necessary fields
        };

        // Add the item to the list of order items
        orderItems.add(orderItem);
      });

      // Create a new order document in the orders collection
      DocumentReference newOrderRef = await ordersCollection.add({
        'userId': user.uid,
        'items': orderItems,
        'totalPrice': totalOrderPrice,
        'timestamp': Timestamp.now(), // Add timestamp for ordering
        // Add any other necessary fields
      });

      // Clear the cart after moving the items
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });

      print('Order placed successfully with ID: ${newOrderRef.id}');
    } catch (e) {
      print('Error moving items to order collection: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          var item = cartItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        products: productModel(
                          id: item['productId'] ?? '',
                          productName: item['productName'] ?? '',
                          productPrice: item['productPrice'] ?? '',
                          productColor: item['productColor'] ?? '',
                          productDescription:
                          item['productDescription'] ?? '',
                          productTitle1: item['productTitle1'] ?? '',
                          productTitleDetail1:
                          item['productDetail1'] ?? '',
                          productTitle2: item['productTitle2'] ?? '',
                          productTitleDetail2:
                          item['productDetail2'] ?? '',
                          productTitle3: item['productTitle3'] ?? '',
                          productTitleDetail3:
                          item['productDetail3'] ?? '',
                          productTitle4: item['productTitle4'] ?? '',
                          productTitleDetail4:
                          item['productDetail4'] ?? '',
                          allDetails: item['allDetails'] ?? '',
                          image: List<String>.from(item['image'] ?? []),
                          discount: item['ProductDiscount'] ?? '',
                          quantity: item['quantity'] ?? '',
                          total: item['total'] ?? '',
                          productNewPrice:
                          item['productNewPrice'] ?? '',
                          category: item['category'] ?? '',
                          subCategory: item['subCategory'] ?? '',
                          subtotal: item['subtotal'],
                        ),
                      )));
            },
            child: Card(
              child: ListTile(
                title: Text(item['productName']),
                subtitle: Text('Price: \₹${item['productNewPrice']}'),
                leading: Image.network(
                  item['image'] != null && item['image'].isNotEmpty
                      ? item['image'][0]
                      : '',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item['quantity'] > 1) {
                          updateQuantityInCart(
                              item['docId'], item['quantity'] - 1);
                        } else {
                          removeFromCart(item['docId']);
                        }
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(item['quantity'].toString()),
                    IconButton(
                      onPressed: () {
                        updateQuantityInCart(
                            item['docId'], item['quantity'] + 1);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ₹${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    // Move cart data to order collection
                    moveToOrderCollection();
                    // Navigate to BottomNavigationHome
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyScreen()));

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text(
                    'Buy',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







//
//
//
// //
// // //error code
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import '../../Seller/Products/producrDetailScreen.dart';
// //
// // class CartPage extends StatefulWidget {
// //   @override
// //   _CartPageState createState() => _CartPageState();
// // }
// //
// // class _CartPageState extends State<CartPage> {
// //   late List<Map<String, dynamic>> cartItems = [];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchCartData();
// //   }
// //
// //   Future<void> fetchCartData() async {
// //     try {
// //       // Get the current user
// //       User? user = FirebaseAuth.instance.currentUser;
// //       if (user == null) {
// //         // User not authenticated
// //         return;
// //       }
// //
// //       // Reference to the carts collection
// //       CollectionReference cartsCollection =
// //       FirebaseFirestore.instance.collection('carts');
// //
// //       // Fetch cart data from Firestore for the current user
// //       QuerySnapshot querySnapshot = await cartsCollection
// //           .where('userId', isEqualTo: user.uid)
// //           .get();
// //
// //       // Extract cart items from the query snapshot
// //       Map<String, Map<String, dynamic>> cartItemsMap = {};
// //       querySnapshot.docs.forEach((doc) {
// //         final productId = doc['productId'];
// //         if (!cartItemsMap.containsKey(productId)) {
// //           // Convert the 'image' field to a list of strings
// //           List<String> images = List<String>.from(doc['image']);
// //           cartItemsMap[productId] = {
// //             'productName': doc['productName'],
// //             'productNewPrice': doc['productNewPrice'],
// //             'quantity': doc['quantity'],
// //             'images': images, // Store images as a list
// //           };
// //         } else {
// //           // Increase the quantity if the product is already in the cart
// //           cartItemsMap[productId]!['quantity'] += doc['quantity'];
// //         }
// //       });
// //
// //       setState(() {
// //         cartItems = cartItemsMap.values.toList();
// //       });
// //     } catch (e) {
// //       // Handle any errors here
// //       print('Error fetching cart data: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Cart'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: cartItems.length,
// //         itemBuilder: (context, index) {
// //           var item = cartItems[index];
// //           return GestureDetector(
// //             onTap: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => ProductDetailScreen(data: {
// //                     'image': item['image'],
// //                     'productName': item['productName'],
// //                     'productNewPrice': item['productNewPrice'],
// //                     'discount': item['discount']
// //                   }),
// //                 ),
// //               );
// //             },
// //             child: Card(
// //               child: ListTile(
// //                 title: Text(item['productName']),
// //                 subtitle: Text('Price: \$${item['productNewPrice']}'),
// //                 leading: Image.network(
// //                   item['images'][0], // Display the first image
// //                   width: 50,
// //                   height: 50,
// //                   fit: BoxFit.cover,
// //                 ),
// //                 trailing: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     IconButton(
// //                       onPressed: () {
// //                         setState(() {
// //                           if (item['quantity'] > 1) {
// //                             item['quantity']--;
// //                           }
// //                         });
// //                       },
// //                       icon: Icon(Icons.remove),
// //                     ),
// //                     Text(item['quantity'].toString()),
// //                     IconButton(
// //                       onPressed: () {
// //                         setState(() {
// //                           item['quantity']++;
// //                         });
// //                       },
// //                       icon: Icon(Icons.add),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }
//
// class _CartPageState extends State<CartPage> {
//   late List<Map<String, dynamic>> _cartItems;
//
//   @override
//   void initState() {
//     super.initState();
//     _cartItems = [];
//     _fetchCartItems();
//   }
//
//   Future<void> _fetchCartItems() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('carts')
//         .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//         .get();
//
//     setState(() {
//       _cartItems = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//     });
//   }
//
//   void _updateQuantity(int index, int newQuantity) async {
//     if (newQuantity <= 0) {
//       await FirebaseFirestore.instance.collection('carts').doc(_cartItems[index]['uid']).delete();
//     } else {
//       await FirebaseFirestore.instance.collection('carts').doc(_cartItems[index]['uid']).update({'quantity': newQuantity});
//     }
//     _fetchCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: _cartItems.isEmpty
//           ? Center(
//         child: Text('No items in cart'),
//       )
//           : ListView.builder(
//         itemCount: _cartItems.length,
//         itemBuilder: (context, index) {
//           final cartItem = _cartItems[index];
//           final imageUrl = cartItem['imageUrl'] as String?; // Ensure imageUrl is of type String or nullable String
//
//           return Card(
//             child: ListTile(
//               title: Text(cartItem['productName']),
//               subtitle: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.remove),
//                     onPressed: () {
//                       _updateQuantity(index, cartItem['quantity'] - 1);
//                     },
//                   ),
//                   Text(cartItem['quantity'].toString()),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       _updateQuantity(index, cartItem['quantity'] + 1);
//                     },
//                   ),
//                 ],
//               ),
//               // Display the image here, with a default image URL if imageUrl is null
//               leading: imageUrl != null
//                   ? Image.network(
//                 imageUrl,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               )
//                   : Placeholder(), // Provide a default placeholder image or widget
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
