// import 'package:StyleHub/subcategory/subCategoryModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class SubCategoryScreen extends StatefulWidget {
//   final String subCategoryId;
//
//   const SubCategoryScreen({Key? key, required this.subCategoryId})
//   : super(key: key);
//
//   @override
//   State<SubCategoryScreen> createState() => _SubCategoryScreenState();
//
// }
//
// class _SubCategoryScreenState extends State<SubCategoryScreen> {
//   late String searchQuery;
//   CollectionReference subCategoryRef =
//   FirebaseFirestore.instance.collection("SubCategories");
//
//   Future<List<subCategoryModel>> readsubCategory() async {
//     QuerySnapshot response = await subCategoryRef.get();
//     return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             OrientationBuilder(
//               builder: (context, orientation) {
//                 return SingleChildScrollView(
//                   child: FutureBuilder<List<subCategoryModel>>(
//                     future: readsubCategory(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             'Error: ${snapshot.error}',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         );
//                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                         return Center(
//                           child: Image.asset(
//                             "assets/icons/imgs.jpg",
//                             height: 500,
//                             width: 500,
//                           ),
//                         );
//                       } else {
//                         List<subCategoryModel>? subCategories = snapshot.data;
//
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 130,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: subCategories!.length,
//                                 itemBuilder: (context, index) {
//                                   final subCategory = subCategories[index];
//                                   return GestureDetector(
//                                     onTap: () async {
//                                       // Query subcategories based on the tapped category ID
//                                       QuerySnapshot querySnapshot = await FirebaseFirestore
//                                           .instance
//                                           .collection('SubCategories')
//                                           .where('categoryId',
//                                           isEqualTo: subCategory.id)
//                                           .get();
//
//                                       // Check if there are subcategories available for the tapped category
//                                       if (querySnapshot.docs.isNotEmpty) {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 SubCategoryScreen(
//                                                   subCategoryId: subCategory.id,
//                                                 ),
//                                           ),
//                                         );
//                                       } else {
//                                         // Show a message or perform another action if there are no subcategories
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text(
//                                                 'No subcategories found for ${
//                                                     subCategory.subCategory}'),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       width: orientation == Orientation.portrait
//                                           ? 120
//                                           : 200,
//                                       height: 200,
//                                       margin: const EdgeInsets.only(right: 16),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.3),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: const Offset(
//                                               0,
//                                               3,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 40,
//                                             backgroundColor: Colors.transparent,
//                                             child: ClipOval(
//                                               child: Image.network(
//                                                 subCategory.image,
//                                                 width: 80,
//                                                 height: 80,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Text(
//                                             subCategory.subCategory,
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                   )
//                             )
//                                   ]
//                                   );
//                                 }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
//
//


//
// import 'package:StyleHub/category/categoryModel.dart';
// import 'package:StyleHub/subcategory/subCategoryModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../Products/productModel.dart';
//
// class SubCategoryScreen extends StatefulWidget {
//   final categoryModel selectedCategory;
//   // final String categoryId;
//   // final String subCategoryId;
//
//   const SubCategoryScreen({Key? key, required this.selectedCategory})
//       : super(key: key);
//
//   @override
//   State<SubCategoryScreen> createState() => _SubCategoryScreenState();
//
// }
//
// class _SubCategoryScreenState extends State<SubCategoryScreen> {
//   // late String searchQuery;
//   CollectionReference subCategoryRef = FirebaseFirestore.instance.collection("SubCategories");
//
//   Future<List<subCategoryModel>> readSubCategory() async {
//     QuerySnapshot response = await subCategoryRef.get();
//     return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
//   }
//
//   Future<List<productModel>> readProducts() async {
//     QuerySnapshot response = await FirebaseFirestore.instance.collection("products").get();
//     return response.docs.map((e) => productModel.fromSnapshot(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             OrientationBuilder(
//               builder: (context, orientation) {
//                 return SingleChildScrollView(
//                   child: FutureBuilder<List<subCategoryModel>>(
//                     future: readSubCategory(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         return Center(
//                           child: Text(
//                             'Error: ${snapshot.error}',
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         );
//                       } else
//                       //   if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       //   return Center(
//                       //     child: Image.asset(
//                       //       "assets/icons/imgs.jpg",
//                       //       height: 500,
//                       //       width: 500,
//                       //     ),
//                       //   );
//                       // } else
//                       {
//                         List<subCategoryModel>? subCategories = snapshot.data;
//
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 130,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: subCategories!.length,
//                                 itemBuilder: (context, index) {
//                                   final subCategory = subCategories[index];
//                                   return GestureDetector(
//                                     onTap: () async {
//                                       // Query subcategories based on the tapped category ID
//                                       QuerySnapshot querySnapshot = await FirebaseFirestore
//                                           .instance
//                                           .collection('SubCategories')
//                                           .where('categoryId',
//                                           isEqualTo: subCategory.id)
//                                           .get();
//
//                                       // Check if there are subcategories available for the tapped category
//                                       if (querySnapshot.docs.isNotEmpty) {
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) =>
//                                                 SubCategoryScreen(
//                                                   categoryId: subCategory.id,
//                                                   subCategoryId: subCategory.id,
//                                                 ),
//                                           ),
//                                         );
//                                       } else {
//                                         // Show a message or perform another action if there are no subcategories
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                             content: Text('No subcategories found for ${subCategory.subCategory}'),
//                                           ),
//                                         );
//                                       }
//                                     },
//                                     child: Container(
//                                       width: orientation == Orientation.portrait
//                                           ? 120
//                                           : 200,
//                                       height: 200,
//                                       margin: const EdgeInsets.only(right: 16),
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(12),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.3),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                             offset: const Offset(0, 3,),),
//                                         ],
//                                       ),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 40,
//                                             backgroundColor: Colors.transparent,
//                                             child: ClipOval(
//                                               child: Image.network(
//                                                 subCategory.image,
//                                                 width: 80,
//                                                 height: 80,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Text(
//                                             subCategory.subCategory,
//                                             style: const TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
//



