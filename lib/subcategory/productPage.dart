// import 'package:StyleHub/Seller/Products/producrDetailScreen.dart';
// import 'package:StyleHub/subcategory/subCategoryModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../Seller/Products/productModel.dart';
//
// class ProductPage extends StatefulWidget {
//   final subCategoryModel selectedSubCategory;
//
//   const ProductPage(
//       {Key? key,
//       required this.selectedSubCategory,
//       required List<ProductModel> products})
//       : super(key: key);
//
//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }
//
// class _ProductPageState extends State<ProductPage> {
//   CollectionReference ProductRef =
//       FirebaseFirestore.instance.collection("products");
//
//   Future<List<ProductModel>> readProduct() async {
//     try {
//       // Query Firestore for all products
//       QuerySnapshot response = await ProductRef.get();
//
//       // Convert QuerySnapshot to a list of ProductModel
//       List<ProductModel> products =
//           response.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
//
//       // Filter products based on the selected subcategory
//       List<ProductModel> filteredProducts = products
//           .where((element) =>
//               element.brand == widget.selectedSubCategory.subCategory)
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
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: FutureBuilder<List<ProductModel>>(
//           future: readProduct(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: Image.asset(
//                   "assets/icons/imgs.jpg",
//                   height: 500,
//                   width: 500,
//                 ),
//               );
//             } else {
//               List<ProductModel> products = snapshot.data!;
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
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ProductDetails(
//                                       product: product,
//                                     )));
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
//                                   product.images![0],
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
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
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



import 'package:StyleHub/subcategory/subCategoryModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Seller/Products/producrDetailScreen.dart';
import '../Seller/Products/productModel.dart';

class ProductPage extends StatefulWidget {
  final subCategoryModel seletedBrand;

  ProductPage({Key? key, required this.seletedBrand, required List<ProductModel> products}): super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  CollectionReference productRef = FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> readProduct() async {
    try {
      // Query Firestore for all products
      QuerySnapshot response = await productRef.get();

      // Convert QuerySnapshot to a list of ProductModel
      List<ProductModel> products =
      response.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      // Filter products based on the selected subcategory
      List<ProductModel> filteredProducts = products
          .where((element) => element.brand == widget.seletedBrand.subCategory)
          .toList();

      return filteredProducts;
    } catch (error) {
      print("Error reading products: $error");
      rethrow; //
    }
  }


  // Future<List<ProductModel>> readProduct() async
  // {
  //   QuerySnapshot response = await productRef.get();
  //   return response.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: FutureBuilder<List<ProductModel>>(
            future: readProduct(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty){
                return Center(child: Text('No products available'));
              }

              final productDocs = snapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: productDocs.map((product) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProductCard(product: product,),
                    );
                  }).toList(),
                ),
              );
            }
        )
    );
  }
}


class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductDetails(product: product)),
          );
        },
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  // width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.images![0], // Displaying only the first image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  product.productName,
                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      '₹ ${product.productPrice}',
                      style: TextStyle(
                        // color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                        // decorationColor: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'M.R.P ₹ ${product.newPrice}',
                      style: const TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


