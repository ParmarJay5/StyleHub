// // import 'package:admin/Admin/Products/addProductScreen.dart';
// // import 'package:admin/Admin/Products/editProductScreen.dart';
// // import 'package:admin/Admin/Products/productModel.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import '../../image.dart';
// // import '../../image.dart';
// //
// // class productScreen extends StatefulWidget {
// //   const productScreen({super.key});
// //
// //   @override
// //   State<productScreen> createState() => _productScreenState();
// // }
// //
// // class _productScreenState extends State<productScreen> {
// //   late TextEditingController searchContrller;
// //   late String searchQuery;
// //
// //   @override
// //   void initState(){
// //     super.initState();
// //     searchContrller = TextEditingController();
// //     searchQuery="";
// //   }
// //   void _deleteProduct(String productID){
// //     FirebaseFirestore.instance.collection("products").doc(productID).delete().then((value) {
// //       Fluttertoast.showToast(msg: "Product Deleted Successfully",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.green,textColor: Colors.white);
// //     }).catchError((error){
// //       Fluttertoast.showToast(msg: "Failed to delete Product",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.red,textColor: Colors.white);
// //     });
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Products",style: TextStyle(fontWeight: FontWeight.bold),),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
// //           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ElevatedButton(onPressed: (){
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) => addProductScreen()));
// //               },style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))) ,
// //                   child: Text("Add Product",style: TextStyle(color: Colors.white),)),
// //
// //               SizedBox(height: 10,),
// //
// //               Container(
// //                 // height: 45,
// //                 // width: double.infinity,
// //                 child: TextFormField(
// //                   controller: searchContrller,
// //                   decoration: InputDecoration(
// //                       border: OutlineInputBorder(
// //                         borderSide: BorderSide(color: Colors.black),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                           borderSide: BorderSide(color: Colors.green)
// //                       ),
// //                       hintText: "Search Product...",
// //                       prefixIcon: Icon(Icons.search)
// //
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: 5,),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   Text("Sr.No",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
// //                   Text("Product Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
// //                   Text("Product Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
// //
// //                 ],
// //               ),
// //               productList(deleteProduct: _deleteProduct, searchQuery: searchQuery)
// //
// //
// //             ],
// //           ),
// //         ),
// //       ),
// //
// //     );
// //   }
// // }
// //
// // class productList extends StatelessWidget {
// //   final Function(String) deleteProduct;
// //   final String searchQuery;
// //
// //   const productList({Key? key, required this.deleteProduct, required this.searchQuery});
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder(stream: FirebaseFirestore.instance.collection("products").snapshots(),
// //         builder: (context, snapshot){
// //       if(!snapshot.hasData){
// //         return const CircularProgressIndicator();
// //       }
// //       final productDocs = snapshot.data!.docs;
// //       List<productModel> products = [];
// //
// //       for(var doc in productDocs){
// //         final product = productModel.fromSnapshot(doc);
// //         products.add(product);
// //       }
// //       List<productModel> filteredProducts = products.where((product) =>
// //           product.productName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
// //       return ListView.builder(
// //           shrinkWrap: true,
// //       physics: const NeverScrollableScrollPhysics(),
// //       itemCount: filteredProducts.length,
// //       itemBuilder: (context, index){
// //         final  productModel product =  filteredProducts[index];
// //         return Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Expanded(child: Text((index + 1).toString())),
// //                 // Spacer(),
// //                 Expanded(child: Text(product.productName,style: TextStyle(fontSize: 17),)),
// //                 // Spacer(),
// //                 Expanded(
// //                   child: Image.network(
// //                     product.image.isNotEmpty? product.image[0] : '',
// //                     width: 120,
// //                     height: 50,
// //                   ),
// //                 )
// //               ],
// //             ),
// //             SizedBox(height: 10,),
// //
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 Padding(padding: EdgeInsets.only(right: 100),
// //                 child: Container(
// //                   height: 35,
// //                     width: 60,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(4),
// //                     border: Border.all(color: Colors.black)
// //                   ),
// //                   child: TextButton(
// //                     onPressed: (){
// //                       Navigator.push(context, MaterialPageRoute(builder: (context) => editProductScreen(product: product,image: product.image)));
// //                     },
// //                     child: Text("Edit",style: TextStyle(fontSize: 12),),
// //                   ),
// //                 ),),
// //                 Padding(padding: EdgeInsets.only(right: 30),
// //                   child: Container(
// //                     width: 60,
// //                       height: 35,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(4),
// //                       border: Border.all(color: Colors.black)
// //                     ),
// //                     child: TextButton(
// //                       onPressed: (){
// //                         showDialog(context: context, builder: (BuildContext context){
// //                           return AlertDialog(
// //                             title: Text("Confirm Deletion"),
// //                             content: Text("Are you sure?\nYou want to delete this Product"),
// //                             actions: [
// //                               TextButton(onPressed: (){
// //                                 Navigator.of(context).pop();
// //                               }, child: Text("Cancel")),
// //                               TextButton(onPressed: (){
// //                                 deleteProduct(product.id);
// //                                 Navigator.of(context).pop();
// //                               }, child: Text("Yes"))
// //                             ],
// //                           );
// //                         });
// //                       },
// //                       child: Text("Delete",style: TextStyle(fontSize: 12),),
// //                     ),
// //                   ) ,)
// //               ],
// //             )
// //           ],
// //         ),);
// //       });
// //         });
// //   }
// // }
//
//
// //
// // import 'package:StyleHub/Seller/Products/productModel.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // import 'addProductScreen.dart';
// // import 'editProductScreen.dart';
// //
// // class ProductScreen extends StatefulWidget {
// //   const ProductScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<ProductScreen> createState() => _ProductScreenState();
// // }
// //
// // class _ProductScreenState extends State<ProductScreen> {
// //   late TextEditingController searchController;
// //   late String searchQuery;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     searchController = TextEditingController();
// //     searchQuery = "";
// //   }
// //
// //   void _deleteProduct(String productId) {
// //     FirebaseFirestore.instance.collection("products").doc(productId).delete().then((value) {
// //       Fluttertoast.showToast(
// //         msg: "Product Deleted Successfully",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         backgroundColor: Colors.green,
// //         textColor: Colors.white,
// //       );
// //     }).catchError((error) {
// //       Fluttertoast.showToast(
// //         msg: "Failed to delete Product",
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //         backgroundColor: Colors.red,
// //         textColor: Colors.white,
// //       );
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Products",
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) => addProductScreen()));
// //               },
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: Colors.lightBlue,
// //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
// //               ),
// //               child: Text(
// //                 "Add Product",
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ),
// //
// //
// //             const SizedBox(height: 10),
// //             Container(
// //               width: double.infinity,
// //               height: 55,
// //               child: TextFormField(
// //                 controller: searchController,
// //                 onChanged: (value) {
// //                   setState(() {
// //                     searchQuery = value;
// //                   });
// //                 },
// //                 decoration: const InputDecoration(
// //                   border: OutlineInputBorder(
// //                     borderSide: BorderSide(color: Colors.black),
// //                   ),
// //                   focusedBorder: OutlineInputBorder(
// //                       borderSide: BorderSide(color: Colors.green)
// //                   ),
// //                   hintText: 'Search Product ...',
// //                   prefixIcon: Icon(Icons.search),
// //
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: 10),
// //             Expanded(
// //               child: ProductList(deleteProduct: _deleteProduct, searchQuery: searchQuery),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // class ProductList extends StatelessWidget {
// //   final Function(String) deleteProduct;
// //   final String searchQuery;
// //
// //   const ProductList({Key? key, required this.deleteProduct, required this.searchQuery}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: FirebaseFirestore.instance.collection("products").snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(child: CircularProgressIndicator());
// //         }
// //         final productDocs = snapshot.data!.docs;
// //         List<productModel> products = [];
// //
// //         for (var doc in productDocs) {
// //           final product = productModel.fromSnapshot(doc);
// //           products.add(product);
// //         }
// //
// //         List<productModel> filteredProducts = products.where((product) => product.productName.toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
// //
// //         return GridView.builder(
// //           shrinkWrap: true,
// //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //             crossAxisCount: 2,
// //             childAspectRatio: 0.75,
// //             mainAxisSpacing: 20,
// //             crossAxisSpacing: 20,
// //           ),
// //           itemCount: filteredProducts.length,
// //           itemBuilder: (context, index) {
// //             final productModel product = filteredProducts[index];
// //             String imageUrl = product.image!.isNotEmpty ? product.image![0]: '';
// //             return GestureDetector(
// //               onTap: () {
// //                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(product: product, imageUrls: imageUrl,)));
// //               },
// //               child: Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(15),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.grey.withOpacity(0.3),
// //                       spreadRadius: 2,
// //                       blurRadius: 5,
// //                       offset: Offset(0, 3),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
// //                       child: product.image.isNotEmpty
// //                           ? Image.network(
// //                         product.image[0],
// //                         width: double.infinity,
// //                         height: 160,
// //                         fit: BoxFit.cover,
// //                       )
// //                           : Icon(Icons.image),
// //                     ),
// //                     Padding(
// //                       padding: EdgeInsets.all(10),
// //                       child: Text(
// //                         product.productName,
// //                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                         maxLines: 3,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         // IconButton(
// //                         //   icon: Icon(Icons.edit),
// //                         //   color: Colors.blueAccent,
// //                         //   onPressed: () {
// //                         //     Navigator.push(context, MaterialPageRoute(builder: (context) => EditProductScreen(product: product, imageUrls: product.image, image: product.image)));
// //                         //   },
// //                         // ),
// //                         IconButton(
// //                           icon: Icon(Icons.delete),
// //                           color: Colors.red,
// //                           onPressed: () {
// //                             showDialog(
// //                               context: context,
// //                               builder: (BuildContext context) {
// //                                 return AlertDialog(
// //                                   title: Text("Confirm Deletion"),
// //                                   content: Text("Are you sure you want to delete this product?"),
// //                                   actions: [
// //                                     TextButton(
// //                                       onPressed: () {
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                       child: Text("Cancel"),
// //                                     ),
// //                                     TextButton(
// //                                       onPressed: () {
// //                                         deleteProduct(product.id);
// //                                         Navigator.of(context).pop();
// //                                       },
// //                                       child: Text("Yes"),
// //                                     ),
// //                                   ],
// //                                 );
// //                               },
// //                             );
// //                           },
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
//
//

