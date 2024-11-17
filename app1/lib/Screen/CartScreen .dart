import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: FutureBuilder(
        future: _getUserCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Your cart is empty.'));
          }

          final cartItems = snapshot.data!;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];

              return ListTile(
                leading: Image.memory(
                  base64Decode(cartItem['Image']),
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(cartItem['protitle']),
                subtitle: Text('\$${cartItem['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    _removeFromCart(cartItem['productId']);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getUserCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return [];
    }

    String userId = user.uid;

    try {
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('user_cart')
          .doc(userId)
          .collection('products')
          .get();

      return cartSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (error) {
      Fluttertoast.showToast(msg: "Error fetching cart: $error");
      return [];
    }
  }

  void _removeFromCart(String productId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: "User not logged in");
      return;
    }

    String userId = user.uid;

    try {
      await FirebaseFirestore.instance
          .collection('user_cart')
          .doc(userId)
          .collection('products')
          .doc(productId)
          .delete();

      Fluttertoast.showToast(msg: "Product removed from cart");
      setState(() {});
    } catch (error) {
      Fluttertoast.showToast(msg: "Error removing product: $error");
    }
  }
}
