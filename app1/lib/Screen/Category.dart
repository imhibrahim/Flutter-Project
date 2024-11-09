import 'package:app1/Screen/Cart.dart';
import 'package:app1/Screen/Edit_Category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:app1/Screen/AllUsers.dart';
import 'package:app1/Screen/Category.dart';
import 'package:app1/Screen/Feedback.dart';
import 'package:app1/Screen/Product.dart';
import 'package:app1/Screen/Register.dart';
import 'package:app1/Screen/Wishlist.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // Define your Firebase database reference
 // final DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('');
  final FirebaseAuth auth= FirebaseAuth.instance;
  final DatabaseRef=FirebaseDatabase.instance.ref("Post");

  void DeleteCategory(String id) async{
    await DatabaseRef.child(id).remove();
    print("Category Deleted");
    Fluttertoast.showToast(msg: "Your Category is Deleted!!!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      drawer: Drawer(
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
                Navigator.pop(context); // Close drawer without pushing a new route
              },
            ),
            ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: Text("Product"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Product()));
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
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 1000,
          height: 1000,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: const Color.fromARGB(255, 68, 227, 255),
              width: 2,
            ),
          ),
          child: FirebaseAnimatedList(
            query: DatabaseRef,
            itemBuilder: (context, snapshot, animation, index){
              // Extract data from snapshot
              String postId=snapshot.key!;
              String title=snapshot.child("Title").value as String? ?? 'No Title Found';
              String description=snapshot.child("Description").value as String? ?? 'No Description Found';
             // final data = snapshot.value as Map;
              return ListTile(
                title:
                Text(title,style: TextStyle(
      fontWeight: FontWeight.bold, // Makes the text bold
    ),),
                subtitle: Text(description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: (){
Navigator.pushReplacement(context,
 MaterialPageRoute(
  builder: (context)=>EditCategories(
    postId:postId,title:title,description:description
    )),
);
            },
                     icon: Icon(Icons.edit_document,color: Colors.blueAccent,)),


                    IconButton(
                      onPressed: (){
                        DeleteCategory(postId);
                      },
                     icon: Icon(Icons.delete_forever,color: Colors.red,)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
