import 'dart:async';

import 'package:flutter/material.dart';

class CancelMessageScreen extends StatefulWidget {
  final String orderId;
  final String paymentMethod;

  CancelMessageScreen({required this.orderId, required this.paymentMethod});

  @override
  _CancelMessageScreenState createState() => _CancelMessageScreenState();
}

class _CancelMessageScreenState extends State<CancelMessageScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate back to home screen after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Order'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 50,
              ),
              SizedBox(height: 20),
              Text(
                'Order ID: ${widget.orderId}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                widget.paymentMethod == 'COD'
                    ? 'Your order has been canceled.'
                    : 'Your order has been canceled and a refund will be processed.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
