import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:app1/Screen/addproduct.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddProduct()),); // Change to your AddProduct route
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

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              final productId = products[index].id; // Get product document ID

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      product['Image'] != null
                          ? Image.memory(
                              base64Decode(product['Image']),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['protitle'] ?? 'No Title',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              product['Description'] ?? 'No Description',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Price: \$${product['price'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      // Edit button
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Call edit function and pass product data
                          _editProduct(context, productId, product);
                        },
                      ),
                      // Delete button
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Call delete function
                          _deleteProduct(productId);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _editProduct(BuildContext context, String productId, Map<String, dynamic> product) {
    final proController = TextEditingController(text: product['protitle']);
    final desController = TextEditingController(text: product['Description']);
    final priceController = TextEditingController(text: product['price'].toString());
    String? _uploadedImageBase64 = product['Image']; // Initialize with current image data

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Product"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: proController,
                  decoration: InputDecoration(labelText: "Product Title"),
                ),
                TextFormField(
                  controller: desController,
                  maxLines: 3,
                  decoration: InputDecoration(labelText: "Product Description"),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: "Product Price"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _pickImage((base64) {
                    setState(() {
                      _uploadedImageBase64 = base64; // Update with new image data
                    });
                  }),
                  child: Text("Select Image"),
                ),
                if (_uploadedImageBase64 != null)
                  Image.memory(
                    base64Decode(_uploadedImageBase64!),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _updateProduct(productId, proController.text, desController.text, priceController.text, _uploadedImageBase64);
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context), // Close the dialog
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(Function(String) onImagePicked) async {
    if (kIsWeb) {
      final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((e) async {
          final Uint8List data = reader.result as Uint8List;
          String base64Image = base64Encode(data);
          onImagePicked(base64Image);
          Fluttertoast.showToast(msg: "Image selected successfully");
        });
      });
    } else {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Uint8List data = await image.readAsBytes();
        String base64Image = base64Encode(data);
        onImagePicked(base64Image);
        Fluttertoast.showToast(msg: "Image selected successfully");
      }
    }
  }

  Future<void> _updateProduct(String productId, String title, String description, String price, String? imageBase64) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).update({
        'protitle': title,
        'Description': description,
        'price': price,
        'Image': imageBase64,
      });
      Fluttertoast.showToast(msg: "Product updated successfully");
    } catch (error) {
      Fluttertoast.showToast(msg: "Error updating product: $error");
    }
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      Fluttertoast.showToast(msg: "Product deleted successfully");
    } catch (error) {
      Fluttertoast.showToast(msg: "Error deleting product: $error");
    }
  }
}
