import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  String? _uploadedImageBase64;
  String? _selectedCategory;
  List<String> _categoryTitles = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories when the widget is initialized
  }

  // Function to fetch category titles from Firebase Realtime Database
 Future<void> _fetchCategories() async {
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  DataSnapshot snapshot = await databaseRef.get();
  
  if (snapshot.exists) {
    final posts = Map<String, dynamic>.from(snapshot.value as Map);

    setState(() {
      // Cast each title to String and ensure it's not null or empty
      _categoryTitles = posts.entries
          .map((entry) => entry.value['Title']?.toString() ?? '')
          .where((title) => title.isNotEmpty)
          .toList();
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Product Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Product Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: "Product Price"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Category Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                items: _categoryTitles.map((title) {
                  return DropdownMenuItem<String>(
                    value: title,
                    child: Text(title),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _pickImage((base64) {
                  setState(() {
                    _uploadedImageBase64 = base64;
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
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

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('products').add({
          'protitle': titleController.text,
          'Description': descriptionController.text,
          'price': priceController.text,
          'Image': _uploadedImageBase64,
          'Category': _selectedCategory, // Store the selected category
        });
        Fluttertoast.showToast(msg: "Product added successfully");
        Navigator.pop(context); // Go back to the previous screen
      } catch (error) {
        Fluttertoast.showToast(msg: "Error adding product: $error");
      }
    }
  }
}