// import 'package:StyleHub/subcategory/subCategoryModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../Products/productModel.dart';
// import '../Products/productScreen.dart';
// import '../category/categoryModel.dart';
//
// class SubCategoryScreen extends StatefulWidget {
//   final categoryModel selectedCategory;
//
//   const SubCategoryScreen({Key? key, required this.selectedCategory}) : super(key: key);
//
//   @override
//   State<SubCategoryScreen> createState() => _SubCategoryScreenState();
// }
//
// class _SubCategoryScreenState extends State<SubCategoryScreen> {
//   CollectionReference subCategoryRef = FirebaseFirestore.instance.collection("SubCategories");
//
//   Future<List<subCategoryModel>> readSubCategory() async {
//     QuerySnapshot response = await subCategoryRef.get();
//     return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
//   }
//
//   Future<List<productModel>> readProducts() async {
//     QuerySnapshot response = await FirebaseFirestore.instance.collection("products").get();
//     return response.docs.map((e) => productModel.fromSnapshot(e)).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: 340,
//               child: TextFormField(
//                 onChanged: (value) {},
//                 decoration: const InputDecoration(
//                   labelText: "Search",
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<subCategoryModel>>(
//         future: readSubCategory(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Image.asset(
//                 "assets/images/image5.jpg",
//                 height: 500,
//                 width: 500,
//               ),
//             );
//           } else {
//             List<subCategoryModel> subCategories = snapshot.data!;
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: subCategories.length,
//               itemBuilder: (context, index) {
//                 final subCategory = subCategories[index];
//                 return Container(
//                   width: 120,
//                   margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           List<productModel> products = await readProducts();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductScreen(
//                                 selectedSubCategory: subCategory,
//                                 products: products,
//                               ),
//                             ),
//                           );
//                         },
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15.0),
//                           child: Image.network(
//                             subCategory.image ?? "",
//                             width: 80,
//                             height: 80,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       InkWell(
//                         onTap: () async {
//                           List<productModel> products = await readProducts();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => productScreen(
//                                 selectedSubCategory: subCategory,
//                                 products: products,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           subCategory.subCategory,
//                           style: const TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   productScreen({required selectedSubCategory, required List<productModel> products}) {}
// }

//
// //main


import 'package:StyleHub/image.dart';
import 'package:StyleHub/subcategory/productPage.dart';
import 'package:StyleHub/subcategory/subCategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Seller/Products/productModel.dart';
import '../Seller/Products/productScreen.dart';
import '../category/categoryModel.dart';

class SubCategoryScreen extends StatefulWidget {
  final categoryModel selectedCategory;

  const SubCategoryScreen({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CollectionReference subCategoryRef = FirebaseFirestore.instance.collection("SubCategories");

  Future<List<subCategoryModel>> readSubCategory() async {
    QuerySnapshot response = await subCategoryRef.where('categoryId', isEqualTo: widget.selectedCategory.id).get();
    return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
  }

  Future<List<subCategoryModel>> readsubCategory() async {
    QuerySnapshot response = await subCategoryRef.get();
    return response.docs.map((e) => subCategoryModel.fromSnapshot(e)).toList();
  }

  Future<List<productModel>> readProducts() async {
    QuerySnapshot response = await FirebaseFirestore.instance.collection("products").get();
    return response.docs.map((e) => productModel.fromSnapshot(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: SizedBox(
          //     width: 340,
          //     child: TextFormField(
          //       onChanged: (value) {},
          //       decoration: const InputDecoration(
          //         labelText: "Search",
          //         prefixIcon: Icon(Icons.search),
          //         border: OutlineInputBorder(),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      body: FutureBuilder<List<subCategoryModel>>(
        future: readsubCategory().then((value) => value.where((element) => element.category == widget.selectedCategory.category).toList()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Image.asset(
                img,
                height: 500,
                width: 500,
              ),
            );
          } else {
            List<subCategoryModel> subCategories = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final subCategory = subCategories[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          // List<productModel> products = await readProducts();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductScreen(
                          //       selectedSubCategory: subCategory,
                          //       products: products,
                          //     ),
                          //   ),
                          // );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            subCategory.image ?? "",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                          List<productModel> products = await readProducts();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                selectedSubCategory: subCategory, products: products,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          subCategory.subCategory,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
