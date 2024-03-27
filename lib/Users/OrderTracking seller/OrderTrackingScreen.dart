// // import 'package:StyleHub/Users/Favorite/Order/orderModel.dart';
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:intl/intl.dart';
// //
// // class OrderTrackingScreen extends StatefulWidget {
// //   final orderModel orderId;
// //
// //   const OrderTrackingScreen({super.key, required this.orderId});
// //   @override
// //   _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
// // }
// //
// // class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
// //   late String _selectedStatus;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _selectedStatus = ''; // Initialize selected status
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Order Tracking'),
// //       ),
// //       body: FutureBuilder<DocumentSnapshot>(
// //         future: FirebaseFirestore.instance
// //             .collection('orders')
// //             .doc(widget.orderId)
// //             .get(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           }
// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text('Error: ${snapshot.error}'),
// //             );
// //           }
// //           if (!snapshot.hasData || snapshot.data == null) {
// //             return const Center(
// //               child: Text('No data found'),
// //             );
// //           }
// //
// //           var orderData =
// //               snapshot.data!.data() as Map<String, dynamic>?; // Nullable map
// //           if (orderData == null) {
// //             return const Center(
// //               child: Text('No data found'),
// //             );
// //           }
// //
// //           // Build dropdown list for order status
// //           var statusList = [
// //             'Ordered',
// //             'Shipped',
// //             'Out for Delivery',
// //             'Delivered'
// //           ];
// //           var dropdownItems = statusList.map((status) {
// //             return DropdownMenuItem<String>(
// //               value: status,
// //               child: Text(status),
// //             );
// //           }).toList();
// //
// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Order #${snapshot.data!.id}',
// //                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 Text(
// //                   'Order Date: ${_formatOrderDate(orderData['orderDate'] as Timestamp?)}',
// //                   style: const TextStyle(fontSize: 16),
// //                 ),
// //                 const SizedBox(height: 10),
// //                 Text(
// //                   'Ordered Day: ${_getOrderedDay(orderData['orderDate'] as Timestamp?)}',
// //                   style: const TextStyle(fontSize: 16),
// //                 ),
// //                 const SizedBox(height: 20),
// //                 // Dropdown list for order status
// //                 DropdownButtonFormField<String>(
// //                   value: _selectedStatus,
// //                   hint: const Text('Select Order Status'),
// //                   items: dropdownItems,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       _selectedStatus = value!;
// //                       _updateOrderStatus(value); // Call method to update status
// //                     });
// //                   },
// //                 ),
// //                 const SizedBox(height: 20),
// //                 _buildOrderItems(orderData),
// //                 const SizedBox(height: 20),
// //                 _buildTrackingInfo(orderData),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   String _formatOrderDate(Timestamp? orderDate) {
// //     if (orderDate == null) {
// //       return '';
// //     }
// //     var dateTime = orderDate.toDate();
// //     var formatter = DateFormat.yMMMd();
// //     return formatter.format(dateTime);
// //   }
// //
// //   String _getOrderedDay(Timestamp? orderDate) {
// //     if (orderDate == null) {
// //       return '';
// //     }
// //     var dateTime = orderDate.toDate();
// //     var formatter = DateFormat('EEEE');
// //     return formatter.format(dateTime);
// //   }
// //
// //   Widget _buildOrderItems(Map<String, dynamic> orderData) {
// //     var orderItems = orderData['items'] as List<dynamic>?; // Nullable list
// //     if (orderItems == null || orderItems.isEmpty) {
// //       return const SizedBox.shrink();
// //     }
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Order Details:',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         const SizedBox(height: 10),
// //         for (var item in orderItems) ...[
// //           _buildOrderItem(
// //             item['productName'] ?? '',
// //             'Quantity: ${item['quantity'] ?? ''}',
// //             'Price: \$${item['ProductNewPrice'] ?? ''}',
// //             'Ordered Date: ${_formatOrderDate(orderData['orderDate'] as Timestamp?)}',
// //             'Ordered Day: ${_getOrderedDay(orderData['orderDate'] as Timestamp?)}',
// //           ),
// //         ],
// //       ],
// //     );
// //   }
// //
// //   Widget _buildOrderItem(String productName, String quantity, String price,
// //       String orderedDate, String orderedDay) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           productName,
// //           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //         ),
// //         const SizedBox(height: 5),
// //         Text(quantity),
// //         Text(price),
// //         Text(orderedDate),
// //         Text(orderedDay),
// //         const Divider(),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildTrackingInfo(Map<String, dynamic> orderData) {
// //     var trackingInfo = orderData['tracking'] as List<dynamic>?; // Nullable list
// //     if (trackingInfo == null || trackingInfo.isEmpty) {
// //       return const SizedBox.shrink();
// //     }
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Tracking Information:',
// //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //         const SizedBox(height: 10),
// //         for (var status in trackingInfo) ...[
// //           _buildTrackingItem(
// //             status['status'] ?? '',
// //             status['date'] ?? '',
// //           ),
// //         ],
// //       ],
// //     );
// //   }
// //
// //   Widget _buildTrackingItem(String status, String date) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Row(
// //           children: [
// //             const Icon(
// //               Icons.check_circle,
// //               color: Colors.green,
// //             ),
// //             const SizedBox(width: 10),
// //             Text(
// //               status,
// //               style: const TextStyle(fontSize: 16),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 5),
// //         Text(date),
// //         const Divider(),
// //       ],
// //     );
// //   }
// //
// //   // Method to update order status
// //   void _updateOrderStatus(String newStatus) async {
// //     try {
// //       await FirebaseFirestore.instance
// //           .collection('orders')
// //           .doc(widget.orderId)
// //           .update({
// //         'status': newStatus,
// //       });
// //     } catch (error) {
// //       print('Error updating order status: $error');
// //     }
// //   }
// // }
//
// //
// // import 'package:StyleHub/Users/Favorite/Order/orderModel.dart';
// // import 'package:flutter/material.dart';
// // import 'package:im_stepper/stepper.dart';
// // import 'package:jiffy/jiffy.dart';
// //
// // class TrackOrder extends StatefulWidget {
// //   final orderModel? userOrder;
// //   final StatusChangedCallback? onStatusChanged;
// //
// //   TrackOrder({this.userOrder, this.onStatusChanged});
// //
// //   @override
// //   _TrackOrderState createState() => _TrackOrderState();
// // }
// //
// // class _TrackOrderState extends State<TrackOrder> {
// //   int? activeStep;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     setActiveStep(widget.userOrder?.status ?? "");
// //   }
// //
// //   void setActiveStep(String status) {
// //     setState(() {
// //       switch (status) {
// //         case "Order Confirmed":
// //           activeStep = 0;
// //           break;
// //         case "Shipped":
// //           activeStep = 1;
// //           break;
// //         case "Out for Delivery":
// //           activeStep = 2;
// //           break;
// //         case "Delivered":
// //           activeStep = 3;
// //           break;
// //         default:
// //           activeStep = 0;
// //       }
// //     });
// //   }
// //
// //   List<TrackOrderList> trackOrderList = [
// //     TrackOrderList(
// //       title: "Order Confirmed",
// //       subtitle: "Your Order has been placed",
// //     ),
// //     TrackOrderList(
// //       title: "Shipped",
// //       subtitle: "Your Item has been shipped",
// //     ),
// //     TrackOrderList(
// //       title: "Out For Delivery",
// //       subtitle: "Your Order out for delivery",
// //     ),
// //     TrackOrderList(
// //       title: "Delivered",
// //       subtitle: "Your Order has been delivered",
// //     ),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[400],
// //       appBar: AppBar(
// //         title: const Text("Track Order"),
// //         backgroundColor: Colors.grey[400],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Text(
// //                 Jiffy().format("dd/MM/yyyy"),
// //                 style: TextStyle(
// //                   fontSize: 18.0,
// //                   color: Colors.black.withOpacity(0.5),
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //               child: Text(
// //                 "Order ID : ${widget.userOrder?.orderId}",
// //                 style: TextStyle(
// //                   fontSize: 18.0,
// //                   color: Colors.black.withOpacity(0.5),
// //                 ),
// //               ),
// //             ),
// //             const Padding(
// //               padding: EdgeInsets.only(
// //                 left: 16.0,
// //                 right: 16.0,
// //                 top: 16.0,
// //               ),
// //               child: Text(
// //                 "Orders",
// //                 style: TextStyle(
// //                   fontSize: 22.0,
// //                 ),
// //               ),
// //             ),
// //             Row(
// //               children: [
// //                 SizedBox(
// //                   height: MediaQuery.of(context).size.height / 1.8,
// //                   width: MediaQuery.of(context).size.width / 6,
// //                   child: IconStepper(
// //                     direction: Axis.vertical,
// //                     enableNextPreviousButtons: false,
// //                     enableStepTapping: false,
// //                     stepColor: Colors.grey,
// //                     activeStep: activeStep!.toInt(),
// //                     activeStepColor: Colors.green,
// //                     stepReachedAnimationDuration: const Duration(seconds: 2),
// //                     activeStepBorderColor: Colors.white,
// //                     activeStepBorderWidth: 0.0,
// //                     activeStepBorderPadding: 0.0,
// //                     previousButtonIcon: const Icon(Icons.arrow_back),
// //                     lineColor: Colors.green,
// //                     scrollingDisabled: true,
// //                     lineLength: 70.0,
// //                     lineDotRadius: 2.0,
// //                     stepRadius: 16.0,
// //                     icons: const [
// //                       Icon(Icons.radio_button_checked, color: Colors.green),
// //                       Icon(Icons.check, color: Colors.white),
// //                       Icon(Icons.check, color: Colors.white),
// //                       Icon(Icons.check, color: Colors.white),
// //                     ],
// //                   ),
// //                 ),
// //                 Expanded(
// //                   child: ListView.builder(
// //                     shrinkWrap: true,
// //                     padding: EdgeInsets.zero,
// //                     itemCount: trackOrderList.length,
// //                     itemBuilder: (context, index) {
// //                       return Row(
// //                         children: [
// //                           SizedBox(
// //                             width: MediaQuery.of(context).size.width / 1.5,
// //                             child: ListTile(
// //                               contentPadding:
// //                               const EdgeInsets.symmetric(vertical: 16.0),
// //                               title: Text(
// //                                 trackOrderList[index].title.toString(),
// //                                 style: const TextStyle(fontSize: 18.0),
// //                               ),
// //                               subtitle: Text(
// //                                 trackOrderList[index].subtitle.toString(),
// //                                 style: const TextStyle(fontSize: 16.0),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 16.0),
// //               padding: const EdgeInsets.only(
// //                   left: 24.0, top: 16.0, bottom: 16.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.grey[200],
// //                 border: Border.all(
// //                   width: 0.5,
// //                   color: Colors.black.withOpacity(0.5),
// //                 ),
// //                 borderRadius: BorderRadius.circular(8.0),
// //               ),
// //               child: Row(
// //                 children: [
// //                   Icon(Icons.home, size: 64.0, color: Colors.indigo[900]),
// //                   const SizedBox(width: 32.0),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "Delivery Address",
// //                         style: TextStyle(fontSize: 20.0),
// //                       ),
// //                       Text(
// //                         "Home, Work &\n Other Address",
// //                         style: TextStyle(
// //                           fontSize: 15.0,
// //                           color: Colors.black.withOpacity(0.7),
// //                         ),
// //                       ),
// //                       // SizedBox(
// //                       //   width: MediaQuery.of(context).size.width / 1.8,
// //                       //   child: Text(
// //                       //     widget.userOrder!.!,
// //                       //     style: TextStyle(
// //                       //       fontSize: 15.0,
// //                       //       color: Colors.black.withOpacity(0.7),
// //                       //     ),
// //                       //   ),
// //                       // ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class TrackOrderList {
// //   final String title;
// //   final String subtitle;
// //
// //   TrackOrderList({required this.title, required this.subtitle});
// // }
// //
// // // Define a callback function type
// // typedef StatusChangedCallback = void Function(String newStatus);
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:im_stepper/stepper.dart';
// import 'package:jiffy/jiffy.dart';
//
// import '../Favorite/Order/orderModel.dart';
//
// class TrackOrderUser extends StatefulWidget {
//   final orderModel? userOrder;
//
//   TrackOrderUser({this.userOrder});
//
//   @override
//   TrackOrderUserState createState() => TrackOrderUserState();
// }
//
// class TrackOrderUserState extends State<TrackOrderUser> {
//   int activeStep = 0;
//   String? deliveryAddress;
//   String? status;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDeliveryAddress();
//     fetchOrderStatus();
//   }
//
//   List<TrackOrderList> trackOrderList = [
//     TrackOrderList(
//       title: "Order Confirmed",
//       subtitle: "Your Order has been placed",
//     ),
//     TrackOrderList(
//       title: "Shipped",
//       subtitle: "Your Item has been shipped",
//     ),
//     TrackOrderList(
//       title: "Out For Delivery",
//       subtitle: "Your Order out for delivery",
//     ),
//     TrackOrderList(
//       title: "Delivered",
//       subtitle: "Your Order has been delivered",
//     ),
//   ];
//
//   void fetchDeliveryAddress() async {
//     try {
//       var addressSnapshot = await FirebaseFirestore.instance
//           .collection('Users')
//           .doc(widget.userOrder?.uid)
//           .collection('Address')
//           .get();
//
//       if (addressSnapshot.docs.isNotEmpty) {
//         var addressData =
//         addressSnapshot.docs.first.data() as Map<String, dynamic>;
//         setState(() {
//           deliveryAddress = addressData['address'];
//         });
//       } else {
//         print('No address documents found');
//       }
//     } catch (error) {
//       print('Error fetching delivery address: $error');
//     }
//   }
//
//   void fetchOrderStatus() async {
//     try {
//       var orderDoc = await FirebaseFirestore.instance
//           .collection('orders')
//           .doc(widget.userOrder?.orderId)
//           .get();
//
//       if (orderDoc.exists) {
//         var orderData = orderDoc.data();
//         setState(() {
//           status = orderData?['status'];
//           setActiveStep(status ?? '');
//         });
//       } else {
//         print('Order document not found');
//       }
//     } catch (error) {
//       print('Error fetching order status: $error');
//     }
//   }
//
//   void setActiveStep(String status) {
//     setState(() {
//       switch (status) {
//         case "Order Confirmed":
//           activeStep = 0;
//           break;
//         case "Shipped":
//           activeStep = 1;
//           break;
//         case "Out for Delivery":
//           activeStep = 2;
//           break;
//         case "Delivered":
//           activeStep = 3;
//           break;
//         default:
//           activeStep = 0;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[400],
//       appBar: AppBar(
//         title: const Text("Track Order"),
//         backgroundColor: Colors.grey[400],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 Jiffy().format("dd/MM/yyyy"),
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 "Order ID : ${widget.userOrder?.orderId}",
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.only(
//                 left: 16.0,
//                 right: 16.0,
//                 top: 16.0,
//               ),
//               child: Text(
//                 "Orders",
//                 style: TextStyle(
//                   fontSize: 22.0,
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 1.8,
//                   width: MediaQuery.of(context).size.width / 6,
//                   child: IconStepper(
//                     direction: Axis.vertical,
//                     enableNextPreviousButtons: false,
//                     enableStepTapping: false,
//                     stepColor: Colors.grey,
//                     activeStep: activeStep.toInt(),
//                     activeStepColor: Colors.green,
//                     stepReachedAnimationDuration: const Duration(seconds: 2),
//                     activeStepBorderColor: Colors.white,
//                     activeStepBorderWidth: 0.0,
//                     activeStepBorderPadding: 0.0,
//                     previousButtonIcon: const Icon(Icons.arrow_back),
//                     lineColor: Colors.green,
//                     scrollingDisabled: true,
//                     lineLength: 70.0,
//                     lineDotRadius: 2.0,
//                     stepRadius: 16.0,
//                     icons: const [
//                       Icon(Icons.radio_button_checked, color: Colors.green),
//                       Icon(Icons.check, color: Colors.white),
//                       Icon(Icons.check, color: Colors.white),
//                       Icon(Icons.check, color: Colors.white),
//                     ],
//                   ),
//
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.zero,
//                     itemCount: trackOrderList.length,
//                     itemBuilder: (context, index) {
//                       return Row(
//                         children: [
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 1.5,
//                             child: ListTile(
//                               contentPadding:
//                               const EdgeInsets.symmetric(vertical: 16.0),
//                               title: Text(
//                                 trackOrderList[index].title.toString(),
//                                 style: const TextStyle(fontSize: 18.0),
//                               ),
//                               subtitle: Text(
//                                 trackOrderList[index].subtitle.toString(),
//                                 style: const TextStyle(fontSize: 16.0),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             // Container for Delivery Address
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               padding:
//               const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 border: Border.all(
//                   width: 0.5,
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.home, size: 64.0, color: Colors.indigo[900]),
//                   const SizedBox(width: 32.0),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Delivery Address",
//                           style: TextStyle(fontSize: 20.0),
//                         ),
//                         Text(
//                           deliveryAddress ?? 'Loading...', // Handle null state
//                           style: TextStyle(
//                             fontSize: 15.0,
//                             color: Colors.black.withOpacity(0.7),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TrackOrderList {
//   final String title;
//   final String subtitle;
//
//   TrackOrderList({required this.title, required this.subtitle});
// }