import 'package:StyleHub/Seller/Products/addProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:StyleHub/Seller/Products/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'editProductScreen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchQuery = "";
  }

  void _deleteProduct(String productId) {
    FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .delete()
        .then((value) {
      print('Product deleted successfully');
    }).catchError((error) {
      print('Failed to delete product: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const addProductScreen()));
                // Add product button logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text(
                "Add Product",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  hintText: 'Search Product ...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ProductList(
                  deleteProduct: _deleteProduct, searchQuery: searchQuery),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: _onTabTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.lightBlue,
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       backgroundColor: Colors.lightBlue,
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Orders',
      //     ),
      //   ],
      // ),
    );
  }
}

class ProductList extends StatelessWidget {
  final Function(String) deleteProduct;
  final String searchQuery;

  const ProductList(
      {Key? key, required this.deleteProduct, required this.searchQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final productDocs = snapshot.data!.docs;
        List<productModel> products = [];

        for (var doc in productDocs) {
          final product = productModel.fromSnapshot(doc);
          products.add(product);
        }

        List<productModel> filteredProducts = products
            .where((product) => product.productName
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
            .toList();

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final productModel product = filteredProducts[index];
            String imageUrl =
                product.image.isNotEmpty ? product.image[0] : '';
            return GestureDetector(
              onTap: () {
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      child: product.image.isNotEmpty
                          ? Image.network(
                              product.image[0],
                              width: double.infinity,
                              height: 160,
                              // fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        product.productName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProductScreen(
                                        product: product,
                                        imageUrls: imageUrl,
                                        image: product.image)));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm Deletion"),
                                  content: const Text(
                                      "Are you sure you want to delete this product?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteProduct(product.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Yes"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
    );
  }
}

//testing code
// import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
// import 'package:StyleHub/Seller/Products/productModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../subcategory/subCategoryModel.dart';
//
//
// class ProductScreen extends StatefulWidget {
//   final subCategoryModel selectedSubCategory;
//
//   const ProductScreen({Key? key, required this.selectedSubCategory, required List<productModel> products})
//       : super(key: key);
//
//   @override
//   State<ProductScreen> createState() => _ProductScreenState();
// }
//
// class _ProductScreenState extends State<ProductScreen> {
//   CollectionReference ProductRef =
//   FirebaseFirestore.instance.collection("Products");
//
//   Future<List<productModel>> readProduct() async {
//     try {
//       // Query Firestore for all products
//       QuerySnapshot response = await ProductRef.get();
//
//       // Convert QuerySnapshot to a list of ProductModel
//       List<productModel> products =
//       response.docs.map((e) => productModel.fromSnapshot(e)).toList();
//
//       // Filter products based on the selected subcategory
//       List<productModel> filteredProducts = products
//           .where((element) =>
//       element.subCategory == widget.selectedSubCategory.subCategory)
//           .toList();
//
//       return filteredProducts;
//     } catch (error) {
//       print("Error reading products: $error");
//       rethrow; //
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: SizedBox(
//               width: 340,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Search ...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: FutureBuilder<List<productModel>>(
//           future: readProduct(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: Image.asset(
//                   "assets/images/image5.jpg",
//                   height: 500,
//                   width: 500,
//                 ),
//               );
//             } else {
//               List<productModel> products = snapshot.data!;
//               return SingleChildScrollView(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10.0,
//                     mainAxisSpacing: 10.0,
//                   ),
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index];
//
//                     return InkWell(
//                       onTap: ()
//                       {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(data: data)));
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.5),
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Image.network(
//                                   product.image![0],
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 product.productName,
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     product.productPrice,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 5),
//                                   const Icon(
//                                     Icons.star,
//                                     color: Colors.orange,
//                                     size: 16,
//                                   ),
//                                   const Text(
//                                     '4.5', // Add your product rating here
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black54,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
