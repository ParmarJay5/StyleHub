import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:StyleHub/Users/Favorite/Order/orderModel.dart'; // Import your order model if needed


import '../../OrderTracking seller/OrderTrackingScreen.dart';
import 'OrderTrackingScreen.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No orders available."),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text("Order ID: ${snapshot.data!.docs[index].id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product: ${orderData['productName']}"),
                      Text("Quantity: ${orderData['quantity']}"),
                      Text("Payment Method: ${orderData['paymentMethod']}"),
                      Text("Delivery Status: ${orderData['status']}"),
                      Text("Time: ${orderData['time']}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.track_changes),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => TrackOrder(orderId: snapshot.data!.docs[index].id),
                      //   ),
                      // );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
