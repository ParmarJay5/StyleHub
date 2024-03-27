// // // import 'package:StyleHub/Seller/Products/productModel.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // import '../../Seller/Products/productModel.dart';
// // //
// // // class cartModel {
// // //   String id;
// // //   String uid;
// // //   String productName;
// // //   String productPrice;
// // //   String productColor;
// // //   String productDescription;
// // //   String productTitle1;
// // //   String productTitleDetail1;
// // //   String productTitle2;
// // //   String productTitleDetail2;
// // //   String productTitle3;
// // //   String productTitleDetail3;
// // //   String productTitle4;
// // //   String productTitleDetail4;
// // //   String allDetails;
// // //   String discount;
// // //   List<String> image;
// // //   String productNewPrice;
// // //   String? category;
// // //   String subCategory;
// // //   String Quantity;
// // //   String total;
// // //   String subTotal;
// // //
// // //   cartModel({
// // //     required this.id,
// // //     required this.uid,
// // //     required this.productName,
// // //     required this.productPrice,
// // //     required this.productColor,
// // //     required this.productDescription,
// // //     required this.productTitle1,
// // //     required this.productTitleDetail1,
// // //     required this.productTitle2,
// // //     required this.productTitleDetail2,
// // //     required this.productTitle3,
// // //     required this.productTitleDetail3,
// // //     required this.productTitle4,
// // //     required this.productTitleDetail4,
// // //     required this.allDetails,
// // //     required this.image,
// // //     required this.discount,
// // //     required this.productNewPrice,
// // //     required this.category,
// // //     required this.subCategory,
// // //     required this.Quantity,
// // //     required this.total,
// // //     required this.subTotal,
// // //   });
// // //
// // //
// // //   factory cartModel.fromSnapshot(DocumentSnapshot snapshot) {
// // //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
// // //     return cartModel(
// // //       id: snapshot.id,
// // //       uid: data['uid'] ?? '',
// // //       productName: data['productName'] ?? '',
// // //       productPrice: data['productPrice'] ?? '',
// // //       productColor: data['productColor'] ?? '',
// // //       productDescription: data['productDescription'] ?? '',
// // //       productTitle1: data['productTitle1'] ?? '',
// // //       productTitleDetail1: data['productDetail1'] ?? '',
// // //       productTitle2: data['productTitle2'] ?? '',
// // //       productTitleDetail2: data['productDetail2'] ?? '',
// // //       productTitle3: data['productTitle3'] ?? '',
// // //       productTitleDetail3: data['productDetail3'] ?? '',
// // //       productTitle4: data['productTitle4'] ?? '',
// // //       productTitleDetail4: data['productDetail4'] ?? '',
// // //       allDetails: data['allProduct'] ?? '',
// // //       image: List<String>.from(data['image'] ?? []),
// // //       discount: data['ProductDiscount'] ?? '',
// // //       productNewPrice: data['productNewPrice'] ?? '',
// // //       category: data['Category'] ?? '',
// // //       subCategory: data['subCategory'] ?? '',
// // //       Quantity: data['Quantity'] ?? '',
// // //       total: data['total'] ?? '',
// // //       subTotal: data['subTotal'] ?? '',
// // //
// // //     );
// // //   }
// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'id': id,
// // //       'uid': uid,
// // //       'productName': productName,
// // //       'image': image,
// // //       'productPrice': productPrice,
// // //       'productNewPrice': productNewPrice,
// // //       'productDescription': productDescription,
// // //       'ProductDiscount': discount,
// // //       'productTitle1' : productTitle1,
// // //       'productTitle2' : productTitle2,
// // //       'productTitle3' : productTitle3,
// // //       'productTitle4' : productTitle4,
// // //       'productDetail1' : productTitleDetail1,
// // //       'productDetail2' : productTitleDetail2,
// // //       'productDetail3' : productTitleDetail3,
// // //       'productDetail4' : productTitleDetail4,
// // //       'productColor' : productColor,
// // //       'Quantity' : Quantity,
// // //       'total' : total,
// // //       'subTotal' : subTotal,
// // //       'category' : category,
// // //       'subCategory': subCategory,
// // //       'allProduct' : allDetails,
// // //
// // //     };
// // //   }
// // // }
// // // class CartService {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   Future<List<cartModel>> fetchCartData(String userId) async {
// // //     try {
// // //       QuerySnapshot querySnapshot = await _firestore
// // //           .collection('carts')
// // //           .where('uid', isEqualTo: userId)
// // //           .get();
// // //
// // //       List<cartModel> cartList = querySnapshot.docs.map((doc) {
// // //         return cartModel.fromSnapshot(doc);
// // //       }).toList();
// // //
// // //       return cartList;
// // //     } catch (e) {
// // //       // Handle any errors here
// // //       print('Error fetching cart data: $e');
// // //       return [];
// // //     }
// // //   }
// // // }
// // //
// // //
// // //
// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // // Define the cartModel class
// // class cartModel {
// //   String id;
// //   String uid;
// //   String productName;
// //   String productPrice;
// //   String productColor;
// //   String productDescription;
// //   String productTitle1;
// //   String productTitleDetail1;
// //   String productTitle2;
// //   String productTitleDetail2;
// //   String productTitle3;
// //   String productTitleDetail3;
// //   String productTitle4;
// //   String productTitleDetail4;
// //   String allDetails;
// //   String discount;
// //   List<String> image;
// //   String productNewPrice;
// //   String? category;
// //   String subCategory;
// //   String Quantity;
// //   String total;
// //   String subTotal;
// //
// //   cartModel({
// //     required this.id,
// //     required this.uid,
// //     required this.productName,
// //     required this.productPrice,
// //     required this.productColor,
// //     required this.productDescription,
// //     required this.productTitle1,
// //     required this.productTitleDetail1,
// //     required this.productTitle2,
// //     required this.productTitleDetail2,
// //     required this.productTitle3,
// //     required this.productTitleDetail3,
// //     required this.productTitle4,
// //     required this.productTitleDetail4,
// //     required this.allDetails,
// //     required this.image,
// //     required this.discount,
// //     required this.productNewPrice,
// //     required this.category,
// //     required this.subCategory,
// //     required this.Quantity,
// //     required this.total,
// //     required this.subTotal,
// //   });
// //
// //   factory cartModel.fromSnapshot(DocumentSnapshot snapshot) {
// //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
// //     return cartModel(
// //       id: snapshot.id,
// //       uid: data['uid'] ?? '',
// //       productName: data['productName'] ?? '',
// //       productPrice: data['productPrice'] ?? '',
// //       productColor: data['productColor'] ?? '',
// //       productDescription: data['productDescription'] ?? '',
// //       productTitle1: data['productTitle1'] ?? '',
// //       productTitleDetail1: data['productDetail1'] ?? '',
// //       productTitle2: data['productTitle2'] ?? '',
// //       productTitleDetail2: data['productDetail2'] ?? '',
// //       productTitle3: data['productTitle3'] ?? '',
// //       productTitleDetail3: data['productDetail3'] ?? '',
// //       productTitle4: data['productTitle4'] ?? '',
// //       productTitleDetail4: data['productDetail4'] ?? '',
// //       allDetails: data['allProduct'] ?? '',
// //       image: List<String>.from(data['image'] ?? []),
// //       discount: data['ProductDiscount'] ?? '',
// //       productNewPrice: data['productNewPrice'] ?? '',
// //       category: data['Category'] ?? '',
// //       subCategory: data['subCategory'] ?? '',
// //       Quantity: data['Quantity'] ?? '',
// //       total: data['total'] ?? '',
// //       subTotal: data['subTotal'] ?? '',
// //     );
// //   }
// // }
// //
// // // Define the CartService class
// // class CartService {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   Future<List<cartModel>> fetchCartData(String userId) async {
// //     try {
// //       QuerySnapshot querySnapshot = await _firestore
// //           .collection('carts')
// //           .where('uid', isEqualTo: userId)
// //           .get();
// //
// //       List<cartModel> cartList = querySnapshot.docs.map((doc) {
// //         return cartModel.fromSnapshot(doc);
// //       }).toList();
// //
// //       return cartList;
// //     } catch (e) {
// //       // Handle any errors here
// //       print('Error fetching cart data: $e');
// //       return [];
// //     }
// //   }
// // }
//
// // my
// class cartModel {
//   String id;
//   String uid;
//   String? category;
//   String subCategory;
//   String productName;
//   String productPrice;
//   String productNewPrice;
//   String discount;
//   String productColor;
//   String productTitle1;
//   String productTitleDetail1;
//   String productTitle2;
//   String productTitleDetail2;
//   String productTitle3;
//   String productTitleDetail3;
//   String productTitle4;
//   String productTitleDetail4;
//   String allDetails;
//   String productDescription;
//   int quantity;
//   List<String> image;
//   String totalPrice;
//   String subtotal;
//
//   cartModel({
//     required this.id,
//     required this.uid,
//     required this.category,
//     required this.subCategory,
//     required this.productName,
//     required this.productPrice,
//     required this.productNewPrice,
//     required this.discount,
//     required this.productColor,
//     required this.productTitle1,
//     required this.productTitleDetail1,
//     required this.productTitle2,
//     required this.productTitleDetail2,
//     required this.productTitle3,
//     required this.productTitleDetail3,
//     required this.productTitle4,
//     required this.productTitleDetail4,
//     required this.allDetails,
//     required this.productDescription,
//     required this.quantity,
//     required this.image,
//     required this.totalPrice,
//     required this.subtotal,
//   });
//
//   factory cartModel.fromMap(Map<String, dynamic> data) {
//     return cartModel(
//       id: data['id'],
//       uid: data['uid'],
//       category: data['Category'],
//       subCategory: data['subCategory'],
//       productName: data['productName'],
//       productPrice: data['productPrice'],
//       productNewPrice: data['productNewPrice'],
//       discount: data['ProductDiscount'],
//       productColor: data['productColor'] ?? '',
//       productTitle1: data['productTitle1'] ?? '',
//       productTitleDetail1: data['productDetail1'] ?? '',
//       productTitle2: data['productTitle2'] ?? '',
//       productTitleDetail2: data['productDetail2'] ?? '',
//       productTitle3: data['productTitle3'] ?? '',
//       productTitleDetail3: data['productDetail3'] ?? '',
//       productTitle4: data['productTitle4'] ?? '',
//       productTitleDetail4: data['productDetail4'] ?? '',
//       allDetails: data['allProduct'] ?? '',
//       productDescription: data['productDescription'] ?? '',
//       quantity: data['quantity'] ?? '',
//       totalPrice: data['totalPrice'],
//       subtotal: data['subtotal'],
//       image: List<String>.from(data['image'] ?? []),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "productName": productName,
//         "productColor": productColor,
//         "productPrice": productPrice,
//         "productTitle1": productTitle1,
//         "productTitle2": productTitle2,
//         "productTitle3": productTitle3,
//         "productTitle4": productTitle4,
//         "subCategory": subCategory,
//         "Category": category,
//         "productTitleDetail1": productTitleDetail1,
//         "productTitleDetail2": productTitleDetail2,
//         "productTitleDetail3": productTitleDetail3,
//         "productTitleDetail4": productTitleDetail4,
//         "productDescription": productDescription,
//         "image": image,
//         "uid": uid,
//         "ProductDiscount": discount,
//         "productNewPrice": productNewPrice,
//         'totalPrice': totalPrice,
//         'subtotal': subtotal,
//         'quantity': quantity,
//       };
// }


// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  List<String>? images;
  final String category;
  final String brand;
  final String productName;
  final String productPrice;
  final String color;
  final String productDescription;
  final String product1;
  final String product2;
  final String product3;
  final String product4;
  final String title1;
  final String title2;
  final String title3;
  final String title4;
  final String discount;
  final String newPrice;
  String selectedqty;
  String userId;
  // final String imageUrls;



  CartModel({required this.id,
    required this.images,
    required this.category,
    required this.brand,
    required this.productName,
    required this.productPrice,
    required this.color,
    required this.productDescription,
    required this.product1,
    required this.product2,
    required this.product3,
    required this.product4,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
    required this.discount,
    required this.newPrice,
    required this.selectedqty,
    required this.userId,
    // required this.imageUrls


  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'images': images,
      'category': category,
      'brand': brand,
      'productName': productName,
      'productPrice': productPrice,
      'color': color,
      'productDescription': productDescription,
      'product1': product1,
      'product2': product2,
      'product3': product3,
      'product4': product4,
      'title1': title1,
      'title2': title2,
      'title3': title3,
      'title4': title4,
      'discount': discount,
      'newPrice': newPrice,
      'selectedqty': selectedqty,
      'userId': userId,
    };
  }

  factory CartModel.fromSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
    return CartModel(
      id: snapshot.id,
      category: data['category']?? '',
      brand: data['brand']?? '',
      images: List<String>.from(data['images'] ?? []),
      productName: data['productName'] ?? '',
      productPrice: data['productPrice'] ?? '',
      color: data['productColor'] ?? '',
      productDescription: data['productDescription'] ?? '',
      product1: data['productTitleDetail1']?? '',
      product2: data['productTitleDetail2']?? '',
      product3: data['productTitleDetail3']?? '',
      product4: data['productTitleDetail4']?? '',
      title1: data['productTitle1']?? '',
      title2: data['productTitle2']?? '',
      title3: data['productTitle3']?? '',
      title4: data['productTitle4']?? '',
      discount: data['discount']?? '',
      newPrice: data['productNewPrice']?? '',
      selectedqty: data['quantity']?? '',
      userId: data['UID']?? '',
      // imageUrls: data['images']?? '',


    );
  }
}