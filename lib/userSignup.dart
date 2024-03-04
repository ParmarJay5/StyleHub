// import 'package:StyleHub/userLogin.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'image.dart';
//
// class userSignup extends StatefulWidget {
//   const userSignup({super.key});
//
//   @override
//   State<userSignup> createState() => _userSignupState();
// }
//
// class _userSignupState extends State<userSignup> {
//   final Form_key = GlobalKey<FormState>();
//   TextEditingController username = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController conPass = TextEditingController();
//
//   String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
//
//   bool isLoading = false;
//   bool passwordVisible = false;
//   bool confirmpasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Padding(padding: EdgeInsets.all(30),
//                   child: Text("Signup To Your\nAccount", style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),)),
//
//               SizedBox(height: 20,),
//               Center(child: Image.asset(login, width: 100, height: 100,)),
//               SizedBox(height: 40,),
//               Form(
//                 key: Form_key,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: username,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Username",
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: email,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "abc@gmail.com",
//                         prefixIcon: Icon(Icons.email),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: pass,
//                       obscureText: !passwordVisible,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               passwordVisible = !passwordVisible;
//                             });
//                           },
//                           icon: Icon(
//                             passwordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a password';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     TextFormField(
//                       controller: conPass,
//                       obscureText: !confirmpasswordVisible,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Confirm Password",
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               confirmpasswordVisible = !confirmpasswordVisible;
//                             });
//                           },
//                           icon: Icon(
//                             confirmpasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please confirm your password';
//                         }
//                         if (value != pass.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: isLoading
//                         ? null
//                         : () async {
//                       if (Form_key.currentState!.validate()) {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         try {
//                           UserCredential userCredential =
//                           await FirebaseAuth.instance
//                               .createUserWithEmailAndPassword(
//                             email: email.text,
//                             password: pass.text,
//                           );
//                           await FirebaseFirestore.instance
//                               .collection("Users")
//                               .doc(userCredential.user!.uid)
//                               .set({
//                             'Username': username.text,
//                             'Email': email.text,
//                             'Password':pass.text,
//                             'Confirm Password': conPass.text
//                           });
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text("Registration Successful"),
//                             ),
//                           );
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => userLogin(),
//                             ),
//                           );
//                         } on FirebaseAuthException catch (e) {
//                           if (e.code == 'weak-password') {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content:
//                                 Text("The password provided is too weak"),
//                               ),
//                             );
//                           } else if (e.code == 'email-already-in-use') {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text("The account already exists for that email"),),
//                             );
//                           }
//                         } catch (e) {
//                           print(e);
//                         }
//                         setState(() {
//                           isLoading = false;
//                         });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Signup",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have an account?",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => userLogin(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// main code
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
// import 'userLogin.dart'; // Assuming you have a userLogin.dart file
//
// class UserSignup extends StatefulWidget {
//   const UserSignup({Key? key}) : super(key: key);
//
//   @override
//   State<UserSignup> createState() => _UserSignupState();
// }
//
// class _UserSignupState extends State<UserSignup> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passController = TextEditingController();
//   final TextEditingController _conPassController = TextEditingController();
//
//   bool _isLoading = false;
//   bool _passwordVisible = false;
//   bool _confirmPasswordVisible = false;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Initialize Firestore instance
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(30),
//                 child: Text(
//                   "Signup To Your\nAccount",
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Username TextFormField
//                     TextFormField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Username",
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     // Email TextFormField
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "abc@gmail.com",
//                         prefixIcon: Icon(Icons.email),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     // Password TextFormField
//                     TextFormField(
//                       controller: _passController,
//                       obscureText: !_passwordVisible,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Password",
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _passwordVisible = !_passwordVisible;
//                             });
//                           },
//                           icon: Icon(
//                             _passwordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a password';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     // Confirm Password TextFormField
//                     TextFormField(
//                       controller: _conPassController,
//                       obscureText: !_confirmPasswordVisible,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         hintText: "Confirm Password",
//                         prefixIcon: Icon(Icons.lock),
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _confirmPasswordVisible =
//                               !_confirmPasswordVisible;
//                             });
//                           },
//                           icon: Icon(
//                             _confirmPasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please confirm your password';
//                         }
//                         if (value != _passController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _isLoading
//                         ? null
//                         : () async {
//                       if (_formKey.currentState!.validate()) {
//                         setState(() {
//                           _isLoading = true;
//                         });
//
//                         try {
//                           // Create user with email and password
//                           final UserCredential userCredential =
//                           await _auth.createUserWithEmailAndPassword(
//                             email: _emailController.text,
//                             password: _passController.text,
//                           );
//
//                           // Get UID of the newly created user
//                           final String uid =
//                               userCredential.user!.uid;
//
//                           // Store user data in Firestore
//                           await _firestore
//                               .collection('Users')
//                               .doc(uid)
//                               .set({
//                             'username': _usernameController.text,
//                             'email': _emailController.text,
//                             'password': _passController,
//                             'confirm password': _confirmPasswordVisible
//                             // You can add more fields as needed
//                           });
//
//                           // Navigate to the next screen or perform necessary actions
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UserLogin(),
//                             ),
//                           );
//                         } catch (e) {
//                           print('Error occurred: $e');
//                           // Handle error, e.g., display an error message
//                         }
//
//                         setState(() {
//                           _isLoading = false;
//                         });
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Signup",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have an account?",
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserLogin(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// tesing code

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userLogin.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({Key? key}) : super(key: key);

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _conPassController = TextEditingController();

  String uniquefilename = DateTime.now().millisecondsSinceEpoch.toString();
  String imageUrl = "";
  File? selectedImage;

  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Signup To Your\nAccount",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: selectedImage != null
                              ? ClipOval(
                                  child: Image.file(
                                    selectedImage!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: _pickImage,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Username",
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "abc@gmail.com",
                        prefixIcon: const Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _conPassController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                final UserCredential userCredential =
                                    await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passController.text,
                                );

                                final String uid =
                                    userCredential.user!.uid; // Get UID

                                if (selectedImage != null) {
                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImage =
                                      referenceRoot.child("Users_Image");
                                  Reference referenceImageUpload =
                                      referenceDirImage.child(uniquefilename);

                                  await referenceImageUpload
                                      .putFile(selectedImage!);
                                  imageUrl = await referenceImageUpload
                                      .getDownloadURL();
                                  print("Image Url $imageUrl");

                                  // Store user data with UID
                                  await _firestore
                                      .collection('Users')
                                      .doc(uid)
                                      .set({
                                    'uid': uid,
                                    'username': _usernameController.text,
                                    'email': _emailController.text,
                                    'profile_image': imageUrl,
                                    // You can add more fields as needed
                                  });

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserLogin(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Please select an Image")));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              } catch (e) {
                                print('Error occurred: $e');
                              }

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Signup",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
