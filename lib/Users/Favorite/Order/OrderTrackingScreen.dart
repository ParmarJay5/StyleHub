// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// class UserOrderTrackingScreen extends StatefulWidget {
//   final String orderId;
//
//   UserOrderTrackingScreen({required this.orderId});
//
//   @override
//   _UserOrderTrackingScreenState createState() => _UserOrderTrackingScreenState();
// }
//
// class _UserOrderTrackingScreenState extends State<UserOrderTrackingScreen> {
//   late String _selectedStatus;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedStatus = ''; // Initialize selected status
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Tracking'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: FirebaseFirestore.instance.collection('orders').doc(widget.orderId).get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return Center(
//               child: Text('No data found'),
//             );
//           }
//
//           var orderData = snapshot.data!.data() as Map<String, dynamic>?; // Nullable map
//           if (orderData == null) {
//             return Center(
//               child: Text('No data found'),
//             );
//           }
//
//           // Build status names column
//           var statusList = ['Ordered', 'Shipped', 'Out for Delivery', 'Delivered'];
//           var statusWidgets = statusList.map((status) {
//             return ListTile(
//               title: Text(status),
//               onTap: () {
//                 setState(() {
//                   _selectedStatus = status;
//                   _updateOrderStatus(status); // Call method to update status
//                 });
//               },
//             );
//           }).toList();
//
//           // Build button with color based on selected status
//           Color buttonColor = _selectedStatus == 'Delivered' ? Colors.green : Colors.grey;
//           Widget buttonWidget = ElevatedButton(
//             onPressed: () {},
//             child: Text('Update Status'),
//             style: ElevatedButton.styleFrom(primary: buttonColor),
//           );
//
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Order #${snapshot.data!.id}',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 // Status names column
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: statusWidgets,
//                 ),
//                 SizedBox(height: 20),
//                 // Button with color based on selected status
//                 buttonWidget,
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Method to update order status
//   void _updateOrderStatus(String newStatus) async {
//     try {
//       await FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
//         'status': newStatus,
//       });
//     } catch (error) {
//       print('Error updating order status: $error');
//     }
//   }
// }

import 'package:StyleHub/Users/Favorite/Order/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:jiffy/jiffy.dart';

class TrackOrder extends StatefulWidget {
  final orderModel? userOrder;
  final StatusChangedCallback? onStatusChanged;

  TrackOrder({this.userOrder, this.onStatusChanged});

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int? activeStep;

  @override
  void initState() {
    super.initState();
    setActiveStep(widget.userOrder!.status ?? "");
  }

  void setActiveStep(String status) {
    setState(() {
      switch (status) {
        case "Order Confirmed":
          activeStep = 0;
          break;
        case "Shipped":
          activeStep = 1;
          break;
        case "Out for Delivery":
          activeStep = 2;
          break;
        case "Delivered":
          activeStep = 3;
          break;
        default:
          activeStep = 0;
      }
    });
  }

  List<TrackOrderList> trackOrderList = [
    TrackOrderList(
      title: "Order Confirmed",
      subtitle: "Your Order has been placed",
    ),
    TrackOrderList(
      title: "Shipped",
      subtitle: "Your Item has been shipped",
    ),
    TrackOrderList(
      title: "Out For Delivery",
      subtitle: "Your Order out for delivery",
    ),
    TrackOrderList(
      title: "Delivered",
      subtitle: "Your Order has been delivered",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: const Text("Track Order"),
        backgroundColor: Colors.grey[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                Jiffy().format("dd/MM/yyyy"),
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Order ID : ${widget.userOrder!.orderId}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Text(
                "Orders",
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width / 6,
                  child: IconStepper(
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: Colors.grey,
                    activeStep: activeStep!.toInt(),
                    activeStepColor: Colors.green,
                    stepReachedAnimationDuration: const Duration(seconds: 2),
                    activeStepBorderColor: Colors.white,
                    activeStepBorderWidth: 0.0,
                    activeStepBorderPadding: 0.0,
                    previousButtonIcon: const Icon(Icons.arrow_back),
                    lineColor: Colors.green,
                    scrollingDisabled: true,
                    lineLength: 70.0,
                    lineDotRadius: 2.0,
                    stepRadius: 16.0,
                    icons: const [
                      Icon(Icons.radio_button_checked, color: Colors.green),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                      Icon(Icons.check, color: Colors.white),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              title: Text(
                                trackOrderList[index].title.toString(),
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              subtitle: Text(
                                trackOrderList[index].subtitle.toString(),
                                style: const TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding:
                  const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(
                  width: 0.5,
                  color: Colors.black.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.home, size: 64.0, color: Colors.indigo[900]),
                  const SizedBox(width: 32.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Delivery Address",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "Home, Work &\n Other Address",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 1.8,
                      //   child: Text(
                      //     widget.userOrder!.!,
                      //     style: TextStyle(
                      //       fontSize: 15.0,
                      //       color: Colors.black.withOpacity(0.7),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrackOrderList {
  final String title;
  final String subtitle;

  TrackOrderList({required this.title, required this.subtitle});
}

// Define a callback function type
typedef StatusChangedCallback = void Function(String newStatus);
