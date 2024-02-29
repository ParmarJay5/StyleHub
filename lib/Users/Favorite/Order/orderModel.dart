import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class orderModel {
final String uid;
final String orderId;
final String productName;
final String image;
final String paymentMethod;
final String status;
final double totalPrice;

orderModel({
  required this.uid,
  required this.orderId,
  required this.productName,
  required this.image,
  required this.paymentMethod,
  required this.status,
  required this.totalPrice,
});
Map<String, dynamic> toMap() {
  return {
    'uid': uid,
    'orderId': orderId,
    'productName': productName,
    'image': image,
    'paymentMethod': paymentMethod,
    'status': status,
    'totalPrice': totalPrice,
  };
}
factory orderModel.fromFirestore(DocumentSnapshot doc) {
  Map data = doc.data() as Map<String, dynamic>;
  return orderModel(
    uid: data['uid'],
    productName: data['productName'],
    orderId: data['orderID'],
    totalPrice: data['totalPrice'],
    image: data['image'],
    paymentMethod: data['paymentMethod'],
    status: data['status'],
  );
}
}
