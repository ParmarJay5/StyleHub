
import 'package:cloud_firestore/cloud_firestore.dart';

class orderModel {
  final String uid;
  final String orderId;
  final String productName;

  // final String image;
  final String paymentMethod;
  final String status;
  final double totalPrice;

  orderModel({
    required this.uid,
    required this.orderId,
    required this.productName,
    // required this.image,
    required this.paymentMethod,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'orderId': orderId,
      'productName': productName,
      // 'image': image,
      'paymentMethod': paymentMethod,
      'status': status,
      'totalprice': totalPrice,
    };
  }

//   factory orderModel.fromFirestore(DocumentSnapshot doc) {
//     Map data = doc.data() as Map<String, dynamic>;
//     return orderModel(
//       uid: data['uid'],
//       productName: data['productName'],
//       orderId: data['orderID'],
//       totalPrice: data['totalprice'],
//       // image: data['image'],
//       paymentMethod: data['paymentMethod'],
//       status: data['status'],
//     );
//   }
// }
  factory orderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw StateError('Document data was null');
    }

    return orderModel(
      uid: data['uid'] ?? '',
      productName: data['productName'] ?? '',
      orderId: data['orderId'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      paymentMethod: data['paymentMethod'] ?? '',
      status: data['status'] ?? '',
    );
  }
}