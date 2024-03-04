// import 'package:StyleHub/homeScreens/homeScreen.dart';
// import 'package:StyleHub/image.dart';
// import 'package:StyleHub/userSignup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class userLogin extends StatefulWidget {
//   const userLogin({super.key});
//
//   @override
//   State<userLogin> createState() => _userLoginState();
// }
//
// class _userLoginState extends State<userLogin> {
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
//                         MaterialPageRoute(builder: (context) => homeScreen()),
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
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => userSignup()));
//                 }, child: Text("Signup",style: TextStyle(color: Colors.black),))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:StyleHub/homeScreens/homeScreen.dart';
import 'package:StyleHub/userSignup.dart';
import 'image.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var password = false;
  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If sign in is successful, navigate to the home screen
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationHome()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Login To Your\nAccount",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Center(child: Image.asset(login, width: 100, height: 100)),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "abc@gmail.com",
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: _validateEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        password = !password;
                      });
                    },
                    icon: password
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                validator: _validatePassword,
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateEmail(_emailController.text) == null &&
                        _validatePassword(_passwordController.text) == null) {
                      signInWithEmailAndPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserSignup()));
                  },
                  child: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
