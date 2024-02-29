// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProductDetailScreen extends StatefulWidget {
//   final Map<String, dynamic>? data;
//
//   const ProductDetailScreen({Key? key, required this.data}) : super(key: key);
//
//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }
//
// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int _quantity = 1; // Default quantity
//   bool _isFavorite = false;
//
//   @override
//   Widget build(BuildContext context) {
//     List<String>? images = widget.data?['image'];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.data?['productName'] ?? 'Product Detail'),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: _isFavorite ? Colors.red : null,
//             ),
//             onPressed: toggleFavorite,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: CarouselSlider(
//                       options: CarouselOptions(
//                         height: 400.0,
//                         enlargeCenterPage: true,
//                         autoPlay: true,
//                         aspectRatio: 16 / 9,
//                       ),
//                       items: images?.map((image) {
//                         return Builder(
//                           builder: (BuildContext context) {
//                             return Image.network(
//                               image,
//                               fit: BoxFit.cover,
//                             );
//                           },
//                         );
//                       }).toList() ?? [],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Product Name: ${widget.data?['productName'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Discount: \- ${widget.data?['ProductDiscount'] ?? ''}%',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.red,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     '\₹${widget.data?['productPrice'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey[600],
//                       decoration: TextDecoration.lineThrough,
//                     ),
//                   ),
//                   Text(
//                     '\₹${widget.data?['productNewPrice'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.green,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Text(
//                         'Quantity:',
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       DropdownButton<int>(
//                         value: _quantity,
//                         onChanged: (value) {
//                           setState(() {
//                             _quantity = value!;
//                           });
//                         },
//                         items: List.generate(10, (index) => index + 1)
//                             .map<DropdownMenuItem<int>>((int value) {
//                           return DropdownMenuItem<int>(
//                             value: value,
//                             child: Text(value.toString()),
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: addToCart,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                       ),
//                       child: Text(
//                         'Add To Cart',
//                         style: TextStyle(
//                           color: Colors.lightBlue,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Implement buy button functionality
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.lightBlue,
//                       ),
//                       child: Text(
//                         'Buy Now',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Brand: ${widget.data?['productDetail1'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Size: ${widget.data?['productDetail2'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Color: ${widget.data?['productColor'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Description: ${widget.data?['productDescription'] ?? ''}',
//                     style: TextStyle(
//                       fontSize: 16,
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
//
//   void toggleFavorite() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       // User not authenticated
//       return;
//     }
//
//     // Reference to the favorites collection
//     CollectionReference favoritesCollection = FirebaseFirestore.instance.collection('favorites');
//
//     // Check if the product is already favorited
//     QuerySnapshot favoriteQuery = await favoritesCollection
//         .where('uid', isEqualTo: user.uid)
//         .where('productName', isEqualTo: widget.data?['productName']) // Checking by product name instead of productId
//         .get();
//
//     if (favoriteQuery.docs.isNotEmpty) {
//       // Product already favorited, so remove it
//       await favoriteQuery.docs.first.reference.delete();
//       setState(() {
//         _isFavorite = false;
//       });
//     } else {
//       // Product not favorited, so add it
//       await favoritesCollection.add({
//         'uid': user.uid,
//         'productName': widget.data?['productName'],
//         'productNewPrice': widget.data?['productNewPrice'],
//         'image': widget.data?['image'],
//         // Add other product details here as needed
//       });
//       setState(() {
//         _isFavorite = true;
//       });
//     }
//   }
//
//
//   void addToCart() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       // User not authenticated
//       return;
//     }
//
//     // Reference to the carts collection
//     CollectionReference cartsCollection = FirebaseFirestore.instance.collection('carts');
//
//     // Add the product to the cart
//     await cartsCollection.add({
//       'uid': user.uid,
//       'productName': widget.data?['productName'],
//       'productNewPrice': widget.data?['productNewPrice'],
//       'quantity': _quantity,
//       'discount' :widget.data?['discount'],
//       'productTitle1' :widget.data?['productTitle1'],
//       'productTitleDetail1' :widget.data?['productDetail1'],
//       'productTitle2' :widget.data?['productTitle2'],
//       'productTitleDetail2' :widget.data?['productDetail2'],
//       'productTitle3' :widget.data?['productTitle3'],
//       'productTitleDetail3' :widget.data?['productDetail3'],
//       'productTitle4' :widget.data?['productTitle4'],
//       'productTitleDetail4' :widget.data?['productDetail4'],
//       'image': widget.data?['image'],
//       // Add other product details here as needed
//     });
//
//     // Optionally, you can show a snackbar or dialog to indicate that the product was added to the cart
//   }
//
// }




import 'dart:io';

