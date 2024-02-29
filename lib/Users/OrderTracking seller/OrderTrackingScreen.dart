import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  OrderTrackingScreen({required this.orderId});

  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = ''; // Initialize selected status
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracking'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('orders').doc(widget.orderId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('No data found'),
            );
          }

          var orderData = snapshot.data!.data() as Map<String, dynamic>?; // Nullable map
          if (orderData == null) {
            return Center(
              child: Text('No data found'),
            );
          }

          // Build dropdown list for order status
          var statusList = ['Ordered', 'Shipped', 'Out for Delivery', 'Delivered'];
          var dropdownItems = statusList.map((status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            );
          }).toList();

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${snapshot.data!.id}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Order Date: ${_formatOrderDate(orderData['orderDate'] as Timestamp?)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Ordered Day: ${_getOrderedDay(orderData['orderDate'] as Timestamp?)}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                // Dropdown list for order status
                DropdownButtonFormField<String>(
                  value: _selectedStatus,
                  hint: Text('Select Order Status'),
                  items: dropdownItems,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                      _updateOrderStatus(value); // Call method to update status
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildOrderItems(orderData),
                SizedBox(height: 20),
                _buildTrackingInfo(orderData),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatOrderDate(Timestamp? orderDate) {
    if (orderDate == null) {
      return '';
    }
    var dateTime = orderDate.toDate();
    var formatter = DateFormat.yMMMd();
    return formatter.format(dateTime);
  }

  String _getOrderedDay(Timestamp? orderDate) {
    if (orderDate == null) {
      return '';
    }
    var dateTime = orderDate.toDate();
    var formatter = DateFormat('EEEE');
    return formatter.format(dateTime);
  }

  Widget _buildOrderItems(Map<String, dynamic> orderData) {
    var orderItems = orderData['items'] as List<dynamic>?; // Nullable list
    if (orderItems == null || orderItems.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Details:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (var item in orderItems) ...[
          _buildOrderItem(
            item['productName'] ?? '',
            'Quantity: ${item['quantity'] ?? ''}',
            'Price: \$${item['ProductNewPrice'] ?? ''}',
            'Ordered Date: ${_formatOrderDate(orderData['orderDate'] as Timestamp?)}',
            'Ordered Day: ${_getOrderedDay(orderData['orderDate'] as Timestamp?)}',
          ),
        ],
      ],
    );
  }

  Widget _buildOrderItem(String productName, String quantity, String price, String orderedDate, String orderedDay) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(quantity),
        Text(price),
        Text(orderedDate),
        Text(orderedDay),
        Divider(),
      ],
    );
  }

  Widget _buildTrackingInfo(Map<String, dynamic> orderData) {
    var trackingInfo = orderData['tracking'] as List<dynamic>?; // Nullable list
    if (trackingInfo == null || trackingInfo.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking Information:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (var status in trackingInfo) ...[
          _buildTrackingItem(
            status['status'] ?? '',
            status['date'] ?? '',
          ),
        ],
      ],
    );
  }

  Widget _buildTrackingItem(String status, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Text(
              status,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(date),
        Divider(),
      ],
    );
  }

  // Method to update order status
  void _updateOrderStatus(String newStatus) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(widget.orderId).update({
        'status': newStatus,
      });
    } catch (error) {
      print('Error updating order status: $error');
    }
  }
}
