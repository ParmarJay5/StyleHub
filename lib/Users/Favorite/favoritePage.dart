// import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }
//
// class _FavoriteScreenState extends State<FavoriteScreen> {
//   late List<Map<String, dynamic>> favoriteItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchFavoriteData();
//   }
//
//   Future<void> fetchFavoriteData() async {
//     try {
//       // Get the current user
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         // User not authenticated
//         return;
//       }
//
//       // Reference to the favorites collection
//       CollectionReference favoritesCollection =
//       FirebaseFirestore.instance.collection('favorites');
//
//       // Fetch favorite data from Firestore for the current user
//       QuerySnapshot querySnapshot = await favoritesCollection
//           .where('uid', isEqualTo: user.uid)
//           .get();
//
//       // Extract favorite items from the query snapshot
//       List<Map<String, dynamic>> fetchedFavoriteItems = [];
//
//       querySnapshot.docs.forEach((doc) {
//         // Convert the 'image' field to a list of strings
//         List<String> images = List<String>.from(doc['image']);
//
//         fetchedFavoriteItems.add({
//           'productName': doc['productName'],
//           'productNewPrice': doc['productNewPrice'],
//           'image': images, // Store images as a list
//         });
//       });
//
//       setState(() {
//         favoriteItems = fetchedFavoriteItems;
//       });
//     } catch (e) {
//       // Handle any errors here
//       print('Error fetching favorite data: $e');
//     }
//   }
//
//   void removeFromFavorites(int index) async {
//     try {
//       // Get the current user
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         // User not authenticated
//         return;
//       }
//
//       // Reference to the favorites collection
//       CollectionReference favoritesCollection =
//       FirebaseFirestore.instance.collection('favorites');
//
//       // Query the favorites collection for documents with the user's UID
//       QuerySnapshot querySnapshot = await favoritesCollection
//           .where('uid', isEqualTo: user.uid)
//           .get();
//
//       // Iterate through the documents and delete them
//       querySnapshot.docs.forEach((doc) async {
//         // Delete the document
//         await doc.reference.delete();
//       });
//
//       setState(() {
//         // Remove the item from the local state
//         favoriteItems.removeAt(index);
//       });
//     } catch (e) {
//       // Handle any errors here
//       print('Error removing from favorites: $e');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorites'),
//       ),
//       body: ListView.builder(
//         itemCount: favoriteItems.length,
//         itemBuilder: (context, index) {
//           var item = favoriteItems[index];
//           return GestureDetector(
//             onTap: () {
//               // Handle tap event on the card
//             },
//             child: Container(
//               margin: EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 3,
//                     blurRadius: 7,
//                     offset: Offset(0, 3), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: Row(crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Left side: Product image
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.only(
//                         // topLeft: Radius.circular(10.0),
//                         // bottomLeft: Radius.circular(10.0),
//                       // ),
//                       image: DecorationImage(
//                         image: NetworkImage(item['image'][0]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   // Right side: Product details
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item['productName'] ?? '',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             ' \₹ ${item['productNewPrice'] ?? ''}',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.green,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.favorite,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () {
//                                   removeFromFavorites(index);
//                                 },
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//
//                                   },
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: 20,
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     'Add to Cart',
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Seller/Products/producrDetailScreen.dart';
import '../../Seller/Products/productModel.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<Map<String, dynamic>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    fetchFavoriteData();
  }

  Future<void> fetchFavoriteData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

      QuerySnapshot querySnapshot = await favoritesCollection
          .where('uid', isEqualTo: user.uid)
          .get();

      List<Map<String, dynamic>> fetchedFavoriteItems = [];

      querySnapshot.docs.forEach((doc) {
        List<String> images = List<String>.from(doc['image']);

        fetchedFavoriteItems.add({
          'docId': doc.id, // Store document ID for removal
          'productName': doc['productName'],
          'productNewPrice': doc['productNewPrice'],
          'image': images,
          'productPrice' : doc['productPrice'],
          'allDetails' : doc['allDetails'],
          'ProductDiscount' : doc['ProductDiscount'],
          'productColor' : doc['productColor'],
          'productDescription' : doc['productDescription'],
          'productDetail1' : doc['productDetail1'],
          'productDetail2' : doc['productDetail2'],
          'productDetail3' : doc['productDetail3'],
          'productDetail4' : doc['productDetail4'],
          'productTitle1' : doc['productTitle1'],
          'productTitle2' : doc['productTitle2'],
          'productTitle3' : doc['productTitle3'],
          'productTitle4' : doc['productTitle4'],



        });
      });

      setState(() {
        favoriteItems = fetchedFavoriteItems;
      });
    } catch (e) {
      print('Error fetching favorite data: $e');
    }
  }

  void addToCart(int index) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference cartsCollection =
      FirebaseFirestore.instance.collection('carts');

      // Add the item to the cart collection
      await cartsCollection.add({
        'uid': user.uid,
        'productName': favoriteItems[index]['productName'],
        'productNewPrice': favoriteItems[index]['productNewPrice'],
        'image': favoriteItems[index]['image'],
        // 'productPrice': favoriteItems[index]['productPrice'],
      });

      // Remove the item from favorites
      await removeFromFavorites(index);
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> removeFromFavorites(int index) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

      // Remove the favorite item from Firestore
      await favoritesCollection.doc(favoriteItems[index]['docId']).delete();

      setState(() {
        favoriteItems.removeAt(index);
      });
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          var item = favoriteItems[index];
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
                          // quantity: item['quantity'] ?? '',
                          total: item['total'] ?? '',
                          productNewPrice:
                          item['productNewPrice'] ?? '',
                          category: item['category'] ?? '',
                          subCategory: item['subCategory'] ?? '',
                          quantity: item['quantity'],
                          subtotal: item['subtotal'],
                        ),
                      )));
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item['image'][index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['productName'] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            ' \₹ ${item['productNewPrice'] ?? ''}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),

                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  removeFromFavorites(index);
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  addToCart(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
