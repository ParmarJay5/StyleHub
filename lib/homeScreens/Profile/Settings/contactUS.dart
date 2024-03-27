import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('support@stylehub.com'),
              onTap: () {
                // Implement email functionality
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('9664802800'),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address'),
              subtitle: Text('123 Main Street, Rajkot, Gujarat'),
              onTap: () {
                // Implement map functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

