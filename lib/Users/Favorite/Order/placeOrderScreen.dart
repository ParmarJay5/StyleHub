import 'package:StyleHub/Users/Favorite/Order/cancelOrderMsg.dart';
import 'package:StyleHub/Users/OrderTracking%20seller/OrderTrackingScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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


  Future<void> _cancelOrder(BuildContext context, String orderId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Cancel',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to cancel this order?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CancelMessageScreen(orderId: orderId, paymentMethod: '')));
              },
            ),
            TextButton(
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Order $orderId cancelled successfully!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                  // Navigate to the home screen after cancelling the order
                  Navigator.of(context).popUntil(ModalRoute.withName('/')); // Navigate to the home screen
                } catch (error) {
                  print('Error cancelling order: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to cancel order. Please try again.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
          if (!snapshot.hasData || snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No orders available."),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData = snapshot.data!.docs[index].data() as Map<
                  String,
                  dynamic>;
              var orderId = snapshot.data!.docs[index].id;
              var products = orderData['products'] as List<dynamic>;
              double subtotal = 0.0;
              for (var product in products) {
                subtotal += double.parse(product['totalprice'].toString());
              }
              return Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: $orderId",
                        style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: products.map<Widget>((product) {
                          return ListTile(
                            title: Text(
                              product['productName'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Quantity: ${product['quantity']}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            trailing: Text(
                              "\₹ ${product['totalprice']}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\₹ $subtotal",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Payment Method: ${orderData['paymentMethod']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Delivery Status: ${orderData['status']}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              _cancelOrder(context, orderId);
                            },
                            icon: Icon(Icons.cancel, color: Colors.red),
                            tooltip: 'Cancel Order',
                          ),


                        ],
                      ),
                    ],
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
