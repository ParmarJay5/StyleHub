// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class productModel {
//   String id;
//   String productName;
//   String productPrice;
//   String productColor;
//   String productDescription;
//   String productTitle1;
//   String productTitleDetail1;
//   String productTitle2;
//   String productTitleDetail2;
//   String productTitle3;
//   String productTitleDetail3;
//   String productTitle4;
//   String productTitleDetail4;
//   String allDetails;
//   String discount;
//   List<String> image;
//   String productNewPrice;
//   String total;
//   // String subtotal;
//   String quantity;
//   String? category;
//   String subCategory;
//
//   productModel({
//     required this.id,
//     required this.productName,
//     required this.productPrice,
//     required this.productColor,
//     required this.productDescription,
//     required this.productTitle1,
//     required this.productTitleDetail1,
//     required this.productTitle2,
//     required this.productTitleDetail2,
//     required this.productTitle3,
//     required this.productTitleDetail3,
//     required this.productTitle4,
//     required this.productTitleDetail4,
//     required this.allDetails,
//     required this.image,
//     required this.discount,
//     required this.productNewPrice,
//     required this.total,
//     required this.category,
//     required this.subCategory,
//     required this.quantity,
//   });
//
//   // Add a factory method to convert Firestore snapshot to ProductModel
//   factory productModel.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return productModel(
//       id: snapshot.id,
//       productName: data['productName'] ?? '',
//       productPrice: data['productPrice'] ?? '',
//       productColor: data['productColor'] ?? '',
//       productDescription: data['productDescription'] ?? '',
//       productTitle1: data['productTitle1'] ?? '',
//       productTitleDetail1: data['productDetail1'] ?? '',
//       productTitle2: data['productTitle2'] ?? '',
//       productTitleDetail2: data['productDetail2'] ?? '',
//       productTitle3: data['productTitle3'] ?? '',
//       productTitleDetail3: data['productDetail3'] ?? '',
//       productTitle4: data['productTitle4'] ?? '',
//       productTitleDetail4: data['productDetail4'] ?? '',
//       allDetails: data['allProduct'] ?? '',
//       image: List<String>.from(data['image'] ?? []),
//       discount: data['ProductDiscount'] ?? '',
//       productNewPrice: data['productNewPrice'] ?? '',
//       total: data['total'] ?? '',
//       category: data['Category'] ?? '',
//       subCategory: data['subCategory'] ?? '',
//       quantity: data['quantity'] ?? '',
//     );
//   }
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'productName': productName,
//       'image': image,
//       'productPrice': productPrice,
//       'productNewPrice': productNewPrice,
//       'productDescription': productDescription,
//       'ProductDiscount': discount,
//       'productTitle1': productTitle1,
//       'productTitle2': productTitle2,
//       'productTitle3': productTitle3,
//       'productTitle4': productTitle4,
//       'productDetail1': productTitleDetail1,
//       'productDetail2': productTitleDetail2,
//       'productDetail3': productTitleDetail3,
//       'productDetail4': productTitleDetail4,
//       'productColor': productColor,
//       'total': total,
//       'category': category,
//       'subCategory': subCategory,
//       'allProduct': allDetails,
//     };
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String sellerId;
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
  final String itemdetails;
  String selectedqty;
  String totalprice;



  ProductModel({
    required this.id,
    required this.sellerId,
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
    required this.totalprice,
    required this.itemdetails,



  });

  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot){
    Map<String,dynamic> data = snapshot.data() as Map<String,dynamic>;
    return ProductModel(
      id: snapshot.id,
      category: data['Category']?? '',
      brand: data['subCategory']?? '',
      images: List<String>.from(data['image'] ?? []),
      productName: data['productName'] ?? '',
      productPrice: data['productPrice'] ?? '',
      color: data['productColor'] ?? '',
      productDescription: data['productDescription'] ?? '',
      product1: data['productDetail1']?? '',
      product2: data['productDetail2']?? '',
      product3: data['productDetail3']?? '',
      product4: data['productDetail4']?? '',
      title1: data['productTitle1']?? '',
      title2: data['productTitle2']?? '',
      title3: data['productTitle3']?? '',
      title4: data['productTitle4']?? '',
      discount: data['ProductDiscount']?? '',
      newPrice: data['productNewPrice']?? '',
      selectedqty: data['quantity']?? '',
      totalprice: data['totalprice']?? '',
      itemdetails: data['allProduct']?? '',
      sellerId: data['sellerID'] ?? '',
    );
  }
}


