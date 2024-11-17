import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to AddProduct page (assuming this exists)
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddProduct()));
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products found.'));
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              final productId = products[index].id; 

              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    product['Image'] != null
                        ? Image.memory(
                            base64Decode(product['Image']),
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 120,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['protitle'] ?? 'No Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            product['Description'] ?? 'No Description',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Price: \$${product['price'] ?? 'N/A'}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  _addToCart(productId);  // Function to add to cart
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _addToCart(String productId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return;
    }

    String userId = user.uid;

    CollectionReference cartRef = FirebaseFirestore.instance.collection('user_cart').doc(userId).collection('products');

    try {
      var cartDoc = await cartRef.doc(productId).get();

      if (cartDoc.exists) {
        Fluttertoast.showToast(msg: "Product is already in your cart");
      } else {
        final product = await FirebaseFirestore.instance.collection('products').doc(productId).get();

        if (product.exists) {
          var productData = product.data() as Map<String, dynamic>;
          await cartRef.doc(productId).set({
            'protitle': productData['protitle'],
            'Description': productData['Description'],
            'price': productData['price'],
            'Image': productData['Image'],
            'quantity': 1,
            'addedAt': Timestamp.now(),
          });

          Fluttertoast.showToast(msg: "Product added to cart");
        } else {
          Fluttertoast.showToast(msg: "Product not found");
        }
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error adding product to cart: $error");
    }
  }
}
