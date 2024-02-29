// import 'package:StyleHub/Products/productScreen.dart';
// import 'package:StyleHub/Seller/sellerSignup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../image.dart';
//
// class sellerLogin extends StatefulWidget {
//   const sellerLogin({super.key});
//
//   @override
//   State<sellerLogin> createState() => _sellerLoginState();
// }
//
// class _sellerLoginState extends State<sellerLogin> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   var password = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             SizedBox(height: 80,),
//             Padding(padding: EdgeInsets.all(30),
//                 child: Text("Login To Your\nAccount",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),)),
//
//             SizedBox(height: 20,),
//             Center(child: Image.asset(login,width: 100,height: 100,)),
//
//             SizedBox(height: 40,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//               child: TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//
//                   ),
//                   hintText: "abc@gmail.com",
//                   prefixIcon: Icon(Icons.email),
//
//                 ),
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//               child: TextFormField(
//                 controller: _passwordController,
//                 obscureText: password,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     hintText: "Password",
//                     prefixIcon: Icon(Icons.password),
//                     suffixIcon: IconButton(
//                         onPressed: (){
//                           setState(() {
//                             password = !password;
//                           });
//
//                         }, icon: password
//                         ? Icon(Icons.visibility)
//                         : Icon(Icons.visibility_off)
//                     )
//                 ),
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//             //   child: Row(mainAxisAlignment: MainAxisAlignment.end,
//             //     children: [
//             //       TextButton(onPressed: (){}, child: Text("Forget Password?", style: TextStyle(color: Colors.grey),)),
//             //     ],
//             //   ),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//             //   child: SizedBox(width: double.infinity,
//             //
//             //     child: ElevatedButton(onPressed: (){
//             //       Navigator.push(context, MaterialPageRoute(builder: (context) => homeScreen() ));
//             //     },
//             //         style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(10)
//             //         )),
//             //         child: Text("Login",style: TextStyle(color: Colors.white),)),
//             //   ),
//             // ),
//
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       final UserCredential userCredential =
//                       await _auth.signInWithEmailAndPassword(
//                         email: _emailController.text.trim(),
//                         password: _passwordController.text,
//                       );
//                       // Navigate to home screen if login successful
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => ProductScreen()),
//                       );
//                     } catch (e) {
//                       // Show error message if login fails
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text("Failed to sign in"),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.lightBlue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     "Login",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10,),
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Don't have an account?",style: TextStyle(color: Colors.grey),),
//                 TextButton(onPressed: (){
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => sellerSignup()));
//                 }, child: Text("Signup",style: TextStyle(color: Colors.black),))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// main code
//
// import 'package:StyleHub/Seller/Products/addProductScreen.dart';
// import 'package:StyleHub/Seller/Products/sellerDetails.dart';
// import 'package:StyleHub/homeScreens/HomePage.dart';
// import 'package:StyleHub/homeScreens/homeScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class SellerLogin extends StatefulWidget {
//   const SellerLogin({Key? key}) : super(key: key);
//
//   @override
//   State<SellerLogin> createState() => _SellerLoginState();
// }
//
// class _SellerLoginState extends State<SellerLogin> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool _passwordVisible = false;
//
//   Future<void> _login() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       Navigator.of(context).push(MaterialPageRoute(builder: (context) => SellerDetailScreen()));
//
//       // Navigate to the home screen or another desired screen upon successful login
//     } catch (e) {
//       print("Error occurred: $e");
//       // Handle errors, e.g., display an error message to the user
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(30),
//                 child: Text(
//                   "Login To Your\nAccount",
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
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
//                     TextFormField(
//                       controller: _passwordController,
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
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _login(); // Call the login function
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.lightBlue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       "Login",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// testing code
import 'package:StyleHub/Seller/Products/sellerDetails.dart';
import 'package:StyleHub/Seller/sellerProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:StyleHub/homeScreens/HomePage.dart'; // Assuming this is your home screen

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  State<SellerLogin> createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Check if the seller is already logged in
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // If the user is logged in, navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SellerDetailScreen()), // Replace HomePage with your home screen
        );
      }
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // No need to navigate here, as the authStateChanges listener will handle navigation
    } catch (e) {
      print("Error occurred: $e");
      // Handle errors, e.g., display an error message to the user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Login To Your\nAccount",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "abc@gmail.com",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login(); // Call the login function
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