import 'package:StyleHub/Seller/Products/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Users/Carts/cartModel.dart';
import '../../Users/Favorite/favoriteModel.dart';
import '../../homeScreens/homeScreen.dart';

class ProductDetailScreen extends StatefulWidget {
  final productModel products;

  const ProductDetailScreen({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedQuantity = 1;
  bool favorite = false;

  int activeIndex = 0;

  String? selectedColl;
  bool timer = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        timer = true;
      });
    });

    super.initState();
  }

  void addToCart() {
    FirebaseFirestore.instance.collection('carts').add({
      'User ID': FirebaseAuth.instance.currentUser!.uid,
      'uid': widget.products.id,
      'productName': widget.products.productName,
      'productNewPrice': widget.products.productNewPrice,
      'quantity': selectedQuantity,
      'totalPrice': widget.products.total,
      'productPrice': widget.products.productPrice,
      'ProductDiscount':widget.products.discount,
      'productColor': widget.products.productColor,
      'productDescription':widget.products.productDescription,
      'productDetail1': widget.products.productTitleDetail1,
      'productDetail2': widget.products.productTitleDetail2,
      'productDetail3': widget.products.productTitleDetail3,
      'productDetail4': widget.products.productTitleDetail4,
      'productTitle1': widget.products.productTitle1,
      'productTitle2': widget.products.productTitle2,
      'productTitle3': widget.products.productTitle3,
      'productTitle4': widget.products.productTitle4,
      'allDetails': widget.products.allDetails,

      // Add other product details as needed
    }).then((value) {
      // Handle success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully added to cart')),
      );
    }).catchError((error) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add to cart')),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return !timer
        ? Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.indigo,
          ),
        ))
        : Scaffold(
        appBar: AppBar(
          title: Text("${widget.products.subCategory.toString()} products"),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Visit the ${widget.products.subCategory} Store",
                    style: const TextStyle(color: Colors.cyan),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 10),
                child: Text(
                  widget.products.productName.toString(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 320),
                child: IconButton(
                    onPressed: () async {
                      final url = Uri.parse(widget.products.image!.last);
                      final response = await http.get(url);
                      final bytes = response.bodyBytes;

                      final temp = await getTemporaryDirectory();
                      final path = "${temp.path}/Images.jpg";
                      File(path).writeAsBytesSync(bytes);

                      await Share.shareFiles([path], text: 'buy this product now !!!');
                    },
                    icon: const Icon(Icons.share_outlined)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey[200],
                    ),
                    child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) => setState(() => activeIndex = index),
                      ),
                      itemCount: widget.products.image!.length,
                      itemBuilder: (context, index, realIndex) {
                        final allItems = widget.products.image![index];
                        return buildImage(allItems, index);
                      },
                    ),
                  ),
                  IconButton(
                      color: favorite ? Colors.pinkAccent : Colors.grey,
                      onPressed: () async {
                        setState(() {
                          favorite = !favorite;
                        });
                        if (favorite) {
                          await FirebaseFirestore.instance.collection('favorites').add({
                            'uid': FirebaseAuth.instance.currentUser!.uid,
                            'image': widget.products.image,
                            'productName': widget.products.productName,
                            'productNewPrice': widget.products.productNewPrice,
                            'productID': widget.products.id,
                            'productPrice': widget.products.productPrice,
                            'ProductDiscount':widget.products.discount,
                            'productColor': widget.products.productColor,
                            'productDescription':widget.products.productDescription,
                            'productDetail1': widget.products.productTitleDetail1,
                            'productDetail2': widget.products.productTitleDetail2,
                            'productDetail3': widget.products.productTitleDetail3,
                            'productDetail4': widget.products.productTitleDetail4,
                            'productTitle1': widget.products.productTitle1,
                            'productTitle2': widget.products.productTitle2,
                            'productTitle3': widget.products.productTitle3,
                            'productTitle4': widget.products.productTitle4,
                            'allDetails': widget.products.allDetails,
                            // Add other product details as needed
                          }).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Successfully added to favorites')),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to add to favorites')),
                            );
                          });


                          FavModel fav = FavModel(
                            UserID: FirebaseAuth.instance.currentUser!.uid,
                            id: widget.products.id,
                            productName: widget.products.productName,
                            productColor: widget.products.productColor,
                            productPrice: widget.products.productPrice,
                            productNewPrice: widget.products.productNewPrice,
                            discount: widget.products.discount.toString(),
                            productTitle1: widget.products.productTitle1,
                            productTitleDetail1: widget.products.productTitleDetail1,
                            productTitle2: widget.products.productTitle2,
                            productTitleDetail2: widget.products.productTitleDetail2,
                            productTitle3: widget.products.productTitle3,
                            productTitleDetail3: widget.products.productTitleDetail3,
                            productTitle4: widget.products.productTitle4,
                            productTitleDetail4: widget.products.productTitleDetail4,
                            productDescription: widget.products.productDescription,
                            subCategory: widget.products.subCategory,
                            category: widget.products.category,
                            images: widget.products.image,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Successfully added to favourite')),
                          );
                        } else {

    await FirebaseFirestore.instance.collection('favorites').where('userID', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('productID', isEqualTo: widget.products.id).get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove from favorites')),
      );
    });

                          FavModel fav = FavModel(
                            UserID: FirebaseAuth.instance.currentUser!.uid,
                            id: widget.products.id,
                            productName: widget.products.productName,
                            productColor: widget.products.productColor,
                            productPrice: widget.products.productPrice,
                            productNewPrice: widget.products.productNewPrice,
                            discount: widget.products.discount.toString(),
                            productTitle1: widget.products.productTitle1,
                            productTitleDetail1: widget.products.productTitleDetail1,
                            productTitle2: widget.products.productTitle2,
                            productTitleDetail2: widget.products.productTitleDetail2,
                            productTitle3: widget.products.productTitle3,
                            productTitleDetail3: widget.products.productTitleDetail3,
                            productTitle4: widget.products.productTitle4,
                            productTitleDetail4: widget.products.productTitleDetail4,
                            productDescription: widget.products.productDescription,
                            subCategory: widget.products.subCategory,
                            category: widget.products.category,
                            images: widget.products.image,
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Removed from favourite')),
                          );
                        }
                      },
                      icon: const Icon(Icons.favorite)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(child: buildIndicator()),
                  ),
                ],
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 1, left: 8),
                          child: Text(
                            "-${widget.products.discount}%",
                            style: TextStyle(fontSize: 25, color: Colors.red[900]),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: Text(
                            "\  ₹${widget.products.productNewPrice.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1, left: 8),
                      child: Text(
                        "M.R.P.: ₹${widget.products.productPrice.toString()}",
                        style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 8),
                      child: Text(
                        "In stock.",
                        style: TextStyle(fontSize: 20, color: Colors.green[900]),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Quantity:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        DropdownButton<int>(
                          value: selectedQuantity,
                          onChanged: (value) {
                            setState(() {
                              selectedQuantity = value!;
                            });
                          },
                          items: List.generate(10, (index) => index + 1)
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            print("quantity of product$selectedQuantity");
                            setState(() {});
                            cartModel mycart = cartModel(
                              quantity: selectedQuantity,
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              id: widget.products.id,
                              productName: widget.products.productName,
                              productColor: widget.products.productColor,
                              productPrice: widget.products.productPrice,
                              productNewPrice: widget.products.productNewPrice,
                              discount: widget.products.discount.toString(),
                              productTitle1: widget.products.productTitle1,
                              productTitleDetail1: widget.products.productTitleDetail1,
                              productTitle2: widget.products.productTitle2,
                              productTitleDetail2: widget.products.productTitleDetail2,
                              productTitle3: widget.products.productTitle3,
                              productTitleDetail3: widget.products.productTitleDetail3,
                              productTitle4: widget.products.productTitle4,
                              productTitleDetail4: widget.products.productTitleDetail4,
                              productDescription: widget.products.productDescription,
                              subCategory: widget.products.subCategory,
                              category: widget.products.category,
                              image: widget.products.image,
                              allDetails: widget.products.allDetails,
                              totalPrice: '',
                              subtotal: '',
                            );
                            await FirebaseFirestore.instance.collection('carts').add({
                              'uid': FirebaseAuth.instance.currentUser!.uid,
                              'image': widget.products.image,
                              'productName': widget.products.productName,
                              'productNewPrice': widget.products.productNewPrice,
                              'quantity': selectedQuantity,
                              'subtotal': widget.products.subtotal,
                              'totalPrice': widget.products.total,
                              // Add other product details as needed
                            }).then((value) {
                              // Handle success
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Successfully added to cart')),
                              );
                            }).catchError((error) {
                              // Handle errors
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Failed to add to cart')),
                              );
                            });
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationHome(),
                              ),
                                  (route) => false,
                            );
                            setState(() {});
                          },

                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Buy Now ",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10, left: 8),
                      child: Text(
                        "Details",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.products.productTitle1, style: const TextStyle(fontSize: 16)),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Model"),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Colour"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.products.productTitle2),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.products.productTitle3),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.products.productTitle4),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Description"),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.subCategory.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productName.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productColor.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productTitleDetail2.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productTitleDetail3.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productTitleDetail4.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.products.productDescription.toString(),
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 8),
                child: Text(
                  "About this item",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  widget.products.allDetails.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildImage(String allItems, int index) => Image.network(allItems, fit: BoxFit.contain);

  Widget buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.products.image!.length,
  );
}
