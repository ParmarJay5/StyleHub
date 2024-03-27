// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../Users/OrderTracking seller/OrderTrackingScreen.dart';
// //
// // class SellerOrderScreen extends StatefulWidget {
// //   const SellerOrderScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<SellerOrderScreen> createState() => _SellerOrderScreenState();
// // }
// //
// // class _SellerOrderScreenState extends State<SellerOrderScreen> {
// //   late Stream<QuerySnapshot> _ordersStream;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('All Orders'),
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: _ordersStream,
// //         builder: (context, snapshot) {
// //           if (!snapshot.hasData || snapshot.data == null) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           if (snapshot.data!.docs.isEmpty) {
// //             return const Center(
// //               child: Text("No orders available."),
// //             );
// //           }
// //           return ListView.builder(
// //             itemCount: snapshot.data!.docs.length,
// //             itemBuilder: (context, index) {
// //               var orderData =
// //                   snapshot.data!.docs[index].data() as Map<String, dynamic>;
// //               return Card(
// //                 child: ListTile(
// //                   title: Text("Order ID: ${snapshot.data!.docs[index].id}"),
// //                   subtitle: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text("Product: ${orderData['productName']}"),
// //                       Text("Quantity: ${orderData['quantity']}"),
// //                       // Add more details if needed
// //                     ],
// //                   ),
// //                   trailing: IconButton(
// //                     icon: const Icon(Icons.track_changes),
// //                     onPressed: () {
// //                       // Navigator.push(
// //                       //   context,
// //                       //   MaterialPageRoute(
// //                       //     builder: (context) => OrderTrackingScreen(
// //                       //         orderId: snapshot.data!.docs[index].id),
// //                       //   ),
// //                       // );
// //                     },
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:StyleHub/Users/Favorite/Order/orderModel.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class OrdersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Orders'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('orders').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('Error: Unable to fetch data.'),
//             );
//           }
//           // If there are no errors and data is retrieved successfully
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               DocumentSnapshot document = snapshot.data!.docs[index];
//               orderModel order = orderModel.fromFirestore(document);
//               return _buildOrderCard(context, order); // Custom method to build the UI for each order
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildOrderCard(BuildContext context, orderModel order) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Text(
//               // 'Order ID: ${order.orderId}',
//               // style: const TextStyle(fontWeight: FontWeight.bold),
//             // ),
//             const SizedBox(height: 8.0),
//             Text('Item Wanted: ${order.productName}'),
//             // Text('Email: ${order.email}'),
//             // Text('Address: ${order.adress}'),
//             // Text('Phone Number: ${order.phoneNumber}'),
//             Text('Payment Method: ${order.paymentMethod}'),
//             const SizedBox(height: 8.0),
//             // DropdownButton<String>(
//             //   value: order.status,
//             //   onChanged: (newValue) {
//             //     print('Selected Status: $newValue');
//             //     _updateOrderStatus(context, order, newValue!);
//             //   },
//             //   items: <String>[
//             //     'Order Confirmed',
//             //     'Shipped',
//             //     'Out for Delivery',
//             //     'Delivered',
//             //   ].map<DropdownMenuItem<String>>((String value) {
//             //     return DropdownMenuItem<String>(
//             //       value: value,
//             //       child: Text(value),
//             //     );
//             //   }).toList(),
//             // ),
//             DropdownButton<String>(
//               value: order.status ?? '', // Use a default value if order.status is null
//               onChanged: (newValue) {
//                 print('Selected Status: $newValue');
//                 _updateOrderStatus(context, order, newValue!);
//               },
//               items: <String>[
//                 'Order Confirmed',
//                 'Shipped',
//                 'Out for Delivery',
//                 'Delivered',
//               ].map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toSet().toList(), // Use Set to remove duplicates and then convert back to List
//             ),
//
//
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _updateOrderStatus(BuildContext context, orderModel order, String newStatus) async {
//     try {
//       await FirebaseFirestore.instance.collection('orders').doc(order.orderId).update({
//         'status': newStatus,
//       });
//       // Refresh the UI if needed
//     } catch (error) {
//       print('Error updating status: $error');
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Failed to update order status.'),
//       ));
//     }
//   }
// }
//
// class DropdownItem {
//   final String value;
//   final String label;
//
//   DropdownItem(this.value, this.label);
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderListScreenSeller extends StatefulWidget {
  @override
  OrderListScreenSellerState createState() => OrderListScreenSellerState();
}

class OrderListScreenSellerState extends State<OrderListScreenSeller> {
  late Stream<QuerySnapshot> _ordersStream;

  @override
  void initState() {
    super.initState();
    _ordersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  }

  void _updateOrderStatus(String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
        'status': newStatus,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order $orderId status updated to $newStatus'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print('Error updating order status: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update order status. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No orders available."),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderId = snapshot.data!.docs[index].id;
              var orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              var status = orderData['status'] ?? 'Pending';

              return Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID: $orderId",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Status: $status",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 8),
                    Divider(color: Colors.grey),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _updateOrderStatus(orderId, newValue);
                            }
                          },
                          value: status,
                          items: <String>[
                            'Pending',
                            'Ordered Confirmed',
                            'Shipped',
                            'Out For Delivery',
                            'Delivered',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        // Additional buttons or widgets can be added here
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
