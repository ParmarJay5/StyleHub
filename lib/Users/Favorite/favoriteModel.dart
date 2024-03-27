// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class Fav {
// //   final String? ;
// //   final String? productdiscprice;
// //   final List<String>? image;
// //   final String? brand;
// //   final String? category;
// //   final String? description;
// //   final String? memory;
// //   final String? op;
// //   final String? UserID;
// //   final String? origprice;
// //   final String? discount;
// //
// //   final String? uid;
// //   Fav(
// //       {
// //         this.name,
// //         this.UserID,
// //         this.productdiscprice,
// //         this.image,
// //         this.brand,
// //         this.category,
// //         this.memory,
// //         this.op,
// //         this.discount,
// //         this.origprice,
// //         this.description, this.uid,});
// //
// //   factory Fav.fromJson(DocumentSnapshot json) => Fav(
// //
// //     discount: json['discount'],
// //     origprice: json['origprice'],
// //     UserID: json['UserID'],
// //     uid: json['uid'],
// //     name: json['name'],
// //     productdiscprice: json['price'],
// //     brand: json['brand'],
// //     category: json['category'],
// //     description: json['description'],
// //     memory: json['memory'],
// //     op: json['op'],
// //     image: List<String>.from(json['imageUrl']),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "origprice": origprice,
// //     "discount": discount,
// //     "UserID": UserID,
// //     "uid": uid,
// //     "name": name,
// //     "price": productdiscprice,
// //     "imageUrl": image,
// //     "brand": brand,
// //     "category": category,
// //     "memory": memory,
// //     "op": op,
// //     "description": description,
// //
// //   };
// // }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FavModel {
//   final String id; // Add the id field
//   final List<String>? images; //
//   final String? category;
//   final String subCategory;
//   final String productColor;
//   final String productPrice;
//   final String productName;
//   final String productTitle1;
//   final String productTitleDetail1;
//   final String productTitle2;
//   final String productTitleDetail2;
//   final String productTitle3;
//   final String productTitleDetail3;
//   final String productTitle4;
//   final String productTitleDetail4;
//   final String productDescription;
//   final String UserID;
//   final String discount;
//   final String productNewPrice;
//
//   FavModel({
//     required this.id,
//     required this.category,
//     required this.images,
//     required this.subCategory,
//     required this.productColor,
//     required this.productPrice,
//     required this.productName,
//     required this.productTitle1,
//     required this.productTitleDetail1,
//     required this.productTitle2,
//     required this.productTitleDetail2,
//     required this.productTitle3,
//     required this.productTitleDetail3,
//     required this.productTitle4,
//     required this.productTitleDetail4,
//     required this.productDescription,
//     required this.UserID,
//     required this.discount,
//     required this.productNewPrice,
//   });
//
//   factory FavModel.fromJson(DocumentSnapshot json) {
//     return FavModel(
//       id: json.id, // Assign the document ID to the id field
//       category: json['Category'],
//       subCategory: json['subCategory'],
//       images: List<String>.from(json['image']),
//       productColor: json['productColor'],
//       productPrice: json['productPrice'],
//       productName: json['productName'],
//       productTitle1: json['productTitle1'],
//       productTitleDetail1: json['productTitleDetail1'],
//       productTitle2: json['productTitle2'],
//       productTitleDetail2: json['productTitleDetail2'],
//       productTitle3: json['productTitle3'],
//       productTitleDetail3: json['productTitleDetail3'],
//       productTitle4: json['productTitle4'],
//       productTitleDetail4: json['productTitleDetail4'],
//       productDescription: json['productDescription'],
//       UserID: json['uid'],
//       discount: json['ProductDiscount'],
//       productNewPrice: json['productNewPrice'],
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
//         "image": images,
//         "uid": UserID,
//         "ProductDiscount": discount,
//         "productNewPrice": productNewPrice,
//       };
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class FavModel {
  final String id;
  List<String>? images;
  final String productName;
  final String newPrice;
  String selectedqty;

  FavModel({required this.id,
    required this.images,
    required this.productName,
    required this.newPrice,
    required this.selectedqty,
  });

  factory FavModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return FavModel(
      id: snapshot.id,
      images: List<String>.from(data['image'] ?? []),
      productName: data['productName'] ?? '',
      newPrice: data['productNewPrice']?? '',
      selectedqty: data['quantity']?? '',
    );
  }
}
