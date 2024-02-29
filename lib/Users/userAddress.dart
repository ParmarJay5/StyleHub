// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class UserProfile extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   late Future<Map<String, dynamic>> _userDataFuture;
//
//   TextEditingController _addressController = TextEditingController();
//   TextEditingController _cityController = TextEditingController();
//   TextEditingController _stateController = TextEditingController();
//   TextEditingController _zipCodeController = TextEditingController();
//
//   File? _imageFile;
//   String _imageUrl = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _userDataFuture = _fetchUserData();
//   }
//
//   Future<Map<String, dynamic>> _fetchUserData() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User not logged in');
//     }
//     final snapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
//     if (!snapshot.exists) {
//       throw Exception('User data not found');
//     }
//     return snapshot.data() as Map<String, dynamic>;
//   }
//
//   Future<void> _updateAddress() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User not logged in');
//     }
//
//     // Construct the address data
//     Map<String, dynamic> addressData = {
//       'address': _addressController.text,
//       'city': _cityController.text,
//       'state': _stateController.text,
//       'zipCode': _zipCodeController.text,
//     };
//
//     // Update the user document in Firestore
//     await FirebaseFirestore.instance.collection('Users').doc(user.uid).update(addressData);
//
//     // Show a success message
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Address updated successfully'),
//     ));
//   }
//
//   Future<void> _pickAndUploadImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//
//       await _uploadImage();
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       throw Exception('User not logged in');
//     }
//
//     if (_imageFile == null) {
//       return;
//     }
//
//     final Reference storageRef = FirebaseStorage.instance.ref().child('user_profile_images').child(user.uid);
//     final UploadTask uploadTask = storageRef.putFile(_imageFile!);
//
//     await uploadTask.whenComplete(() async {
//       final String url = await storageRef.getDownloadURL();
//       setState(() {
//         _imageUrl = url;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: _userDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             final userData = snapshot.data!;
//             final imageUrl = _imageUrl.isNotEmpty ? _imageUrl : userData['profile_image'];
//             final username = userData['username'];
//             final email = userData['email'];
//             return Center(
//               child: Card(
//                 margin: EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(16),
//                       child: Column(
//                         children: [
//                           if (imageUrl != null)
//                             CircleAvatar(
//                               radius: 50,
//                               backgroundImage: NetworkImage(imageUrl),
//                             )
//                           else
//                             CircleAvatar(
//                               radius: 50,
//                               child: Icon(Icons.person),
//                             ),
//                           SizedBox(height: 20),
//                           Text(
//                             "Username: $username",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             "Email: $email",
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           TextFormField(
//                             controller: _addressController,
//                             decoration: InputDecoration(
//                               labelText: 'Address',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: _cityController,
//                             decoration: InputDecoration(
//                               labelText: 'City',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: _stateController,
//                             decoration: InputDecoration(
//                               labelText: 'State',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           TextFormField(
//                             controller: _zipCodeController,
//                             decoration: InputDecoration(
//                               labelText: 'Zip Code',
//                               border: OutlineInputBorder(),
//                             ),
//                             keyboardType: TextInputType.number,
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: _updateAddress,
//                             child: Text('Update Address'),
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             onPressed: _pickAndUploadImage,
//                             child: Text('Select Image'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
