import 'package:app1/Screen/Cart.dart';
import 'package:app1/Screen/productList.dart';
import 'package:app1/Screen/productsCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app1/Screen/AllUsers.dart';
import 'package:app1/Screen/Category.dart';
import 'package:app1/Screen/Feedback.dart';
import 'package:app1/Screen/Product.dart';
import 'package:app1/Screen/Register.dart';
import 'package:app1/Screen/Wishlist.dart';

class Add_Product extends StatefulWidget {
  const Add_Product({super.key});

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {

    final titleController=TextEditingController();
  final descController=TextEditingController();
//add reference
final DatabaseRef =FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Add To Post"),
      ),drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  "Watch Hub...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: const Color.fromARGB(201, 248, 138, 4),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
              },
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: Text("Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("User"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Allusers()));
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Feedbackpage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Wishlist"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Wishlist()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Cart"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Products card"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCard()));
              },
            ),
          ],
        ),
      ),
      body: 
     Padding(
       padding: const EdgeInsets.all(18.0),
       child: Column(
        children: [
          Text("Add Post"),

          SizedBox(height: 21,),
          TextFormField(
            controller:titleController,
            decoration: InputDecoration(hintText: "Add Title", border: OutlineInputBorder()),),
            
           SizedBox(height: 21,),
          TextFormField(
            controller:descController,
            decoration: InputDecoration(hintText: "Add Description", border: OutlineInputBorder()),),
          SizedBox(height: 21,),
          IconButton(onPressed: (){
             DatabaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).set(
              {
             'Title':titleController.text.toString(),
             'Description':descController.text.toString(),
              }
             ).then((value){
              print("Data Inserted Seccfully ...!");
              //alert
                Fluttertoast.showToast(msg: "Data inserted Successfully added ....");
    //clear feilds
    titleController.clear();
    descController.clear();
             }).onError((Error,Stack){
 print("Data Inserted Failed...!");
  //alert
                Fluttertoast.showToast(msg: "Data inserted Failed ....!");
             });
          }, icon: Icon(Icons.add_task))
        ],
       
       ),
     )
    );
  }
}