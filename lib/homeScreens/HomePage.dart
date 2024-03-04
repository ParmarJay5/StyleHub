// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../category/categoryModel.dart';
// import '../subcategory/subCategoryModel.dart';
// class homePage extends StatefulWidget {
//   const homePage({Key? key});
//
//   @override
//   State<homePage> createState() => _homePageState();
// }
//
// class _homePageState extends State<homePage> {
//   late String searchQuery;
//   CollectionReference categoryRef =
//   FirebaseFirestore.instance.collection("Categories");
//
//   Future<List<categoryModel>> readCategory() async {
//     QuerySnapshot response = await categoryRef.get();
//     return response.docs.map((e) => categoryModel.fromSnapshot(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'StyleHub',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.lightBlue,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: CustomSearchDelegate(),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             return SingleChildScrollView(
//               child: FutureBuilder<List<categoryModel>>(
//                 future: readCategory(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         'Error: ${snapshot.error}',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(
//                       child: Image.asset(
//                         "assets/icons/imgs.jpg",
//                         height: 500,
//                         width: 500,
//                       ),
//                     );
//                   } else {
//                     List<categoryModel>? categories = snapshot.data;
//
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 130,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: categories!.length,
//                             itemBuilder: (context, index) {
//                               final category = categories[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   // Navigator.push(
//                                   //   context,
//                                   //   MaterialPageRoute(
//                                   //     builder: (context) => SubCategoryScreen(
//                                   //       categoryId: category.id,
//                                   //     ),
//                                   //   ),
//                                   // );
//                                 },
//                                 child: Container(
//                                   width: orientation == Orientation.portrait ? 120 : 200,
//                                   height: 200,
//                                   margin: const EdgeInsets.only(right: 16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.3),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: const Offset(
//                                           0,
//                                           3,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 40,
//                                         backgroundColor: Colors.transparent,
//                                         child: ClipOval(
//                                           child: Image.network(
//                                             category.image,
//                                             width: 80,
//                                             height: 80,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         category.category,
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _onBackPressed() async {
//     // Your back press logic here
//     return true;
//   }
// }
//
// class CustomSearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, '');
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: Implement search results
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: Implement search suggestions
//     throw UnimplementedError();
//   }
// }






//
// import 'package:StyleHub/homeScreens/favoritePage.dart';
// import 'package:StyleHub/subcategory/SubCategoryScreen.dart';
// import 'package:StyleHub/userLogin.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../category/categoryModel.dart';
// import '../image.dart';
// import '../subcategory/subCategoryModel.dart';
//
// class homePage extends StatefulWidget {
//   const homePage({Key? key});
//
//   @override
//   State<homePage> createState() => _homePageState();
// }
//
// class _homePageState extends State<homePage> {
//   late String searchQuery;
//   CollectionReference categoryRef =
//   FirebaseFirestore.instance.collection("Categories");
//
//   Future<List<categoryModel>> readCategory() async {
//     QuerySnapshot response = await categoryRef.get();
//     return response.docs.map((e) => categoryModel.fromSnapshot(e)).toList();
//   }
//
//   CollectionReference subCategoryRef = FirebaseFirestore.instance.collection("SubCategories");
//
//   Future<List<subCategoryModel>> readsubCategory() async {
//     QuerySnapshot response = await subCategoryRef.get();
//     return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//         drawer: Drawer(
//             child: ListView(
//               children: [
//                 DrawerHeader(
//                   decoration:  BoxDecoration(
//                     color: Colors.white,
//                     image: DecorationImage(
//                       image: AssetImage(a), // Replace "path/to/your/image.jpg" with the actual path to your image asset
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     child: Text("User",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
//                   ),
//                 ),
//                 ListTile(leading: Icon(Icons.dashboard),
//                   title: Text("Home",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   onTap: () => Navigator.of(context).pop(false),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.add_box),
//                   title: Text("My Orders",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   // onTap: ,
//                 ),
//                 ListTile(
//                   onTap: (){
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => favoritePage()));
//                   },
//                   leading: Icon(Icons.favorite),
//                   title: Text("Favorite",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   // onTap: ,
//                 ),
//                 ListTile(leading: Icon(Icons.logout),
//
//                   onTap:()
//                   {
//                     FirebaseAuth.instance.signOut();
//                     {
//                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => userLogin()), (route) => false);
//                     }
//                   },
//                   title: Text("Logout",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   // onTap: ,
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.share),
//                   title: Text("share",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   // onTap: ,
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.rate_review),
//                   title: Text("Rate Us",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                   // onTap: ,
//                 ),
//               ],
//             )
//         ),
//
//         appBar: AppBar(
//           title: const Text(
//             'StyleHub',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Colors.lightBlue,
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: CustomSearchDelegate(),
//                 );
//               },
//             ),
//           ],
//         ),
//         body: OrientationBuilder(
//           builder: (context, orientation) {
//             return SingleChildScrollView(
//               child: FutureBuilder<List<categoryModel>>(
//                 future: readCategory(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text(
//                         'Error: ${snapshot.error}',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     );
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Center(
//                       child: Image.asset(
//                         "assets/icons/imgs.jpg",
//                         height: 500,
//                         width: 500,
//                       ),
//                     );
//                   } else {
//                     List<categoryModel>? categories = snapshot.data;
//
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 130,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: categories!.length,
//                             itemBuilder: (context, index) {
//                               final category = categories[index];
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => SubCategoryScreen(selectedCategory: category,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   width: orientation == Orientation.portrait
//                                       ? 120
//                                       : 200,
//                                   height: 200,
//                                   margin: const EdgeInsets.only(right: 16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.withOpacity(0.3),
//                                         spreadRadius: 2,
//                                         blurRadius: 5,
//                                         offset: const Offset(
//                                           0,
//                                           3,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 40,
//                                         backgroundColor: Colors.transparent,
//                                         child: ClipOval(
//                                           child: Image.network(
//                                             category.image,
//                                             width: 80,
//                                             height: 80,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         category.category,
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<bool> _onBackPressed() async {
//     // Your back press logic here
//     return true;
//   }
// }
//
// class CustomSearchDelegate extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, '');
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: Implement search results
//     throw UnimplementedError();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: Implement search suggestions
//     throw UnimplementedError();
//   }
// }
//



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:StyleHub/Seller/Products/productModel.dart';
import '../Seller/Products/producrDetailScreen.dart';
import '../category/categoryModel.dart';
import '../page.dart';
import '../subcategory/subCategoryModel.dart';
import '../image.dart';
import '../subcategory/SubCategoryScreen.dart';
import '../Users/Favorite/favoritePage.dart';
import '../userLogin.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late String searchQuery;
  // late Future<Map<String, dynamic>> _userDataFuture;

  // @override
  // void initState() {
  //   super.initState();
  //   _userDataFuture = _fetchUserData();
  // }

  Future<Map<String, dynamic>> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    final snapshot = await FirebaseFirestore.instance.collection('Users').doc(user.uid).get();
    if (!snapshot.exists) {
      throw Exception('User data not found');
    }
    return snapshot.data() as Map<String, dynamic>;
  }


  CollectionReference categoryRef =
  FirebaseFirestore.instance.collection("Categories");

  Future<List<categoryModel>> readCategory() async {
    QuerySnapshot response = await categoryRef.get();
    return response.docs.map((e) => categoryModel.fromSnapshot(e)).toList();
  }

  CollectionReference subCategoryRef =
  FirebaseFirestore.instance.collection("SubCategories");

  Future<List<subCategoryModel>> readsubCategory() async {
    QuerySnapshot response = await subCategoryRef.get();
    return response.docs
        .map((e) => subCategoryModel.fromSnapshot(e))
        .toList();
  }

  Future<List<productModel>> fetchProducts() async {
    QuerySnapshot response =
    await FirebaseFirestore.instance.collection("products").get();
    return response.docs.map((e) => productModel.fromSnapshot(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        drawer: Drawer(
          child:
      //     FutureBuilder<Map<String, dynamic>>(
      //   future: _userDataFuture,
      //   builder: (context, snapshot) {
      // if (snapshot.connectionState == ConnectionState.waiting) {
      //   return CircularProgressIndicator();
      // } else if (snapshot.hasError) {
      //   return Text('Error: ${snapshot.error}');
      // } else {
      //   final userData = snapshot.data!;
      //   final username = userData['username'];
      //   final imageUrl = userData['profile_image'];
      //   return
          ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(a),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Text(
                  "User",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text(
                "Home",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              onTap: () => Navigator.of(context).pop(false),
            ),
            const ListTile(
              leading: Icon(Icons.add_box),
              title: Text(
                "My Orders",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavoriteScreen()));
              },
              leading: const Icon(Icons.favorite),
              title: const Text(
                "Favorite",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const UserLogin()),
                          (route) => false);
                }
              },
              title: const Text(
                "Logout",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.share),
              title: Text(
                "share",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                "Rate Us",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      // ;
      // }
    // }
      // ),
        ),
        appBar: AppBar(
          title: const Text(
            'StyleHub',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<categoryModel>>(
                    future: readCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Image.asset(
                            "assets/icons/imgs.jpg",
                            height: 500,
                            width: 500,
                          ),
                        );
                      } else {
                        List<categoryModel>? categories = snapshot.data;

                        return SizedBox(
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories!.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubCategoryScreen(
                                        selectedCategory: category,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: orientation == Orientation.portrait ? 120 : 200,
                                  height: 220,
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child: Image.network(
                                            category.image,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        category.category,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Banners').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text(
                              'No banners found',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        } else {
                          List<QueryDocumentSnapshot> banners = snapshot.data!.docs;
                          return Column(
                            children: [
                              CarouselSlider.builder(
                                itemCount: banners.length,
                                itemBuilder: (context, index, realIndex) {
                                  final banner = banners[index];
                                  String imageUrl = banner['image'];
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 6,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 200.0,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              FutureBuilder<List<productModel>>(
                                future: fetchProducts(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        'Error: ${snapshot.error}',
                                        style: const TextStyle(color: Colors.red),
                                      ),
                                    );
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'No products found',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  } else {
                                    List<productModel> products = snapshot.data!;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Products',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.7,
                                            ),
                                            itemCount: products.length,
                                            itemBuilder: (context, index) {
                                              final product = products[index];
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProductDetailScreen(
                                                         products: product,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(16),
                                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(12),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Image.network(
                                                        product.image[0],
                                                        width: double.infinity,
                                                        height: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      const SizedBox(height: 12),
                                                      Text(
                                                        product.productName,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        '\₹ ${product.productPrice}',
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                            decoration: TextDecoration.lineThrough
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        '\₹ ${product.productNewPrice}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const page()));
    return true;
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Implement search results
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Implement search suggestions
    throw UnimplementedError();
  }
}


// class ProductDetailScreen extends StatelessWidget {
//   final Map<String, dynamic>? data;
//
//   const ProductDetailScreen({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(data?['productName'] ?? 'Product Detail'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.network(
//                     data?['image']?.first ?? '', // Display the first image
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Old Price: \$${data?['productPrice'] ?? ''}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 'New Price: \$${data?['productNewPrice'] ?? ''}',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 data?['productDescription'] ?? '',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add your action here
//                 },
//                 child: Text('Add to Cart'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
